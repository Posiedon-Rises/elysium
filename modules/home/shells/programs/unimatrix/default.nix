{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.unimatrix;
in
{
  options.elysium.shells.programs.unimatrix.enable = lib.mkEnableOption "unimatrix" // {
    default = cfg'.enableFun;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.unimatrix ];
  };
}
