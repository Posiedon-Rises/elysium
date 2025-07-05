{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.cava;
in
{
  options.elysium.shells.programs.cava.enable = lib.mkEnableOption "cava" // {
    default = cfg'.enableFun;
  };

  config = lib.mkIf cfg.enable {
    programs.cava = {
      enable = true;
      settings = {
        # TODO: Write new cava config
      };
    };
  };
}
