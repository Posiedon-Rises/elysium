{ inputs, lib, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
  ]
  ++ lib.elysium.scanPaths ./.;
}
