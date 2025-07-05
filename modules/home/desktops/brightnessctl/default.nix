{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.brightnessctl;
in
{
  options.elysium.desktops.brightnessctl.enable = lib.mkEnableOption "brightnessctl";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.brightnessctl ];
  };
}
