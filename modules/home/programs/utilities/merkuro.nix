{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.utilities;
  cfg = cfg'.merkuro;
in
{
  options.elysium.programs.utilities.merkuro.enable = lib.mkEnableOption "Merkuro" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.kdePackages.kcalc ];
  };
}
