{ pkgs, lib, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      syntaxHighlighting.enable = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        size = 10000;
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./p10k-config;
          file = "p10k.zsh";
        }
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "alias-finder"
          "colored-man-pages"
          "colorize"
          "common-aliases"
          "dircycle"
          "direnv"
          "dirhistory"
          "dirpersist"
          "git"
          "git-extras"
          "gitignore"
          # "gpg-agent"
          "history"
          "jsontools"
          "last-working-dir"
          "man"
          "ssh-agent"
          "term_tab"
          "themes"
          "vscode"
          "zsh-interactive-cd"
          "zsh-navigation-tools"
        ];
        custom = "$HOME/.config/zsh/custom";
        extraConfig = ''
          zstyle :omz:plugins:ssh-agent agent-forwading on lifetime 1D
        '';
      };

      initExtra = ''
        [ "$(tty)" = "/dev/tty1" ] && exec Hyprland
        [[ ! -f ~/.config/zsh/plugins/powerlevel10k-config/p10k.sh ]] || source ~/.config/zsh/plugins/powerlevel10k-config/p10k.sh

        # Spaceship prompt
        # source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
        # autoload -U promptinit; promptinit

        alias gs="gst"
      '';

      # shellAliases.fixstore =
      #   "sudo nix-store --verify --check-contents --repair";
    };
  };
}
