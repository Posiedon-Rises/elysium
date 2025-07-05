{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.lib.formats.rasi) mkLiteral;

  cfg' = config.elysium.desktops;
  cfg = cfg'.rofi;
in
{
  imports = lib.elysium.scanPaths ./.;
  options.elysium.desktops.rofi.enable = lib.mkEnableOption "Rofi";

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;

      theme = {
        "*" = {

          foreground = mkLiteral "#cccccc";
          normal-foreground = mkLiteral "@foreground";
          urgent-foreground = mkLiteral "@foreground";
          active-foreground = mkLiteral "@foreground";
          selected-normal-foreground = mkLiteral "@normal-foreground";
          selected-urgent-foreground = mkLiteral "@urgent-foreground";
          selected-active-foreground = mkLiteral "@active-foreground";
          alternate-normal-foreground = mkLiteral "@normal-foreground";
          alternate-urgent-foreground = mkLiteral "@urgent-foreground";
          alternate-active-foreground = mkLiteral "@active-foreground";

          background = mkLiteral "#06091699";
          lightbg = mkLiteral "#515768";
          normal-background = mkLiteral "@background";
          urgent-background = mkLiteral "@background";
          active-background = mkLiteral "@background";
          selected-normal-background = mkLiteral "#9446f8";
          selected-active-background = mkLiteral "@selected-normal-background";
          selected-urgent-background = mkLiteral "@selected-normal-background";
          alternate-normal-background = mkLiteral "@normal-background";
          alternate-urgent-background = mkLiteral "@urgent-background";
          alternate-active-background = mkLiteral "@active-background";

          window-border-color = mkLiteral "#515768";
          border-color = mkLiteral "#51e1e9";
          separatorcolor = mkLiteral "rgba(219, 223, 188, 100%)";
          background-color = mkLiteral "rgba(0, 0, 0, 0%)";
        };

        "#window" = {
          background-color = mkLiteral "@background";
          border = mkLiteral "1";
          border-radius = mkLiteral "10px";
          border-color = mkLiteral "@window-border-color";
          padding = mkLiteral "5";
        };

        "#mainbox" = {
          border = mkLiteral "0";
          padding = mkLiteral "0";
        };

        "#message" = {
          border = mkLiteral "2px 0px 0px";
          border-color = mkLiteral "@separatorcolor";
          padding = mkLiteral "1px";
        };

        "#textbox" = {
          text-color = mkLiteral "@foreground";
        };

        "#listview" = {
          fixed-height = mkLiteral "0";
          border = mkLiteral "2px 0px 0px";
          border-color = mkLiteral "@separatorcolor";
          spacing = mkLiteral "10px";
          scrollbar = mkLiteral "true";
          padding = mkLiteral "2px 0px 0px";
        };

        "#element" = {
          border = mkLiteral "0";
          padding = mkLiteral "1px";
        };

        "#element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };

        "#element.normal.normal" = {
          text-color = mkLiteral "@normal-foreground";
        };

        "#element.normal.urgent" = {
          text-color = mkLiteral "@urgent-foreground";
        };

        "#element.normal.active" = {
          text-color = mkLiteral "@active-foreground";
        };

        "#element.selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
          border-color = mkLiteral "@border-color";
          border = mkLiteral "1px";
          border-radius = mkLiteral "5px";
        };

        "#element.selected.urgent" = {
          background-color = mkLiteral "@selected-urgent-background";
          text-color = mkLiteral "@selected-urgent-foreground";
        };

        "#element.selected.active" = {
          background-color = mkLiteral "@selected-active-background";
          text-color = mkLiteral "@selected-active-foreground";
        };

        "#element.alternate.normal" = {
          text-color = mkLiteral "@alternate-normal-foreground";
        };

        "#element.alternate.urgent" = {
          text-color = mkLiteral "@alternate-urgent-foreground";
        };

        "#element.alternate.active" = {
          text-color = mkLiteral "@alternate-active-foreground";
        };

        "#scrollbar" = {
          width = mkLiteral "4px";
          border = mkLiteral "0";
          handle-width = mkLiteral "8px";
          padding = mkLiteral "0";
        };

        "#mode-switcher" = {
          border = mkLiteral "2px 0px 0px";
          border-color = mkLiteral "@separatorcolor";
        };

        "#button.selected" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
        };

        "#inputbar" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
          padding = mkLiteral "1px";
        };

        "#case-indicator" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };

        "#entry" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };

        "#prompt" = {
          spacing = mkLiteral "0";
          text-color = mkLiteral "@normal-foreground";
        };

        "#inputbar" = {
          children = [
            "prompt"
            "textbox-prompt-colon"
            "entry"
            "case-indicator"
          ];
        };

        "#textbox-prompt-colon" = {
          expand = mkLiteral "false";
          str = ":";
          margin = mkLiteral "0px 0.3em 0em 0em";
          text-color = mkLiteral "@normal-foreground";
        };
      };

      extraConfig = {
        "modes" = "window,drun,run,ssh";
        "font" =
          mkLiteral ''"JetBrains Mono Nerd Font Mono 14", "Twemoji Medium 14", "Noto Color Emoji Medium 14"'';
        "terminal" = "kitty";
        "show-icons" = true;
        "icon-theme" = "candy-icons";
      };
    };
  };
}
