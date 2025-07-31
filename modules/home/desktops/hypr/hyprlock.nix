{
  config,
  lib,
  vauxhall,
  ...
}:

let
  cfg'' = config.elysium.desktops;
  cfg' = cfg''.hypr;
  cfg = cfg'.lock;
in
{
  options.elysium.desktops.hypr.lock.enable = lib.mkEnableOption "Hyprlock" // {
    default = cfg'.enable;
  };

  config = lib.mkIf (cfg''.enable && cfg'.enable && cfg.enable) {
    programs.hyprlock = {
      enable = true;
      settings = {

        # GENERAL
        general = {
          no_fade_in = false;
          no_fade_out = true;
          hide_cursor = true;
          disable_loading_bar = true;
        };

        # BACKGROUND
        background = [
          {
            monitor = "";
            #path = screenshot
            path = "${lib.elysium.relativeToRoot "wallpapers/stars.png"}";
            #color = $background
            blur_size = 5;
            blur_passes = 2;
            contrast = 1;
            brightness = 0.5;
            vibrancy = 0.2;
            vibrancy_darkness = 0.2;
          }
        ];

        # INPUT FIELD
        input-field = [
          {
            monitor = "";
            size = "250, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgb(${vauxhall.background.alpha})";
            inner_color = "rgb(${vauxhall.background.alpha})";
            font_color = "rgb(${vauxhall.cyan.alpha})";
            fade_on_empty = false;
            rounding = -1;
            placeholder_text = "<span foreground='#${vauxhall.blue.hex}'><i>Logged in as</i><span foreground='#${vauxhall.violet.hex}'> <b>$USER</b></span></span>";
            loading_color = "rgb(${vauxhall.mint.alpha})";
            fail_color = "rgb(${vauxhall.yellow.alpha})";
            fail_text = "<i>$FAIL <b>$ATTEMPTS</b></i>";
            hide_input = false;
            position = "0, -200";
            halign = "center";
            valign = "center";
          }
        ];
        # DATE
        label = [
          {
            monitor = "";
            text = "cmd[update:1000] echo $(date +'%A, %B %d')";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 22;
            font_family = "JetBrains Mono NF";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          # TIME
          {
            monitor = "";
            text = "cmd[update:1000] echo $(date +'%-I:%M')";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            font_family = "JetBrains Mono NF Extrabold";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }

          # CURRENT SONG
          # {
          #   monitor = "";
          #   text =
          #     "cmd[update:1000] echo $(playerctl metadata --format '{{ artist }} - {{ title }}')";
          #   #color = $foreground
          #   color = "rgba(255, 255, 255, 0.6)";
          #   font_size = 18;
          #   font_family = "JetBrains Mono NF";
          #   position = "0, 50";
          #   halign = "center";
          #   valign = "bottom";
          # }

          #   {
          #     monitor =
          #     text = cmd[update:1000] echo "$(/home/justin/Documents/Scripts/battery.sh)"
          #     color = $foreground
          #     font_size = 24
          #     font_family = JetBrains Mono NF
          #     position = -90, -10
          #     halign = right
          #     valign = top
          #   }

          #   {
          #     monitor =
          #     text = cmd[update:1000] echo "$(/home/justin/Documents/Scripts/network-status.sh)"
          #     color = $foreground
          #     font_size = 24
          #     font_family = JetBrains Mono NF
          #     position = -20, -10
          #     halign = right
          #   }

        ];
      };
    };
  };
}
