{ config, lib, ... }:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.waybar;
in
{
  options.elysium.desktops.waybar.enable = lib.mkEnableOption "Waybar";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.waybar.enable = true;

    home.file."${config.xdg.configHome}/waybar" = {
      source = ./config;
      recursive = true;
    };

    elysium.desktops.exec-once = [ "waybar" ];
  };
}
