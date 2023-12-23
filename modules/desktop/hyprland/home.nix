{ config, lib, pkgs, vars, monitors, ... }:

let colors = import ../../themes/colors.nix;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    # enableNvidiaPatches = true;

    extraConfig = ''
      # window resize
      # bind = ALT, R, submap, resize

      # submap = resize
      # binde = , right, resizeactive, 10 0
      # binde = , left, resizeactive, -10 0
      # binde = , up, resizeactive, 0 -10
      # binde = , down, resizeactive, 0 10
      # bind = , escape, submap, reset
      # submap = reset
    '';
    plugins = with pkgs; [ ];
    settings = with colors.scheme.macchiato; {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "${teal}";
        "col.inactive_border" = "${surface1}";
        layout = "dwindle";
        resize_on_border = true;
      };
      decoration = {
        rounding = 10;
        blur = {
          size = 8;
          passes = 2;
        };
        drop_shadow = true;
        shadow_range = 15;
        shadow_offset = "0 0";
        shadow_render_power = 3;
        "col.shadow" = "${teal}";
        "col.shadow_inactive" = "${base}";

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
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

      binds = { workspace_back_and_forth = true; };

      "$mod" = "SUPER";

      bind = [
        "$mod, ESCAPE, exit"
        "$mod, RETURN, exec, ${pkgs.${vars.terminal}}/bin/${vars.terminal}"
        "$mod SHIFT, Q, killactive"
        "$mod, R, forcerendererreload"
        "$mod, SPACE, exec, ${pkgs.rofi}/bin/rofi -show drun -show-icons"
        "$mod, E, exec, ${pkgs.pcmanfm}/bin/pcmanfm"
        # "$mod, L, exec, ${pkgs.swaylock-fancy}/bin/swaylock-fancy"
        "$mod, F, exec, ${pkgs.firefox}"

        "$mod CTRL, M, togglespecialworkspace, minimized"
        "$mod, M, exec, pypr toggle_minimized"
        "$mod CTRL, E, exec, pypr expose"
        "$mod, Z, exec, pypr zoom"

        "$mod, S, exec, spotify"
        "$mod, C, exec, ${pkgs.hyprpicker}/bin/hyprpicker -a"
        "$mod SHIFT, F, togglefloating,"
        "$mod CTRL, F, fullscreen, 0"
        "$mod SHIFT CTRL, F, fakefullscreen, 0"
        "$mod SHIFT, P, pseudo,"
        "$mod SHIFT, O, togglesplit,"

        "$mod, p, exec, ${pkgs.playerctl} play-pause"
        "$mod, bracketright, exec, ${pkgs.playerctl} next"
        "$mod, bracketleft, exec, ${pkgs.playerctl} previous"

        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        ", XF86AudioLowerVolume, exec, volumectl -u down"
        ", XF86AudioMute, exec, volumectl toggle-mute"
        ", XF86AudioMicMute, exec, volumectl -m toggle-mute"

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
      ];

      bindm = [
        # Move/resize windows with $mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
