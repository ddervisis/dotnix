{ config, lib, pkgs, vars, stateVersion, ... }:

{
  imports = (import ../modules/editors) ++ (import ../modules/shell);

  home = {
    username = vars.user;
    homeDirectory = lib.mkForce "/Users/${vars.user}";
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
