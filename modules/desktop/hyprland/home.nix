{
  lib,
  pkgs,
  vars,
  monitors,
  ...
}: let
  colors = import ../../themes/colors.nix;
  wallpaper = "/home/${vars.user}/.config/wall.png";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    extraConfig = ''
      exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
      exec-once = /run/current-system/sw/bin/systemctl --user restart waybar
      exec-once = /etc/profiles/per-user/${vars.user}/bin/hyprctl setcursor ${pkgs.catppuccin-cursors.macchiatoDark} 24
    '';
    settings = with colors.scheme.macchiato; {
      monitors = {
        monitor = [
          "${monitors.primary.output},${monitors.primary.resolution.width}x${monitors.primary.resolution.height}@165,0x0,1,vrr,2"
          "${monitors.secondary.output},${monitors.secondary.resolution.width}x${monitors.secondary.resolution.height}@165,${monitors.primary.resolution.width}x0,1,vrr,2"
          "${monitors.tertiary.output},${monitors.tertiary.resolution.width}x${monitors.tertiary.resolution.height}@165,${builtins.toString (lib.strings.toInt monitors.tertiary.resolution.width / 2)}x-${monitors.tertiary.resolution.height},1,vrr,2"
        ];
      };
      general = {
        gaps_in = 2;
        gaps_out = 3;
        border_size = 1;
        "col.active_border" = "${teal}";
        "col.inactive_border" = "${surface1}";
        layout = "dwindle";
        resize_on_border = true;
      };
      decoration = {
        rounding = 10;
        blur = {
          size = 4;
          passes = 2;
        };
        # TODO: find shadow replacements or remove if it was just removed.
        # drop_shadow = true;
        # shadow_range = 5;
        # shadow_offset = "0 0";
        # shadow_render_power = 3;
        # "col.shadow" = "${teal}";
        # "col.shadow_inactive" = "${base}";

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
      };

      input = {
        follow_mouse = 1;
        mouse_refocus = false;
      };

      cursor = {
        no_hardware_cursors = true;
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, default, popin 80%"
          "border, 1, 3, default"
          "fade, 1, 2, default"
          "workspaces, 1, 1, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        background_color = "0x24273a";
      };

      binds = {
        workspace_back_and_forth = true;
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, ESCAPE, exit"
        "$mod, RETURN, exec, ${pkgs.${vars.terminal}}/bin/${vars.terminal}"
        "$mod SHIFT, Q, killactive"
        "$mod, R, forcerendererreload"
        # "$mod, SPACE, exec, ${pkgs.rofi}/bin/rofi -show drun -show-icons"
        "$mod, SPACE, exec, ${pkgs.fuzzel}/bin/fuzzel"
        "$mod, P, exec, ${pkgs.rofi}/bin/rofi -show p -modi p:'${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot'"
        "$mod SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot --freeze --mode region --clipboard-only"
        "$mod CTRL, S, exec, ${pkgs.hyprshot}/bin/hyprshot --freeze --mode active --clipboard-only"
        "$mod SHIFT CTRL, S, exec, ${pkgs.hyprshot}/bin/hyprshot --freeze --mode output --clipboard-only"
        "$mod, E, exec, ${pkgs.pcmanfm}/bin/pcmanfm"
        "$mod CTRL, L, exec, ${pkgs.hyprlock}/bin/hyprlock"

        "$mod CTRL, M, togglespecialworkspace, minimized"
        #"$mod, M, exec, pypr toggle_minimized"
        #"$mod CTRL, E, exec, pypr expose"
        #"$mod, Z, exec, pypr zoom"

        "$mod, S, exec, ${pkgs.spotify}/bin/spotify"
        "$mod, C, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
        "$mod SHIFT, F, togglefloating,"
        "$mod CTRL, F, fullscreen, 0"
        # "$mod SHIFT CTRL, F, fakefullscreen, 0"
        "$mod SHIFT, P, pseudo,"
        "$mod SHIFT, O, togglesplit,"

        #"$mod, p, exec, ${pkgs.playerctl} play-pause"
        "$mod, bracketright, exec, ${pkgs.playerctl} next"
        "$mod, bracketleft, exec, ${pkgs.playerctl} previous"

        ", XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer --increase 10"
        ", XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer --decrease 10"
        ", XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer --toggle-mute"
        ", XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"
        # ", XF86AudioPrev, exec, "
        # ", XF86AudioNext, exec, "
        # ", XF86AudioPlay, exec, "
        # ", XF86AudioStop, exec, "

        ", XF86MonBrightnessUp, exec, lightctl up"
        ", XF86MonBrightnessDown, exec, lightctl down"

        # Move focus with $mod + h/j/k/l (vim movement)
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod, Tab, cyclenext,"
        "$mod, Tab, bringactivetotop,"

        # Move window in a direction
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Switch workspaces with $mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with $mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with $mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # ", SHIFT CAPS, pass, class:^(TeamSpeak)$"
        # ", SHIFT CAPS, pass, class:^(discord)$"
      ];

      bindm = [
        # Move/resize windows with $mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrule = [
        # "float,steam"
      ];
      windowrulev2 = [
        # "move onscreen cursor -1% -1%,class:(steam)"
        # "stayfocused, title:^()$,class:^(steam)$"
        # "minsize 1 1, title:^()$,class:^(steam)$"
        "float,class:(lutris),title:(Lutris)"
        # "forceinput, class:^(discord)$, xwayland:0"
      ];
    };
  };

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ${wallpaper}
      color = rgba(25, 20, 20, 1.0)
      blur_passes = 0
      blur_size = 7
      noise = 0.0117
      brightness = 0.8172
      contrast = 0.8916
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
    }

    # image {
    #   monitor =
    #   path = ${wallpaper}
    #   size = 150 # lesser side if not 1:1 ratio
    #   rounding = -1 # negative values mean circle
    #   border_size = 4
    #   border_color = rgb(221, 221, 221)
    #
    #   position = 0, 200
    #   halign = center
    #   valign = center
    # }

    label {
      monitor =
      text = cmd[update:1000] echo "$(date '+%H:%M')"
      font_size = 48
      font_family = Noto Sans
      position = 0, 360
      halign = center
      valign = center
    }

    label {
      monitor =
      text = Hi there, <span foreground='##006868'>${vars.user}</span>
      color = rgba(200, 200, 200, 1.0)
      font_size = 25
      font_family = Noto Sans

      position = 0, 230
      halign = center
      valign = center
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 3
      dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = false
      dots_rounding = -1 # -1 default circle, -2 follow input-field rounding
      outer_color = rgb(151515)
      inner_color = rgb(200, 200, 200)
      font_color = rgb(10, 10, 10)
      fade_on_empty = true
      fade_timeout = 1000 # Milliseconds before fade_on_empty is triggered.
      placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
      hide_input = false
      rounding = -1 # -1 means complete rounding (circle/oval)
      check_color = rgb(204, 136, 34)
      fail_color = rgb(204, 34, 34) # if authentication failed, changes outer_color and fail message color
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> # can be set to empty
      fail_transition = 300 # transition time in ms between normal outer_color and fail_color
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 # when both locks are active. -1 means don't change outer color (same for above)
      invert_numlock = false # change color if numlock is off
      swap_font_color = false # see below

      position = 0, -280
      halign = center
      valign = center
    }
  '';

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = ,${wallpaper}
    splash = false
  '';
}
