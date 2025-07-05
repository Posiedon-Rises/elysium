{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.office;
  cfg = cfg'.obsidian;
in
{
  options.elysium.programs.office.obsidian.enable = lib.mkEnableOption "Obsidian" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.obsidian ];
  };
}
