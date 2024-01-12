{ pkgs, config, lib, vars, hostName, system, ... }:

{
  environment = { systemPackages = with pkgs; [ discord ]; };

  homebrew = { casks = [ "jellyfin-media-player" "mullvadvpn" "vlc" ]; };
}
