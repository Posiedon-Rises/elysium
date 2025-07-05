{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.utilities;
  cfg = cfg'.ente-auth;
in
{
  options.elysium.programs.utilities.ente-auth.enable = lib.mkEnableOption "Ente Auth" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.ente-auth ];
  };
}
