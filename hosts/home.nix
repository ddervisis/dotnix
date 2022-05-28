{ config, lib, pkgs, user, stateVersion, ... }:

{
  imports =
    (import ../modules/editors) ++
    (import ../modules/programs) ++
    (import ../modules/shell);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Terminal
      btop                # Resource Manager
      pfetch              # Minimal fetch
      ranger              # File Manager

      # File Management
      rsync               # Syncer $ rsync -r dir1/ dir2/
      unzip               # Zip files
      unrar               # Rar files

      # General configuration
      # gnupg             # GNU Privacy Guard
    ];
    stateVersion = stateVersion;
  };

  programs = {
    home-manager.enable = true;
  };


}
