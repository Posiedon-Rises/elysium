{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.playerctl;
in
{
  options.elysium.desktops.playerctl.enable = lib.mkEnableOption "playerctl";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.playerctl ];
  };
}
