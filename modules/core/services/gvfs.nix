{ config, lib, ... }:

let
  cfg = config.elysium.services.gvfs;
in
{
  options.elysium.services.gvfs.enable = lib.mkEnableOption "GVfs" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    services.gvfs.enable = true;
  };
}
