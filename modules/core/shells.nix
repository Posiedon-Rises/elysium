{ config, lib, ... }:

let
  cfg = config.elysium.shells;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "shells" ] {
      name = "default";
      default = "zsh";
      example = "zsh";
      description = "Default shell to use.";
    })
  ];

  options.elysium.shells.shells = {
    zsh.enable = lib.mkEnableOption "Zsh" // {
      default = lib.elysium.anyUserHasOption "elysium.shells.zsh.enable";
    };
  };

  config = {
    environment.shellAliases = lib.mkForce { };

    programs = {
      zsh.enable = lib.mkIf cfg.shells.zsh.enable true;
    };

    users.defaultUserShell =
      let
        sCfg = cfg.shells.${cfg.default};
      in
      lib.mkIf (sCfg ? package) (lib.getCfgExe sCfg);

  };
}
