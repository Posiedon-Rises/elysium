{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.xdg-desktop-portal
    pkgs.kdePackages.xdg-desktop-portal-kde
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    xdgOpenUsePortal = true;

    config = {
      common = {
        default = [ "kde" ];
      };
    };
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = 1;
    MOZ_ENABLE_WAYLAND = 0;
  };
}
