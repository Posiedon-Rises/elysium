{ lib, ... }:

{
  imports = lib.elysium.scanPaths ./.;

  options.elysium.development.languages.dotnet.csharp.enable = lib.mkEnableOption "CSharp Dev";
}
