{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.programs.office;
  cfg = cfg'.okular;
in
{
  options.elysium.programs.office.okular.enable = lib.mkEnableOption "Okular" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [ pkgs.kdePackages.okular ];
  };
}
