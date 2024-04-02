{
  config,
  pkgs,
  inputs,
  vars,
  stateVersion,
  ...
}:

{
  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "sudo"
      "audio"
    ];
    shell = pkgs.zsh;
    initialPassword = vars.user;
    ignoreShellProgramCheck = true;
  };

  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  fonts.packages = with pkgs; [
    carlito
    corefonts
    font-awesome
    ibm-plex
    # jetbrains-mono
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "DroidSansMono"
      ];
    })
    roboto
    source-code-pro
    vegur
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      killall
      pciutils
      usbutils
      vim
      wget
    ];
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    ssh.startAgent = false;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  services = {
    # pipewire = {
    #   enable = true;
    #   alsa = {
    #     enable = true;
    #     support32Bit = true;
    #   };
    #   pulse.enable = true;
    #   jack.enable = true;
    #   wireplumber.enable = true;
    # };
    openssh = {
      enable = true;
      # allowSFTP = true;
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      trusted-users = [ vars.user ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    # autoUpgrade = {
    #   enable = true;
    #   channel = "https://nixos.org/channels/nixos-unstable";
    # };
    stateVersion = stateVersion;
  };
}
