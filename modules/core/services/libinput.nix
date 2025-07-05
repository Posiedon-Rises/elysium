{
  config,
  lib,

  ...
}:

let
  cfg = config.elysium.services.libinput;
in
{
  options.elysium.services.libinput.enable = lib.mkEnableOption "libinput" // {
    default = config.hostSpec.isDesktop;
  };

  config = lib.mkIf cfg.enable {
    services.libinput.enable = true;
  };
}
