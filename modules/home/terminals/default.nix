{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.terminals.enable = lib.mkEnableOption "Terminals" // {
    default = config.elysium.desktops.enable;
  };
}
