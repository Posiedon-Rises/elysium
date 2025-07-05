{ config, lib, ... }:

let
  hmCfg = config.hm.elysium.desktops;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.desktops.enable = lib.mkEnableOption "desktops" // {
    default = hmCfg.enable;
  };

}
