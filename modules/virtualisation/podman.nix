{ config, pkgs, vars, ... }:

{
  virtualisation = {
    podman = {
      enable = true;
      enableNvidia = false;
      dockerCompat = true;
      dockerSocket.enable = false;
    };
  };
  users.groups.podman.members = [ vars.user ];
}
