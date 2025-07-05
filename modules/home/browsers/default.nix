{ config, lib, ... }:

let
  cfg = config.elysium.browsers;

  desktopFiles = {
    zen = "zen.desktop";
    firefox = "firefox.desktop";
  };

  defaultDesktopFile = desktopFiles.${cfg.default};

  otherDesktopFiles = lib.mapAttrsToList (name: _: desktopFiles.${name}) (
    lib.filterAttrs (name: browser: browser.enable && name != cfg.default) cfg.browsers
  );

in
{
  imports = [
    (lib.elysium.mkSelectorModule [ "elysium" "browsers" ] {
      name = "default";
      default = "zen";
      example = "firefox";
      description = "Default browser to use.";
    })] ++ lib.elysium.scanPaths ./.;

  options.elysium.browsers.enable = lib.mkEnableOption "browsers" // {
    default = config.elysium.desktops.enable;
  };

  config = lib.mkIf cfg.enable {
    # TODO: Implement mime-apps options
    # mime-apps.web = lib.mkMerge [
    #   {
    #     email = defaultDesktopFile;
    #     webpage = defaultDesktopFile;
    #   }
    #   {
    #     email = lib.mkAfter otherDesktopFiles;
    #     webpage = lib.mkAfter otherDesktopFiles;
    #   }
    # ];
  };
}
