{pkgs, ...}: {
  programs.eww = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/eww/eww.scss".source = ./eww.scss;
  home.file.".config/eww/eww.yuck".source = ./eww.yuck;
}
