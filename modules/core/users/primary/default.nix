{ inputs, pkgs, master, config, lib, ... }:
let
  hostSpec = config.hostSpec;
  vauxhall = import (lib.elysium.relativeToRoot "vauxhall.nix"); 
in
{
  users.users.${hostSpec.username} = {
    isNormalUser = true;
    name = hostSpec.username;
    group = hostSpec.username;
    uid = 1000;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh; # default shell
  };

  users.groups.${hostSpec.username} = { gid = 1000; };

  home-manager = {
    extraSpecialArgs = {
      inherit pkgs master inputs vauxhall;
      hostSpec = config.hostSpec;
    };
    users.${hostSpec.username}.imports = lib.flatten (
      lib.optional (!hostSpec.isMinimal) [
        (
          { config, ... }:
          import (lib.elysium.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
            inherit
              pkgs
              master
              inputs
              config
              lib
              hostSpec
              vauxhall
              ;
          }
        )

        (
          { config, ... }:
          import (lib.elysium.relativeToRoot "modules/home") {
            inherit
              pkgs
              master
              inputs
              config
              lib
              hostSpec
              vauxhall
              ;
          }
        )
      ]
    );
  };
}