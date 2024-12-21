{
  vars,
  ...
}:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "overlay2";
    };
  };
  users.groups.docker.members = [ vars.user ];
  hardware.nvidia-container-toolkit.enable = true;
}
