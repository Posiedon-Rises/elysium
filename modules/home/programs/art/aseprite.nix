{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.art;
  cfg = cfg'.aseprite;
in
{
  options.elysium.programs.art.aseprite.enable = lib.mkEnableOption "Aseprite" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.aseprite ];
  };
}
