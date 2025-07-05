{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.hypr;
  cfg = cfg'.lock;
in
{
  options.elysium.desktops.hypr.picker.enable = lib.mkEnableOption "Hyprpicker" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.hyprpicker ];
  };
}
