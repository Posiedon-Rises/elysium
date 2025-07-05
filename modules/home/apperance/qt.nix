{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.apperance;
  cfg = cfg'.qt;
in
{
  options.elysium.apperance.qt.enable = lib.mkEnableOption "Qt" // {
    default = cfg'.enable;
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      candy-icons
    ];

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    home.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct"; # Set the Qt platform theme
      QT_STYLE = "kvantum"; # Set the Qt style
    };
  };
}
