{
  pkgs,
  config,
  lib,
  vars,
  hostName,
  system,
  ...
}: {
  # imports = (import ../../modules/services);

  environment = {
    systemPackages = with pkgs; [
      discord
      sops
      swiftlint
    ];
  };

  homebrew = {
    brews = [];
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
