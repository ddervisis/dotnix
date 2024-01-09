{ config, pkgs, inputs, vars, stateVersion, ... }:

{
  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  # networking = {
  #   computerName = "MacBook";
  #   hostName = "MacBook";
  # };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      carlito
      corefonts
      font-awesome
      ibm-plex
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      roboto
      source-code-pro
      vegur
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
      git
      pfetch
      # ranger

      fd
      ripgrep
    ];
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    nix-daemon.enable = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [];
    casks = [];
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
        tilesize = 40;
      };
      finder = {
        QuitMenuItem = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.zsh}/bin/zsh'';
    stateVersion = stateVersion;
  };
}

