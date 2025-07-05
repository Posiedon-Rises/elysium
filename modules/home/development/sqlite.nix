{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.sqlite;
in
{
  options.elysium.development.sqlite.enable = lib.mkEnableOption "SQLite" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.sqlite ];
  };
}
