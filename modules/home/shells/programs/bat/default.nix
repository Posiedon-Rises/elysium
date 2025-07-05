{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.bat;
in
{
  options.elysium.shells.programs.bat = {
    enable = lib.mkEnableOption "bat" // {
      default = cfg'.enableUseful;
    };
    enablePager = lib.mkEnableOption "bat as pager" // {
      default = true;
    };
    enableManPager = lib.mkEnableOption "bat as man pager" // {
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {

    home = {
      sessionVariables = {
        PAGER = lib.mkIf cfg.enablePager "bat -p";

        MANPAGER = lib.mkIf cfg.enableManPager "${''sh -c 'sed -ue \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -plman''}'";
      };

      shellAliases = {
        cat = "bat";

      };
    };

    programs.bat = {
      enable = true;

      config.style = "full";
    };
  };
}
