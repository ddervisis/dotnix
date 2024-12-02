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
    ../../modules/desktop/fuzzel.nix
    ../../modules/desktop/thunderbird.nix
    ../../modules/services/gpg-agent.nix
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
      name = "catppuccin-macchiato-dark-cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      size = 24;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
