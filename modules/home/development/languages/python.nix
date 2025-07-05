{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.languages.python;

  pyPkgs = pkgs.python313;
in
{
  options.elysium.development.languages.python.enable = lib.mkEnableOption "Python Dev";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pyPkgs.python
      pyPkgs.pip
    ];
  };
}
