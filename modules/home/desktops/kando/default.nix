{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.kando;
in
{
  options.elysium.desktops.kando.enable = lib.mkEnableOption "Kando Pie Menu";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.kando ];

    elysium.desktops.exec-once = [ "kando" ];
  };
}
