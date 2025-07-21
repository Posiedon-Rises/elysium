{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.eza;
in
{
  options.elysium.shells.programs.eza = {
    enable = lib.mkEnableOption "eza" // {
      default = cfg'.enableUseful;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      colors = "always";
      extraOptions = [
        "--group-directories-first"
      ];
    };
  };
}
