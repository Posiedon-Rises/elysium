{
  inputs,
  pkgs,
  master,
  config,
  lib,
  ...
}:
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
    shell = pkgs.fish;
  };

  users.groups.${hostSpec.username} = {
    gid = 1000;
  };

  home-manager = {
    extraSpecialArgs = {
      inherit master inputs vauxhall;
      hostSpec = config.hostSpec;
    };

    users.${hostSpec.username}.imports =
      lib.optional (!hostSpec.isMinimal) [
        (lib.elysium.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix")
        (lib.elysium.relativeToRoot "modules/home")
      ]
      |> lib.flatten;
  };
}
