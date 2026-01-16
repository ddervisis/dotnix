{
  pkgs,
  vars,
  monitors,
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        border: none;
        font-family: FiraCode Nerd Font Mono, "Font Awesome 6 Free";
        font-weight: bold;
        font-size: 14;
      }
      window#waybar {
        background-color: #1a1b26;
        /*background: transparent;*/
        transition-property: background-color;
        transition-duration: .5s;
        border-bottom: none;
      }
      window#waybar.hidden {
        opacity: 0.2;
      }
      #workspace,
      #mode,
      #clock,
      #pulseaudio,
      #network,
      #mpd,
      #memory,
      #bluetooth,
      #network,
      #window,
      #cpu,
      #custom-gpu,
      #disk,
      #temperature,
      #custom-fanspeed,
      #battery,
      #tray {
        background-color: #252734;
        padding: 0 12px;
        margin: 4px 4px 4px 4px;
        border-radius: 90px;
        background-clip: padding-box;
      }
      #workspaces button {
        padding: 0 5px;
        color: #7aa2f7;
        min-width: 20px;
      }
      #workspaces button:hover {
        background-color: rgba(0, 0, 0, 0.2);
      }
      #workspaces button.active {
        color: #c678dd;
      }
      #workspaces button.urgent {
        color: #e06c75;
      }
      #mode {
        color: #e06c75;
      }
      #disk {
        color: #56b6c2;
      }
      #cpu {
        color: #d19a66;
      }
      #custom-gpu {
        color: #0dff9d;
      }
      #memory {
        color: #c678dd;
      }
      #temperature {
        color: #46ad3c;
      }
      #temperature.critical {
        color: #d3343a;
      }
      #custom-fanspeed {
        color: #7aa2f7;
      }
      #clock {
        color: #7aa2f7;
      }
      #window {
        color: #9ece6a;
      }
      #battery {
        color: #9ece6a;
      }
      #battery.warning {
        color: #ff5d17;
      }
      #battery.critical {
        color: #ff200c;
      }
      #battery.charging {
        color: #9ece6a;
      }
      #bluetooth {
        color: #4e99fc;
      }
      #network {
        color: #c678dd;
      }
      #pulseaudio {
        color: #d19a66;
      }
      #pulseaudio.muted {
        color: #c678dd;
        background-color: #252734;
      }
    '';
    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;
        output = [
          monitors.primary.output
          monitors.secondary.output
          monitors.tertiary.output
        ];
        tray = {
          spacing = 10;
        };
        modules-center = [ "clock" ];
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-right = [
          "cpu"
          "custom/gpu"
          "memory"
          "disk"
          "temperature"
          "custom/fanspeed"
          "pulseaudio"
          # "battery"
          "bluetooth"
          "network"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "<span font='14'>{icon}</span>";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
          };
          all-outputs = true;
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
          on-scroll-up = "/etc/profiles/per-user/${vars.user}/bin/hyprctl dispatch workspace e+1";
          on-scroll-down = "/etc/profiles/per-user/${vars.user}/bin/hyprctl dispatch workspace e-1";
          on-click = "activate";
        };

        clock = {
          format = "{:%b %d %H:%M} <span font='14'></span>";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = "{:%A, %B %d, %Y} ";
        };

        cpu = {
          format = "{usage}% <span font='14'></span>";
          # format = "{icon0}{icon1}{icon2}{icon3} {usage:>2}% ";
          # format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          interval = 5;
        };

        "custom/gpu" = {
          format = "{}% <span font='14'>󰾲</span>";
          tooltip = true;
          interval = 5;
          exec = "/run/current-system/sw/bin/nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          tooltip-format = "GPU utilization";
        };

        memory = {
          format = "{}% <span font='14'></span>";
          # format = "{used:0.1f}G/{total:0.1f}G <span font='14'></span>";
          interval = 5;
        };

        disk = {
          format = "{percentage_used}% <span font='14'></span>";
          path = "/";
          interval = 30;
        };

        temperature = {
          hwmon-path = "/dev/hwmon/temp1_input";
          critical-threshold = 50;
          format = "{temperatureC}󰔄 {icon}";
          format-critical = "🔥 {temperatureC}󰔄 {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip-format = "Water temperature";
        };

        "custom/fanspeed" = {
          tooltip = false;
          interval = 10;
          exec = "/run/current-system/sw/bin/cat /dev/hwmon/fan1_input";
          format = "{}rpm ✇";
        };

        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% <span font='16'>{icon}</span>";
          format-charging = "{capacity}% <span font='14'></span>";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
        };

        bluetooth = {
          format = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱 {device_alias}";
          format-connected-battery = "󰂱 {device_alias} (󰥉 {device_battery_percentage}%)";
          # // format-device-preference = [ "device1" "device2" ]; # preference list deciding the displayed device
          tooltip-format = ''
            {controller_alias}	{controller_address} ({status})

            {num_connections} connected'';
          tooltip-format-disabled = "bluetooth off";
          tooltip-format-connected = ''
            {controller_alias}	{controller_address} ({status})

            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	({device_battery_percentage}%)";
          max-length = 35;
          # on-click = "${pkgs.${vars.terminal}}/bin/${vars.terminal} -e bluetooth_toggle";
          # on-click-right = "${pkgs.blueman}/bin/blueman";
        };

        network = {
          format-wifi = "<span font='14'></span>";
          format-ethernet = "<span font='14'></span> {ipaddr}";
          # format-ethernet = "<span font='14'></span> {ifname}: {ipaddr}/{cidr}";
          format-linked = "<span font='14'>睊</span> {ifname} (No IP)";
          format-disconnected = "<span font='14'>睊</span> Not connected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{essid} {signalStrength}%";
          on-click-right = "${pkgs.${vars.terminal}}/bin/${vars.terminal} -e nmtui";
        };

        pulseaudio = {
          format = "<span font='14'>{icon}</span> {volume}% {format_source}";
          format-bluetooth = "<span font='14'>{icon}</span> {volume}% {format_source}";
          format-bluetooth-muted = "<span font='14'></span> {volume}% {format_source}";
          format-muted = "<span font='13'></span> {format_source}";
          format-source = "{volume}% <span font='11'></span>";
          format-source-muted = "<span font='11'></span>";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
          };
          tooltip-format = "{desc}, {volume}%";
          on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
          on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute";
          on-click-middle = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        tray = {
          icon-size = 14;
        };
      }
    ];
  };
}
