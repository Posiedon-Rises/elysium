{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.languages.lua;
in
{
  options.elysium.development.languages.lua.enable = lib.mkEnableOption "Lua Dev";
}
