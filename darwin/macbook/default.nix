{ pkgs, config, lib, vars, hostName, system, ... }:

{
  users.users.${vars.work_user} = {
    home = "/Users/${vars.work_user}";
    shell = pkgs.zsh;
  };
}
