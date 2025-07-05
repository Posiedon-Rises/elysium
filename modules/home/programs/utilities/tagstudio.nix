{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.utilities;
  cfg = cfg'.tagstudio;
in
{
  options.elysium.programs.utilities.tagstudio.enable = lib.mkEnableOption "Tagstudio" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.tagstudio ];
  };
}
