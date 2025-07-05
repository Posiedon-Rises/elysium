{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.clipboard;
  cfg = cfg'.wl-clipboard;
in
{
  options.elysium.desktops.clipboard.wl-clipboard.enable = lib.mkEnableOption "ClipHist" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.wl-clipboard-rs ];
  };
}
