{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.tv;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.shells.programs.tv.enable = lib.mkEnableOption "television" // {
    default = cfg'.enableUseful || cfg'.enableFun;
  };

  config = lib.mkIf cfg.enable {
    programs.television.enable = true;
  };
}
