{ config, lib, ... }:

let
  cfg' = config.elysium.programs.internet;
  cfg = cfg'.kdeconnect;
in
{
  options.elysium.programs.internet.kdeconnect.enable = lib.mkEnableOption "KDE Connect" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    services.kdeconnect.enable = true;
    elysium.desktops.exec-once = [ "kdeconnectd" ];
  };
}
