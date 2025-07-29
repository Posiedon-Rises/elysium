{ config, lib, ... }:

{
  options.elysium.desktops.desktops.niri = {
    enable = lib.mkEnableOption "Niri Window manager";
  };

  config = {
    elysium.desktops = {
      rofi.enable = true;
      swaync.enable = true;
      quickshell.enable = true;
      activate-linux.enable = true;
      kando.enable = true;
    };
  };
}
