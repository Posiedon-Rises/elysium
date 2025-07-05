{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.desktops.hypr.enable = lib.mkEnableOption "Hypr* Programs";
}
