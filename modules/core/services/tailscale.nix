{ config, lib, ... }:

let
  cfg = config.elysium.services.tailscale;
in
{
  options.elysium.services.tailscale.enable = lib.mkEnableOption "Tailscale" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
