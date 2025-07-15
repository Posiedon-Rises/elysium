{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
  };

  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        name = "tokyonight";
        style = "moon";
      };

      statusline.lualine = {
        enable = true;
        theme = "auto";
      };
    };
  };
}