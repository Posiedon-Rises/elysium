{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.desktops.desktops.hyprland;
  cfg = cfg'.plugins;
in
{
  options.elysium.desktops.desktops.hyprland.plugins = {
    dynamicCursor.enable = lib.mkEnableOption "Dynamic Cursor Plugin" // {
      default = cfg'.enable;
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    wayland.windowManager.hyprland = {
      plugins = lib.optional (cfg.dynamicCursor.enable) pkgs.hyprlandPlugins.hypr-dynamic-cursors;
    };

    settings.plugin = {
      dynamic-cursors = {
        enabled = cfg.dynamicCursor.enable;
        mode = "tilt";
        tilt.limit = 2500;
        shake.enabled = false;
      };
    };
  };
}
