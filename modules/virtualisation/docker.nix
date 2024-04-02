{
  config,
  pkgs,
  vars,
  ...
}:

{
  virtualisation = {
    docker.enable = true;
  };
  users.groups.docker.members = [ vars.user ];
}
