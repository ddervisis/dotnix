{ pkgs, config, lib, vars, hostName, system, ... }:

{
  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  environment = { systemPackages = with pkgs; [ age discord sops talosctl ]; };

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
