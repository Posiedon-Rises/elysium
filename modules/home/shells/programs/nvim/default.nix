{
  config,
  inputs,
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
          tabstop = 2;
          shiftwidth = 2;
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
        
        projects.project-nvim.enable = true;

        languages = {
          nix = lib.mkIf langCfg.nix.enable {
            enable = true;
            extraDiagnostics.enable = true;
            extraDiagnostics.types = [
              "deadnix"
              "statix"
            ];

            treesitter.enable = true;

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

            format.enable = true;
          };
        };

        # Other

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
        ];
      };
    };
  };
}
