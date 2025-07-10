{ config, lib, ... }:

let
  hmCfg = config.hm.elysium.programs.internet.kdeconnect;
in
{
  networking.firewall = {
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
