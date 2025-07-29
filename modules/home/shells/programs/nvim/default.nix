{
  config,
  lib,
  pkgs,
  ...
}:

let
  devCfg = config.elysium.development;
  langCfg = devCfg.languages;

  cfg = config.elysium.shells.programs.neovim;
in
{
  options.elysium.shells.programs.neovim.enable = lib.mkEnableOption "Neovim and nvf" // {
    default = true;
  };
  config = lib.mkIf cfg.enable {
    # Enable fzf
    elysium.shells.programs.fzf.enable = lib.mkDefault true;

    programs.neovim = {
      enable = true;

    };

    programs.nvf = {
      enable = true;

      settings.vim = {

        # Visuals
        theme = {
          enable = true;
          name = "tokyonight";
          style = "moon";
        };

        statusline.lualine = {
          enable = true;
          theme = "auto";
          componentSeparator = {
            left = "";
            right = "";
          };
        };

        utility.outline.aerial-nvim = {
          enable = true;
          mappings.toggle = "<leader>a";
        };

        visuals = {
          indent-blankline.enable = true;
        };

        options = {
          expandtab = false;
          tabstop = 2;
          shiftwidth = 2;
          mouse = "";
          linebreak = true;
        };

        # Programming

        autocomplete.blink-cmp.enable = true;

        git.neogit.enable = true;

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;

          trouble = {
            enable = true;
            setupOpts = {
              auto_close = true;
              modes.diagnostics.auto_open = true;
            };
          };
        };

        treesitter = {
          enable = true;
          textobjects.enable = true;
        };

        mini = {
          surround = {
            enable = true;

            # Replaces surrond mappings with 'gs' varients
            setupOpts.mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };

          pairs.enable = true;
        };

        projects.project-nvim = {
          enable = true;
          setupOpts.manual_mode = false;
        };

        languages = {
          enableDAP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix = lib.mkIf langCfg.nix.enable {
            enable = true;

            format.type = "nixfmt";

            lsp = {
              server = "nixd";

              options = {
                formatting.command = "nix fmt";

                nixos.expr = "(builtins.getFlake (\"git+file://\" + lib.elysium.relativeToRoot ./.)).nixosConfigurations.Hydra.options";
                home-manager.expr = "(builtins.getFlake (\"git+file://\" + lib.elysium.relativeToRoot ./.)).nixosConfigurations.Hydra.options.home-manager.users.type.getSubOptions []";
              };
            };
          };

          lua = lib.mkIf langCfg.lua.enable {
            enable = true;

            lsp.lazydev.enable = true;
          };

          markdown = {
            enable = true;
            format.type = "prettierd";
            extensions.render-markdown-nvim.enable = true;
          };

          rust = lib.mkIf langCfg.rust.enable {
            enable = true;
            crates.enable = true;

            format.package = langCfg.rust.toolchain.rustfmt;
          };
        };

        autocmds = [
          {
            event = [ "FileType" ];
            pattern = [ "markdown" ];
            callback = lib.mkLuaInline ''
              	function()
              		vim.opt_local.textwidth=80
                	vim.opt_local.formatoptions:append("t")
                end
            '';
          }
        ];
        # Other

        clipboard = {
          enable = true;
          registers = "unnamedplus";
        };

        terminal.toggleterm = {
          enable = true;
          setupOpts.direction = "float";
        };

        telescope = {
          enable = true;

          extensions = [
            {
              name = "fzf";
              packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }

            {
              name = "project";
              packages = [ pkgs.vimPlugins.telescope-project-nvim ];
              setup = { };
            }

            {
              name = "file_browser";
              packages = [ pkgs.vimPlugins.telescope-file-browser-nvim ];
              setup = { };
            }

            {
              name = "manix";
              packages = [ pkgs.vimPlugins.telescope-manix ];
              setup = { };
            }
          ];
        };

        # Keymaps

        keymaps = [
          {
            key = "<leader>fb";
            mode = "n";
            action = "<cmd>:Telescope file_browser<CR>";
          }
          {
            key = "<leader>fds";
            mode = "n";
            action = "<cmd>:Telescope lsp_document_symbols<CR>";
          }
          {
            key = "<leader>git";
            mode = "n";
            action = "<cmd>:Neogit<CR>";
          }
          {
            key = "<c-T>";
            mode = "t";
            action = "<cmd>:ToggleTerm<CR>";
          }
        ];
      };
    };
  };
}
