{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;
  networking = {
    hostName = config.hostSpec.hostName;
  };
}
