{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.rofi;
  cfg = cfg'.bemoji;
in
{
  options.elysium.desktops.rofi.bemoji.enable = lib.mkEnableOption "Bemoji";

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.bemoji ];
  };
}
