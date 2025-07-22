{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg' = config.elysium.development;
  cfg = cfg'.godot;
in
{
  options.elysium.development.godot = {
    enable = lib.mkEnableOption "Godot" // {
      default = cfg'.enable;
    };

    exportTemplates = lib.mkEnableOption "Godot export templates" // {
      default = cfg.enable;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.godot_4-mono
    ]
    ++ lib.optional cfg.exportTemplates pkgs.godot_4-export-templates-bin;
  };
}
