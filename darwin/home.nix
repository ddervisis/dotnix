{ config, lib, pkgs, vars, stateVersion, ... }:

{
  imports = (import ../modules/editors) ++ (import ../modules/programs)
    ++ (import ../modules/shell);

  home = {
    username = "${vars.user}";
    homeDirectory = "/Users/${vars.user}";

    packages = with pkgs; [
      # Terminal
      btop
      pfetch

      # General configuration
      # gnupg

      # Nix language server
      nixd
    ];
    stateVersion = stateVersion;
  };

  programs = { home-manager.enable = true; };

}
