{
  config,
  lib,
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
      autosuggestion = {
        enable = true;
        strategy = [ "completion" ];
      };

      syntaxHighlighting = {
        enable = true;
      };

      shellAliases = cfg'.shellAliases;

      history = {
        size = cfg'.historySize;
        save = config.programs.zsh.history.size;
        path = "${config.home.homeDirectory}/.zsh/history";

        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = true;
      };

      initExtra = builtins.readFile ./init-extra.zsh;
    };
  };
}
