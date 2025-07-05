{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  config = {
    boot.initrd.systemd.enable = true;
  };
}
