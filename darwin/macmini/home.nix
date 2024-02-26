{ config, pkgs, vars, ... }:

{
  programs = {
    zsh = {
      initExtra = ''
        source <(talhelper completion zsh)
      '';
    };
  };
}
