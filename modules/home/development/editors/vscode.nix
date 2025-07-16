{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg' = config.elysium.development;
  cfg = cfg'.editors.vscodium;
in
{
  options.elysium.development.editors.vscodium.enable = lib.mkEnableOption "VS Codium" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.vscodium ];
  };
}
