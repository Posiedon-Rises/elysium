{ config, lib, ... }:

{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "browsers" ] {
      name = "default";
      default = "zen";
      example = "firefox";
      description = "Default browser to use.";
    })
  ]
  ++ lib.elysium.scanPaths ./.;

  options.elysium.browsers.enable = lib.mkEnableOption "browsers" // {
    default = config.elysium.desktops.enable;
  };
}
