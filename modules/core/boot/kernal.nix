{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.elysium.boot;
in
{

  options.elysium.boot = {
    kernal = lib.mkOption {
      type = lib.types.raw;
      default = pkgs.linuxPackages_zen;
    };
  };

  config.boot = {
    kernelPackages = cfg.kernal;
  };
}
