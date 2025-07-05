{ config, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.shells.programs = {
    enableFun = lib.mkEnableOption "fun shell programs" // {
      default = config.elysium.terminals.enable;
    };
    enableUseful = lib.mkEnableOption "useful shell programs" // {
      default = true;
    };
  };
}
