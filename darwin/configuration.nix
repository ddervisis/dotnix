{
  lib,
  config,
  pkgs,
  system,
  vars,
  ...
}:
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
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
        ];
      })
      roboto
    ];
  };

  environment = {
    shells = [pkgs.zsh];
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
      jq
      mkcert
      nil
      nixpkgs-fmt
      pinentry_mac
      pfetch
      podman
      podman-tui
      qemu
      rectangle
      ripgrep
      spotify
      # stats
    ];

    # For shell debugging purposes:

    # etc."zshenv".text = mkBefore ''
    #   set -x
    # '';
  };

  programs = {
    # needed to have /run/current-system/sw/bin added to the path automatically.
    zsh.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
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
    casks = [
      "arc"
      "bitwarden"
      "bruno"
      "itsycal"
      "logitech-options"
      "stats"
      "sublime-text"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "Microsoft Remote Desktop" = 1295203466;
    };
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
    config = {
      allowUnfree = true;
    };
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
      finder = {
        QuitMenuItem = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
    };
    activationScripts.postActivation.text = "sudo chsh -s ${pkgs.zsh}/bin/zsh";
    stateVersion = 4;
  };
}
