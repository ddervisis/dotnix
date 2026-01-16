{pkgs, ...}: {
  programs = {
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs; [
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
    file-roller
    freetype
    ffmpegthumbnailer
    gnome-disk-utility
    gnome-epub-thumbnailer
    libgsf
    mcomix
    webp-pixbuf-loader
  ];
}
