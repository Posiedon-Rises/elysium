{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg' = config.elysium.programs.office;
  cfg = cfg'.libreoffice;
in
{
  options.elysium.programs.office.libreoffice.enable = lib.mkEnableOption "Libreoffice" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = [
      pkgs.libreoffice-qt6-fresh
      pkgs.hunspell
    ];
  };
}
