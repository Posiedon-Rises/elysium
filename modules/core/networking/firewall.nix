{ config, lib, ... }:

{
  networking.firewall = {
    allowedUDPPortRanges = (lib.optional (config.hm.elysium.programs.internet.kdeconnect.enable)) [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
