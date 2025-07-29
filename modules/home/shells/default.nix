{
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.shells;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "shells" ] {
      name = "default";
      default = "fish";
      description = "Default shell to use.";
    })
  ]
  ++ lib.elysium.scanPaths ./.;

  options.elysium.shells = {
    historySize = lib.mkOption {
      type = lib.types.int;
      default = 256000;
      example = 128000;
      description = "Number of history lines.";
    };

    greet = lib.mkOption {
      type = lib.types.lines;
      default = "";
      example = lib.literalExpression ''
        ''${lib.getExe pkgs.fastfetch}
      '';
      description = ''
        Commands that should be run to greet the user.
        Note that these commands will run for any shell.
      '';
    };

    shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      example = {
        ll = "ls -l";
      };
    };
  };

  config = {
    home = {
      sessionVariables.SHELL =
        let
          sCfg = cfg.shells.${cfg.default};
        in
        lib.mkIf (sCfg ? package) (lib.elysium.getCfgExe sCfg);
    };
  };
}
