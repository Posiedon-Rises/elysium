{ config, lib, ... }:

let
  cfg = config.elysium.boot.loader;
in
{
  options.elysium.boot.loader.grub = {
    enable = lib.mkEnableOption "Grub bootloader" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.grub.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };
}
