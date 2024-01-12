{ lib, config, pkgs, inputs, system, vars, hostName, ... }:

with lib; {
#  users.users.${vars.user} = {
#    home = "/Users/${vars.user}";
#    shell = pkgs.zsh;
#  };

  networking = {
    computerName = hostName;
    hostName = hostName;
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
      ansible
      btop
      fd
      git
      nixd
      pinentry
      pfetch
      rectangle
      ripgrep
      stats
    ];

    # For shell debugging purposes:

    # etc."zshenv".text = mkBefore ''
    #   set -x
    # '';
  };

  services = { nix-daemon.enable = true; };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [ "direnv" "fzf" "gpg" ];
    casks =
      [ "arc" "bitwarden" "logitech-options" "postman" "yubico-authenticator" ];
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

