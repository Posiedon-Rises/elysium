{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.swaync;
in
{
  options.elysium.desktops.swaync.enable = lib.mkEnableOption "Sway Notification Center";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    services.swaync = {
      enable = true;
      style = ./style.css;
    };

    elysium.desktops.exec-once = [ "swaync" ];
  };
}
