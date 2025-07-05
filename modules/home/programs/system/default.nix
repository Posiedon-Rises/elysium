{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

    options.elysium.programs.system.enable = lib.mkEnableOption "System programs";

}
