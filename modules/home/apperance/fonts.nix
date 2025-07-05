{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.apperance;
  cfg = cfg'.cursor;
in
{
  options.elysium.apperance.fonts.enable = lib.mkEnableOption "Install fonts" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-color-emoji
      twemoji-color-font
    ];
  };
}
