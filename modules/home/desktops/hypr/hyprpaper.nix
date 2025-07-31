{
  config,
  lib,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.hypr;
  cfg = cfg'.paper;
in
{
  options.elysium.desktops.hypr.paper.enable = lib.mkEnableOption "Hyprpaper" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    elysium.desktops.exec-once = [ "hyprpaper" ];
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "${lib.elysium.relativeToRoot "wallpapers/stars.png"}" ];
        wallpaper = [ ",${lib.elysium.relativeToRoot "wallpapers/stars.png"}" ];
      };
    };
  };
}
