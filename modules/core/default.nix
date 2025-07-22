{ inputs, lib, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
  ]
  ++ lib.elysium.scanPaths ./.;
}
