{ config, lib, pkgs, vars, monitors, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "${pkgs.hyprlock}/bin/hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];
    style = ''
      * {
        background-image: none;
        transition: 0ms;
      }

      window {
        background-color: rgba(12, 12, 12, 0.1);
        background-image: url('./noise.png');
      }

      button {
        color: #FFFFFF;
        border-style: solid;
        border-width: 2px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;

        background-color: rgba(108, 112, 134, 0.4);
        border: 1px solid rgba(108, 112, 134, 0.3);
        border-top: 1px solid rgba(108, 112, 134, 0.3);
      }

      button:focus,
      button:active,
      button:hover {
        background-color: rgba(156, 161, 192, 0.5);
        border: 1px solid rgba(108, 112, 134, 0.15);
        border-top: 1px solid rgba(108, 112, 134, 0.15);
      }

      #lock {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("/usr/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
      }

      #logout {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("/usr/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("/usr/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
      }

      #hibernate {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("/usr/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("/usr/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        margin: 10px;
        border-radius: 20px;
        background-image: image(url("/usr/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }
    '';
  };
  home.file.".config/wlogout/noise.png".source =
    config.lib.file.mkOutOfStoreSymlink ../../modules/desktop/wlogout/noise.png;
}
