{
  config,
  lib,
  vauxhall,
  ...
}:

let
  cfg' = config.elysium.desktops;
  cfg = cfg'.desktops.hyprland;
in
{
  options.elysium.desktops.desktops.hyprland = {
    enable = lib.mkEnableOption "Hyprland Window manager";
  };

  config = lib.mkIf (cfg'.enable && cfg.enable) {
    systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

    elysium.desktops = {
      hypr.enable = true;
      rofi.enable = true;
      swaync.enable = true;
      waybar.enable = true;
      activate-linux.enable = true;
      kando.enable = true;
    };
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$browser" = "MOZ_ENABLE_WAYLAND=0 ${config.elysium.browsers.default}";
        "$menu" = "rofi -show drun";

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "compose:ralt"; # allows typing letters with accent marks (ex é) by "composing" other symbols (ex e and ')
          kb_rules = "";
          follow_mouse = 1;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = {
            natural_scroll = true;
            clickfinger_behavior = true;
          };
        };

        misc = {
          disable_autoreload = true;
          disable_hyprland_logo = true;
          always_follow_on_dnd = true;
          layers_hog_keyboard_focus = true;
          animate_manual_resizes = false;
          enable_swallow = true;
          focus_on_activate = true;
          new_window_takes_over_fullscreen = 2;
          middle_click_paste = false;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures = {
          workspace_swipe = true;
        };

        # https://wiki.hyprland.org/Configuring/Variables/#general
        general = {
          gaps_in = "4";
          gaps_out = "0, 8, 8, 8";

          border_size = 1;

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          "col.active_border" =
            "rgb(${vauxhall.cyan.alpha})";
          "col.inactive_border" = "rgb(${vauxhall.gray.alpha})";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;
        };

        dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
          smart_split = true;
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        decoration = {
          rounding = 0;

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;

            color = "rgba(1a1a1aee)";
          };

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
            enabled = false;
          };
        };

        animations = {
          enabled = true;

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, easeInOutCubic, slide"
            "workspacesIn, 1, 1.21, easeInOutCubic, slidefade 50%"
            "workspacesOut, 1, 1.94, easeInOutCubic, slidefade 50%"
          ];
        };

        bind = [
          # Program binds
          "SUPER, RETURN, exec, $terminal"
          "SUPER, B, exec, $browser"
          "SUPER, E, exec, $fileManager"
          "SHIFT + SUPER, return, exec, QT_QPA_PLATFORMTHEME=qt5ct $menu"
          "SUPER, PERIOD, exec, bemoji --private -c -n"
          "SHIFT + SUPER, C, exec, hyprpicker --autocopy"
          "ALT + SHIFT + SUPER, C, exec, hyprpicker --fmt=rgb --autocopy"
          "SHIFT + SUPER, L, exec, hyprlock"
          "SUPER, V, exec, cliphist list | rofi -dmenu -p  -display-columns 2 | cliphist decode | wl-copy"
          "SUPER, Space, global, kando:main-menu"

          ", PRINT, exec, hyprshot -m output -o ~/Media/Images"
          "SUPER, PRINT, exec, hyprshot -m window -o ~/Media/Images"
          "SHIFT + SUPER, PRINT, exec, hyprshot -m region -o ~/Media/Images"

          # Manage layout

          "SHIFT + SUPER, P, pseudo," # dwindle
          "SUPER, J, togglesplit," # dwindleb
          "SUPER, F, togglefloating,"

          # Kill the selected window with Mod + Q

          "SUPER, Q, killactive,"

          # Change window focus with Mod + Arrow Keys

          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          # Swap windows with Alt + Mod + Arrow Keys

          "ALT + SUPER, left, swapwindow, l"
          "ALT + SUPER, right, swapwindow, r"
          "ALT + SUPER, up, swapwindow, u"
          "ALT + SUPER, down, swapwindow, d"
          # Move to workspace with Mod + [0-9]

          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          # Move window to workspace with  Shift + Mod + [0-9]

          "SHIFT + SUPER, 1, movetoworkspace, 1"
          "SHIFT + SUPER, 2, movetoworkspace, 2"
          "SHIFT + SUPER, 3, movetoworkspace, 3"
          "SHIFT + SUPER, 4, movetoworkspace, 4"
          "SHIFT + SUPER, 5, movetoworkspace, 5"
          "SHIFT + SUPER, 6, movetoworkspace, 6"
          "SHIFT + SUPER, 7, movetoworkspace, 7"
          "SHIFT + SUPER, 8, movetoworkspace, 8"
          "SHIFT + SUPER, 9, movetoworkspace, 9"
          "SHIFT + SUPER, 0, movetoworkspace, 10"

          # Special workspace 'hidden', for whatever windows you need open but don't want to see

          "SUPER, S, togglespecialworkspace, hidden"
          "SHIFT + SUPER, S, movetoworkspace, special:hidden"

          # Special workspace 'notebook', keep track of notes, write things down for later, etc

          "SUPER, N, togglespecialworkspace, notebook"
          "SHIFT + SUPER, N, movetoworkspace, special:notebook"
        ];

        binde = [
          # Resize windows by 10 pixels with Ctrl + Mod + Arrow Keys
          "CTRL + SUPER, left, resizeactive, -10 0"
          "CTRL + SUPER, right, resizeactive, 10 0"
          "CTRL + SUPER, up, resizeactive, 0 -10"
          "CTRL + SUPER, down, resizeactive, 0 10"

          # Resize windows by 1 pixel with Ctrl + Shift + Mod and arrow keys
          "CTRL + SHIFT + SUPER, left, resizeactive, -1 0"
          "CTRL + SHIFT + SUPER, right, resizeactive, 1 0"
          "CTRL + SHIFT + SUPER, up, resizeactive, 0 -1"
          "CTRL + SHIFT + SUPER, down, resizeactive, 0 1"
        ];

        bindm = [
          # Manage windows with mainMod + mouse
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        bindel = [
          # Change volume by 5% with Volume Keys
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

          # Change volume by 1% with Shift + Volume Keys
          "SHIFT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
          "SHIFT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"

          # Change microphone volume by 5% with Alt + Volume Keys
          "ALT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"
          "ALT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"

          # Change microphone volume by 1% with Shift + Alt + Volume Keys
          "SHIFT_ALT, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%+"
          "SHIFT_ALT, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1%-"

          # Mute with Mute Key
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Mute mic with Alt + Mute Key
          "Alt, XF86AMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # Change brightness with brightness keys
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"

          # Exit Hyprland
          "SUPER, ESCAPE, exit"

          # Power options
          "SHIFT + SUPER, ESCAPE, exec, poweroff"
          "ALT + SUPER, ESCAPE, exec, reboot"
        ];

        bindl = [
          # Manage media with media keys
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
        ];

        windowrule = [
          "noblur, class:kando"
          "opaque, class:kando"
          "size 100% 100%, class:kando"
          "noborder, class:kando"
          "noanim, class:kando"
          "float, class:kando"
          "pin, class:kando"
        ];

        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "float, class:org.freedesktop.impl.portal.desktop.kde"
          "nofocus, class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "tile,title:^(top-bar)$"
          "tile,class:^(top-bar)$"
        ];

        # Persist the shell and browser workspaces
        workspace = [
          "1, persistent:1"
          "2, persistent:1"
        ];
      };

      extraConfig = ''
        monitor=,preferred,auto,auto 

        xwayland {
          force_zero_scaling = true
        }
      '';
      xwayland.enable = true;
      systemd.enable = true;
    };
  };
}
