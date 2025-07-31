{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.activate-linux;
in
{
  options.elysium.desktops.activate-linux.enable = lib.mkEnableOption "Activate Linux Watermark";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.activate-linux ];
    elysium.desktops.exec-once = [
      "activate-linux -t 'Activate NixOS' -m 'Go to Dotfiles to activate NixOS' -s 0.9 --daemonize" # The scale is the smallest it can be without glitching */
    ];
  };
}
