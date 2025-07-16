{ config, lib, ... }:

let
  cfg = config.elysium.networking.networkmanager;
in
{
  options.elysium.networking.networkmanager = {
    enable = lib.mkEnableOption "NetworkManager" // {
      default = true;
    };

    waitOnline = lib.mkEnableOption "Pause the boot process to wait for Internet to connet." // {
      default = config.hostSpec.isServer;
    };
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
    };

    systemd.services."NetworkManager-wait-online".enable = cfg.waitOnline;
  };
}
