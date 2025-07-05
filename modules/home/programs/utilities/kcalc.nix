{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.utilities;
  cfg = cfg'.kcalc;
in
{
  options.elysium.programs.utilities.kcalc.enable = lib.mkEnableOption "Kcalc" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.kdePackages.kcalc ];
  };
}
