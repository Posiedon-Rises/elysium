{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development.languages.dotnet.csharp;
  cfg = cfg'.repl;
in
{
  options.elysium.development.languages.dotnet.csharp.repl.enable =
    lib.mkEnableOption "CSharp REPL"
    // {
      default = cfg'.enable;
    };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.csharprepl ];
  };
}
