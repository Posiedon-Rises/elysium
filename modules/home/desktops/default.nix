{
  config,
  lib,
  ...
}:

let
  cfg = config.elysium.desktops;
in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "desktops" ] {
      name = "default";
      default = "hyprland";
      example = "hyprland";
      description = "Default desktop to use.";
    })] ++ lib.elysium.scanPaths ./.;

  options.elysium.desktops = {
    enable = lib.mkEnableOption "desktops" // {
      default = config.hostSpec.isDesktop;
    };

    exec-once = lib.mkOption {
      default = [ ];
      example = [ "hyprpaper" ];
      description = "Commands to run once the desktop has been started";
      type = lib.types.listOf lib.types.string;
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.portal.xdgOpenUsePortal = true;
  };

}
