{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;
  options.elysium.programs.art.enable = lib.mkEnableOption "Art programs";
}
