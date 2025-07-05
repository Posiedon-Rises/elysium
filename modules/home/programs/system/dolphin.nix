{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.system;
  cfg = cfg'.dolphin;
in
{
  options.elysium.programs.system.dolphin.enable = lib.mkEnableOption "Dolphin" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.kdePackages.dolphin ];
  };
}
