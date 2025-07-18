{
  config,
  lib,
  ...
}:

{
  home.keyboard = {
    options = 
      [
        "compose:ralt"
      ] ++
      lib.optional config.elysium.shells.programs.neovim.enable "caps:swapescape";
  };

  wayland.windowManager.hyprland.settings.input.kb_options = lib.mkDefault config.home.keyboard.options;
}
