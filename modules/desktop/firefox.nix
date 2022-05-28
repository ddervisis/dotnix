{ pkgs, ... }:

{
  programs = {
    firefox = {
      enable = true;
      # extensions = [
      #   ublock-origin
      #   noscript
      #   darkreader
      #   bitwarden
      #   honey
      #   betterttv
      #   octolinker
      #   return-youtube-dislikes
      #   sponsorblock
      # ];
    };
  };
}
