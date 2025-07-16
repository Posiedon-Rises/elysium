{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.languages.nix;
in
{
  options.elysium.development.languages.nix.enable = lib.mkEnableOption "Nix Dev";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nixd
      pkgs.manix
      pkgs.statix
      pkgs.deadnix
    ];
  };
}
