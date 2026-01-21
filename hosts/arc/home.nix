{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/services/hyprpaper.nix
    ../../modules/desktop/waybar.nix
    # ../../modules/desktop/firefox.nix
    ../../modules/desktop/fuzzel.nix
    ../../modules/desktop/thunderbird.nix
    ../../modules/services/gpg-agent.nix
    ../../modules/services/syncthing.nix
    ../../modules/desktop/ags.nix
  ];

  home = {
    packages = with pkgs; [
      mako
      feh
      vlc
      fzf
    ];
    file.".config/wall.png".source = config.lib.file.mkOutOfStoreSymlink ../../modules/themes/wall.png;
  };

  catppuccin = {
    enable = true;
    accent = "lavender";
    flavor = "macchiato";
    cursors.enable = true;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = "catppuccin-macchiato-lavender-cursors";
      size = 24;
    };
  };
}
