{ config, lib, pkgs, ... }: 

let
  cfg' = config.elysium.shells.programs.tv;
  cfg = cfg'.channels.nix;
in
{
  options.elysium.shells.programs.tv.channels.nix.enable = lib.mkEnableOption "Enable the tv nix channel" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.television.channels.nix.nix = [
      {
        name = "nix";
        source_command = "nix-search-tv print";
        preview = "nix-search-tv preview {}";
      }
    ]

    home.packages = [ pkgs.nix-search-tv ];
  };
}