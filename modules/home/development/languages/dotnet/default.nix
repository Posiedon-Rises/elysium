{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.languages.dotnet;
in
{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.development.languages.dotnet.enable = lib.mkEnableOption "Dotnet";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.dotnetCorePackages.sdk_9_0 ];
  };
}
