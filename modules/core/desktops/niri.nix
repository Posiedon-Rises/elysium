{ config, lib, ... }:

let
  hmCfg = config.hm.elysium.desktops.desktops.niri;
  cfg' = config.elysium.desktops;
  cfg = cfg'.desktops.niri;
in
{
  options.elysium.desktops.desktops.niri = {
    enable = lib.mkEnableOption "Niri" // {
      default = hmCfg.enable;
    };
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.niri.enable = true;
  };
}
