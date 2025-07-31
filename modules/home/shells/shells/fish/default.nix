{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.shells;
  cfg = cfg'.shells.fish;
in
{
  options.elysium.shells.shells.fish = {
    enable = lib.mkEnableOption "Fish";
    package = lib.elysium.mkStaticPackageOption (lib.elysium.getCfgPkg config.programs.fish);
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellInit = builtins.readFile ./init.fish;
      shellInitLast = builtins.readFile ./init-last.fish;

      shellAliases = cfg'.shellAliases;
    };
  };
}
