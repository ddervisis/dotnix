{pkgs, ...}: {
  programs = {
    xfconf.enable = true;
    file-roller.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
  };
  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
  environment.systemPackages = with pkgs; [
    evince
    f3d
    freetype
    ffmpegthumbnailer
    gnome-disk-utility
    gnome-epub-thumbnailer
    libgsf
    mcomix
    webp-pixbuf-loader
  ];
}
