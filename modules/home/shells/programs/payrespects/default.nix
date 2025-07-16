{ config, lib, ... }:

let
  cfg' = config.elysium.shells.programs;
  cfg = cfg'.payrespects;
in
{
  options.elysium.shells.programs.payrespects.enable = lib.mkEnableOption "payrespects" // {
    default = cfg'.enableFun || cfg'.enableUseful;
  };

  config = lib.mkIf cfg.enable {
    programs.pay-respects = {
      enable = true;
      options = [
        "--alias"
        "fuck"
      ];
    };
  };
}
