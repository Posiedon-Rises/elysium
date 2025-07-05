{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.art;
  cfg = cfg'.inkscape;
in
{
  options.elysium.programs.art.inkscape.enable = lib.mkEnableOption "Inkscape" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.inkscape ];
  };
}
