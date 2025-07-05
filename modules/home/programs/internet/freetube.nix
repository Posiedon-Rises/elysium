{ config, lib, ... }:

let
  cfg' = config.elysium.programs.internet;
  cfg = cfg'.freetube;
in
{
  options.elysium.programs.internet.freetube.enable = lib.mkEnableOption "Freetube" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.freetube.enable = true;
  };
}
