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
      talosctl
    ];
  };

  homebrew = {
    brews = [ "talhelper" ];
    casks = [
      "balenaetcher"
      "jellyfin-media-player"
      "mullvadvpn"
      "vlc"
      "yubico-authenticator"
    ];
  };
}
