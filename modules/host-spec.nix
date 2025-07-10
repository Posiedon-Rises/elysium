{ config, lib, ... }:

rec {
  options.hostSpec = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "The username of the host admin";
      default = "Coolio";
    };

    hostName = lib.mkOption {
      type = lib.types.str;
      description = "The hostname of the host";
    };

    networking = {
      networkmanager = {
        enable = lib.mkEnableOption "NetworkManager" // {
          default = true;
        };

        scanRandMacAddress = lib.mkEnableOption "NetworkManager" // {
          default = true;
        };
      };
    };

    isServer = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    isDesktop = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    isWork = lib.mkOption {
      type = lib.types.bool;
      default = config.hostSpec.isDesktop;
    };

    isMinimal = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
}
