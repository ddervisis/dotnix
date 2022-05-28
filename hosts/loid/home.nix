{ config, pkgs, user, ... }:

{
  imports =
    [
    ];

  home = {
    packages = with pkgs; [
      # Applications
      #ffmpeg
    ];
  };
}
