{ config, lib, ... }:

let
  hmCfg = config.hm.elysium.shells.shells;
  cfg = config.elysium.shells;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "shells" ] {
      name = "default";
      default = "fish";
      example = "zsh";
      description = "Default shell to use.";
    })
  ];

  options.elysium.shells.shells = {
    zsh.enable = lib.mkEnableOption "Zsh" // {
      default = hmCfg.zsh.enable;
    };

    fish.enable = lib.mkEnableOption "Fish" // {
      default = hmCfg.fish.enable;
    };
  };

  config = {
    environment.shellAliases = lib.mkForce { };

    programs = {
      zsh.enable = lib.mkIf cfg.shells.zsh.enable true;
      fish.enable = lib.mkIf cfg.shells.fish.enable true;
    };

    users.defaultUserShell =
      let
        sCfg = cfg.shells.${cfg.default};
      in
      lib.mkIf (sCfg ? package) (lib.getCfgExe sCfg);

  };
}
