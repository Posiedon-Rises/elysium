{ config, lib, ... }:

let
  cfg = config.elysium.shells.programs.micro;
in
{
  options.elysium.shells.programs.micro.enable = lib.mkEnableOption "micro text editor" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    programs.micro.enable = true;
  };
}
