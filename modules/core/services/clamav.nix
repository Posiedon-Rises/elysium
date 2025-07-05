{
  config,
  lib,

  ...
}:

let
  cfg = config.elysium.services.clamav;
in
{
  options.elysium.services.clamav = {
    enable = lib.mkEnableOption "ClamAV" // {
      default = config.hostSpec.isDesktop;
    };
    daemon.enable = lib.mkEnableOption "ClamAV daemon" // {
      default = config.hostSpec.isDesktop;
    };

    scanner.enable = lib.mkEnableOption "ClamAV scanner" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services.clamav = {
      daemon.enable = cfg.daemon.enable;
      scanner.enable = cfg.scanner.enable;
    };
  };
}
