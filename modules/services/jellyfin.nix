{ config, pkgs, lib, user, ... }:

{
  services.jellyfin = {
    # dataDir = "/data/media";
    user = user;
    enable = true;
    openFirewall = true;
  };
}
