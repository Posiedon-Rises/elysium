{ config, lib, ... }:

let
  cfg = config.elysium.services.gnome-keyring;
in
{
  options.elysium.services.gnome-keyring.enable = lib.mkEnableOption "Gnome Keyring" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.${config.elysium.display-managers.provider}.enableGnomeKeyring = true;
  };
}
