{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.pamixer;
in
{
  options.elysium.desktops.pamixer.enable = lib.mkEnableOption "pamixer";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.pamixer ];
  };
}
