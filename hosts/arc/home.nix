{
  config,
  pkgs,
  vars,
  monitors,
  ...
}:

{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/desktop/waybar.nix
    ../../modules/desktop/firefox.nix
    ../../modules/desktop/rofi.nix
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
  };
}
