{ config, lib, vauxhall, ... }:

let 
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.oh-my-posh;
in {
  options.elysium.shells.programs.oh-my-posh.enable = lib.mkEnableOption "Oh My Posh shell prompt" // {
    default = cfg'.enableFun || cfg'.enableUseful;
  };

  config.programs.oh-my-posh = lib.mkIf cfg.enable {
    enable = true;

    settings = {
      async = true;

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          leading_diamond = "";
          trailing_diamond = "";
          segments = [
            {
              type = "os";
              style = "powerline";
            }
          ];
        }
      ];
    };
  };
}
