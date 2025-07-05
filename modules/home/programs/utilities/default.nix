{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.programs.utilities.enable = lib.mkEnableOption "Utility programs";
}
