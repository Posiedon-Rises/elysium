{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.programs.system.enable = lib.mkEnableOption "System programs" // {
    default = config.elysium.desktops.enable;
  };

}
