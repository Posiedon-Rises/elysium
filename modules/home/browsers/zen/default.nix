{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cfg' = config.elysium.browsers;
  cfg = cfg'.browsers.zen;
in
{
  options.elysium.browsers.browsers.zen.enable = lib.mkEnableOption "Zen Browser";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".beta ];
  };
}
