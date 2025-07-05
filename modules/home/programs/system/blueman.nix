{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.system;
  cfg = cfg'.bluedevil;
in
{
  options.elysium.programs.system.bluedevil.enable = lib.mkEnableOption "Bluedevil" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.kdePackages.bluedevil ];
  };
}
