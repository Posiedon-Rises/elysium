{
  config,
  lib,
  pkgs,
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
        preload = [ "~/.dotfiles/wallpapers/blacklotus-nix.png" ];
        wallpaper = [ ",~/.dotfiles/wallpapers/blacklotus-nix.png" ];
      };
    };
  };
}
