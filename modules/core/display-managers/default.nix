{
  config,
  lib,
  ...
}:

{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "display-managers" ] {
      name = "provider";
      default = "greetd";
      description = "Display manager to use.";
    })
  ]
  ++ lib.elysium.scanPaths ./.;

  options.elysium.display-managers.enable = lib.mkEnableOption "Display managers" // {
    default = config.elysium.desktops.enable;
  };
}
