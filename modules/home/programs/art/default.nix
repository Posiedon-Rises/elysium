{ config, lib, ... }:

{
  options.elysium.programs.art.enable = lib.mkEnableOption "Art programs";
  imports = lib.elysium.scanPaths ./.;
}
