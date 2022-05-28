{ config, pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/sway/home.nix
      ../../modules/desktop/waybar.nix
      ../../modules/desktop/firefox.nix
    ];

  home = {
    packages = with pkgs; [
      # Applications
      gimp
      libreoffice
      yubioath-desktop

      # Video/Audio
      feh
      vlc

      #ffmpeg
    ];
    file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../../modules/themes/wall;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    cursorTheme = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";
    };
  };

}
