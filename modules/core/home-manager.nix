{ config, lib, ... }:

{
  # TODO: To be removed once anyUserHasOption is fixed
  imports = [
    (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" config.hostSpec.username ])
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
