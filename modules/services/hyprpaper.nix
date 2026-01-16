{ config, ... }:
let
  wallpaper = "${config.home.homeDirectory}/.config/wall.png";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = {
        monitor = "";
        path = wallpaper;
      };
      splash = false;
    };
  };
}
