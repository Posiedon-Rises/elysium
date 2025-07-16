{
  config,
  lib,
  pkgs,
  ...
}:

let
  devCfg = config.elysium.development;
  langCfg = devCfg.languages;
in
{
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

      visuals = {
        indent-blankline.enable = true;
      };

      options.tabstop = 4;

      # Programming

      autocomplete.blink-cmp.enable = true;

      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true;
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

          lsp = {
            server = "nixd";

            options = {
              formatting.command = "nix fmt";

              nixos.expr = "(builtins.getFlake (\"git+file://\" + lib.elysium.relativeToRoot ./.)).nixosConfigurations.Hydra.options";
              home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.Hydra.options.home-manager.users.type.getSubOptions []";
            };
          };
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
            name = "projects";
            packages = [ pkgs.vimPlugins.telescope-project-nvim ];
            setup = { };
          }

          {
            name = "browser";
            packages = [ pkgs.vimPlugins.telescope-file-browser-nvim ];
            setup = { };
          }
        ];
      };
    };
  };
}
