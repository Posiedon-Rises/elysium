{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.shells;
  cfg = cfg'.shells.zsh;
in
{
  options.elysium.shells.shells.zsh = {
    enable = lib.mkEnableOption "Zsh";
    package = lib.elysium.mkStaticPackageOption (lib.elysium.getCfgPkg config.programs.zsh);
  };

  config = lib.mkIf cfg.enable {

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestion.enable = true;

      localVariables.HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = 1;

      shellAliases = cfg'.shellAliases;

      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
      ];

      history = {
        size = cfg'.historySize;
        save = config.programs.zsh.history.size;
        path = "${config.xdg.stateHome}/zsh/history";

        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
      };

      initExtra = builtins.readFile ./init-extra.zsh;

      historySubstringSearch.enable = true;
    };
  };
}
