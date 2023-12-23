{ config, lib, pkgs, vars, stateVersion, ... }:

{
  imports = (import ../modules/editors) ++ (import ../modules/programs)
    ++ (import ../modules/shell);

  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";

    packages = with pkgs; [
      # Terminal
      btop
      pfetch
      ranger

      # File Management
      rsync
      unzip
      unrar

      # General configuration
      # gnupg

      # Nix language server
      nixd

      # jetbrains-toolbox
    ];
    stateVersion = stateVersion;
  };

  programs = { home-manager.enable = true; };

}
