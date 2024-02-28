{ config, lib, pkgs, vars, stateVersion, ... }:

{
  home = {
    username = vars.work_user;
    homeDirectory = lib.mkForce "/Users/${vars.work_user}";
  };
}
