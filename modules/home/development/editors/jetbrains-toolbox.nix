{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.editors.jetbrains;
in
{
  options.elysium.development.editors.jetbrains.enable = lib.mkEnableOption "Jetbrains Toolbox" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.jetbrains-toolbox ];
  };
}
