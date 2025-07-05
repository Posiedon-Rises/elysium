{
  lib,
  ...
}:

{
  options.elysium.programs.internet.enable = lib.mkEnableOption "Internet Apps";

  imports = lib.elysium.scanPaths ./.;
}
