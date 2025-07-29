{ config, lib, ... }:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.quickshell;
in
{
  options.elysium.desktops.quickshell.enable = lib.mkEnableOption "Quickshell UI";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    #home.file.".config/quickshell" = {
    #	source = ./config;
    #	recursive = true;
    #};

    programs.quickshell.enable = true;

    elysium.desktops.exec-once = [ "quickshell" ];
  };
}
