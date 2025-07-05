{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.browsers;
  cfg = cfg'.browsers.firefox;
in
{
  options.elysium.browsers.browsers.firefox.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.firefox.enable = true;
  };
}
