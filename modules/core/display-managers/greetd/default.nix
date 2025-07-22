{
  config,
  lib,
  ...
}:

let
  cfg' = config.elysium.display-managers;
  cfg = cfg'.display-managers.greetd;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "display-managers" "display-managers" "greetd" "greeter" ]
      {
        name = "provider";
        default = "tuigreet";
        description = "Greeter to use for greetd.";
      }
    )
  ]
  ++ lib.elysium.scanPaths ./.;

  options.elysium.display-managers.display-managers.greetd.enable = lib.mkEnableOption "greetd";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    services.greetd.enable = true;
  };
}
