{vars, ...}: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = false;
    };
  };
  users.groups.podman.members = [vars.user];
  hardware.nvidia-container-toolkit.enable = true;
}
