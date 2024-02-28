{ config, lib, pkgs, vars, stateVersion, ... }:

{
  imports = (import ../modules/editors) ++ (import ../modules/shell);

  home = {
    stateVersion = stateVersion;
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      initExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };

}
