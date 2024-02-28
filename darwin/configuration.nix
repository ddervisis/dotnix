{ lib, config, pkgs, inputs, system, vars, ... }:

with lib; {
  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      corefonts
      font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      roboto
    ];
  };

  environment = {
    shells = [ pkgs.zsh ];
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      btop
      direnv
      fd
      fzf
      git
      iterm2
      nixd
      pinentry
      pfetch
      podman
      podman-tui
      rectangle
      ripgrep
      spotify
      stats
    ];

    # For shell debugging purposes:

    # etc."zshenv".text = mkBefore ''
    #   set -x
    # '';
  };

  # needed to have /run/current-system/sw/bin added to the path automatically.
  programs.zsh.enable = true;

  services = { nix-daemon.enable = true; };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [ "gpg" ];
    casks =
      [ "arc" "bitwarden" "bruno" "itsycal" "logitech-options" "sublime-text" ];
  };

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    hostPlatform = system;
    config.allowUnfree = true;
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      dock = {
        autohide = false;
        orientation = "bottom";
        showhidden = true;
        tilesize = 60;
      };
      finder = { QuitMenuItem = false; };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
    activationScripts.postActivation.text = "sudo chsh -s ${pkgs.zsh}/bin/zsh";
    stateVersion = 4;
  };
}

