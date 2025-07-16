{ config, ... }:

{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      pictures = "${config.home.homeDirectory}/Media/Images";
      music = "${config.home.homeDirectory}/Media/Music";
      videos = "${config.home.homeDirectory}/Media/Music";
    };
  };
}
