{ config, pkgs, user, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      enableNvidia = false;
      dockerCompat = true;
      dockerSocket.enable = false;
    };
  };
  users.groups.podman.members = [ user ];
}
