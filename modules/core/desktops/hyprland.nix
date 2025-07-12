{ config, lib, ... }:

let
  hmCfg = config.hm.elysium.desktops.desktops.hyprland;
  cfg' = config.elysium.desktops;
  cfg = cfg'.desktops.hyprland;
in
{
  options.elysium.desktops.desktops.hyprland = {
    enable = lib.mkEnableOption "Hyprland" // {
      default = hmCfg.enable;
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.hyprland.enable = true;
  };
}
