{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.apperance.enable = lib.mkEnableOption "Apperence Settings" // {
    default = config.elysium.desktops.enable;
  };
}
