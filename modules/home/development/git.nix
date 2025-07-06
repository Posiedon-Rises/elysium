{ config, lib, ... }:

let
  cfg = config.elysium.development.git;
in
{
  options.elysium.development.git.enable = lib.mkEnableOption "Git" // {
    default = true;
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      aliases = {
        co = "checkout";
        undo = "reset --hard HEAD~1";
      };
    };
  };
}
