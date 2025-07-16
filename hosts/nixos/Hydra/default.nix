{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  hostSpec = {
    hostName = "Hydra";
    isDesktop = true;
  };
}
