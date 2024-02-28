{ config, lib, pkgs, vars, ... }:

{
  home = {
    username = vars.user;
    homeDirectory = lib.mkForce "/Users/${vars.user}";
  };

  programs = {
    zsh = {
      initExtra = ''
        # source <(talhelper completion zsh)
      '';
    };
  };
}
