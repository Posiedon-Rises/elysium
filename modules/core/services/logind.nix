{
  config,
  lib,

  ...
}:

let
  logindHandlerType = lib.types.enum [
    "ignore"
    "poweroff"
    "reboot"
    "sleep"
    "lock"
  ];

  cfg = config.elysium.services.logind;
in
{
  options.elysium.services.logind = {
    enable = lib.mkEnableOption "logind" // {
      default = config.hostSpec.isDesktop;
    };

    lidSwitch = lib.mkOption {
      default = "lock";
      type = logindHandlerType;
    };
  };

  config = lib.mkIf cfg.enable {
    elysium.services.logind = {
      enable = true;
      lidSwitch = cfg.lidSwitch;
    };
  };
}
