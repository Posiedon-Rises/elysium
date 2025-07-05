{ config, lib, ... }:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.clipboard;
  cfg = cfg'.cliphist;
in
{
  options.elysium.desktops.clipboard.cliphist.enable = lib.mkEnableOption "ClipHist" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    services.cliphist.enable = true;
    elysium.desktops.exec-once = [ "wl-paste --watch cliphist store" ];
  };
}
