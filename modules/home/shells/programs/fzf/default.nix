{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.fzf;
in
{
  options.elysium.shells.programs.fzf.enable = lib.mkEnableOption "Fzf" // {
    default = cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.fzf.enable = true;
  };
}
