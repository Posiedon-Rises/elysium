{ hostSpec, lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.development.enable = lib.mkEnableOption "Development programs" // {
    default = hostSpec.isWork;
  };
}
