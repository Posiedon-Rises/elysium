{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.programs.office.enable = lib.mkEnableOption "Office programs";

}
