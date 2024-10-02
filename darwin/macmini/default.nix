{
  pkgs,
  config,
  lib,
  vars,
  hostName,
  system,
  ...
}:

{
  # imports = (import ../../modules/services);

  environment = {
    systemPackages = with pkgs; [
      age
      discord
      sops
    ];
  };

  homebrew = {
    brews = [ "talhelper" ];
    casks = [
      "ace-link"
      "balenaetcher"
      "docker"
      "jellyfin-media-player"
      "mullvadvpn"
      "vlc"
      "yubico-authenticator"
    ];
  };
}
