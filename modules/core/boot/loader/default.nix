{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;
  boot.loader.efi.canTouchEfiVariables = true;
}
