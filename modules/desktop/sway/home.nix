{ config, lib, pkgs, vars, monitors, ... }:

# NOTE: Currently not in use

{
  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "${pkgs.${vars.terminal}}/bin/${vars.terminal}";
      menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons";

      startup = [
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "${pkgs.autotiling}/bin/autotiling";
          always = true;
        }
        # {
        #   command = ''
        #     ${pkgs.swayidle}/bin/swayidle -w before-sleep '${pkgs.swaylock-fancy}/bin/swaylock-fancy'
        #   '';
        #   always = true;
        # }
        #{command = ''
        #  ${pkgs.swayidle}/bin/swayidle \
        #    timeout 120 '${pkgs.swaylock-fancy}/bin/swaylock-fancy' \
        #    timeout 240 'swaymsg "output * dpms off"' \
        #    resume 'swaymsg "output * dpms on"' \
        #    before-sleep '${pkgs.swaylock-fancy}/bin/swaylock-fancy'
        #''; always = true;}
      ];

      bars = [ ];

      fonts = {
        names = [ "Source Code Pro" ];
        size = 10.0;
      };

      gaps = {
        inner = 5;
        outer = 5;
        smartBorders = "off";
        smartGaps = false;
      };

      window = {
        border = 1;
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      input = {
        "type:touchpad" = {
          tap = "disabled";
          dwt = "enabled";
          scroll_method = "two_finger";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us";
          xkb_numlock = "enabled";
        };
      };

      output = {
        "*".bg = "~/.config/wall fill";
        "*".scale = "1";
        "${monitors.primary.output}" = {
          mode =
            "${monitors.primary.resolution.width}x${monitors.primary.resolution.height}";
          pos = "0 0";
        };
        "${monitors.secondary.output}" = {
          mode =
            "${monitors.secondary.resolution.width}x${monitors.secondary.resolution.height}";
          pos = "${monitors.primary.resolution.width} 0";
        };
        "${monitors.tertiary.output}" = {
          mode =
            "${monitors.tertiary.resolution.width}x${monitors.tertiary.resolution.height}";
          pos = "${
              monitors.primary.resolution.width / 2
            } -${monitors.primary.resolution.height}";
        };
      };

      keybindings = {
        "${modifier}+Escape" = "exec swaymsg exit";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+q" = "kill";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+e" = "exec ${pkgs.pcmanfm}/bin/pcmanfm";
        "${modifier}+l" = "exec ${pkgs.swaylock-fancy}/bin/swaylock-fancy";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";

        "${modifier}+r" = "reload";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+h" = "floating toggle";
        "${modifier}+a" = "focus parent";

        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+d" = "layout toggle split";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "Alt+Left" = "workspace prev";
        "Alt+Right" = "workspace next";

        "Alt+1" = "workspace number 1";
        "Alt+2" = "workspace number 2";
        "Alt+3" = "workspace number 3";
        "Alt+4" = "workspace number 4";
        "Alt+5" = "workspace number 5";

        "Alt+Shift+Left" = "move container to workspace prev, workspace prev";
        "Alt+Shift+Right" = "move container to workspace next, workspace next";

        "Alt+Shift+1" = "move container to workspace number 1";
        "Alt+Shift+2" = "move container to workspace number 2";
        "Alt+Shift+3" = "move container to workspace number 3";
        "Alt+Shift+4" = "move container to workspace number 4";
        "Alt+Shift+5" = "move container to workspace number 5";

        "Control+Up" = "resize shrink height 20px";
        "Control+Down" = "resize grow height 20px";
        "Control+Left" = "resize shrink width 20px";
        "Control+Right" = "resize grow width 20px";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";

        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
        "XF86AudioMicMute" =
          "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        #
        #"XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U  5";
        #"XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 5";
      };
    };

    extraConfig = ''
      set $opacity 0.8
      for_window [app_id="pcmanfm"] opacity 0.95, floating enable
      for_window [app_id="Kitty"] opacity $opacity
      for_window [title="drun"] opacity $opacity
      for_window [class="firefox"] move container to workspace number 2, workspace number 2
      for_window [app_id="pavucontrol"] floating enable, sticky
      for_window [title="Picture in picture"] floating enable, move position 1205 634, resize set 700 400, sticky enable
    '';

    extraSessionCommands = ''
      #export WLR_NO_HARDWARE_CURSORS="1";  # Needed for cursor in vm
      export XDG_SESSION_TYPE=wayland
      export XDG_SESSION_DESKTOP=sway
      export XDG_CURRENT_DESKTOP=sway
    '';
  };
}
