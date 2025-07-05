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
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      pictures = "${config.home.homeDirectory}/Media/Images";
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Music";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = [ "zen.desktop" ];
        "text/html" = [ "zen.desktop" ];
        "x-scheme-handler/http" = [ "zen.desktop" ];
        "x-scheme-handler/https" = [ "zen.desktop" ];
        "x-scheme-handler/about" = [ "zen.desktop" ];
        "x-scheme-handler/unknown" = [ "zen.desktop" ];
      };
    };
  };

  home.sessionVariables = {
    GTK_USE_PORTAL = 1;
    MOZ_ENABLE_WAYLAND = 0;
  };
}
