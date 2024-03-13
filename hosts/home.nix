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

      # General configuration
      # gnupg

      # Nix language server
      nil
      nixpkgs-fmt
    ];
    stateVersion = stateVersion;
  };

  programs = {
    home-manager.enable = true;
    zsh = {
      initExtra = ''
        [ "$(tty)" = "/dev/tty1" ] && exec Hyprland
      '';
    };
  };

}
