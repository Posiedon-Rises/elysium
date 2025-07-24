{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.just;
in
{
  options.elysium.development.just.enable = lib.mkEnableOption "Just command runner" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.just ];
  };
}
