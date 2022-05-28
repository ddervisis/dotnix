{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh_nix";
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        size = 10000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "ansible"
          "alias-finder"
          # "autoenv"
          "autopep8"
          "brew"
          "colored-man-pages"
          "colorize"
          "command-not-found"
          "common-aliases"
          "dircycle"
          "dirhistory"
          "dirpersist"
          "docker-compose"
          "docker"
          "dotenv"
          "emoji"
          "encode64"
          "frontend-search"
          "fzf"
          "git"
          "git-extras"
          # "git-prompt"
          "gitignore"
          "gpg-agent"
          "history"
          "jsontools"
          "keychain"
          "last-working-dir"
          "man"
          "nvm"
          # "pipenv"
          "pyenv"
          "screen"
          "ssh-agent"
          # "sudo" # collides with thefuck
          "term_tab"
          "thefuck" # collides with sudo
          "themes"
          "transfer"
          "urltools"
          "virtualenv"
          "vscode"
          "web-search"
          "yarn"
          "zsh-autosuggestions"
          "zsh-interactive-cd"
          "zsh-navigation-tools"
          "zsh-syntax-highlighting"
          "zsh_reload"
        ];
        theme = "powerlevel10k/powerlevel10k";
        custom = "$HOME/.config/zsh_nix/custom";
        extraConfig = ''
          zstyle :omz:plugins:ssh-agent agent-forwading on lifetime 1D
        '';
      };

      initExtra = ''
        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        # Spaceship prompt
        # source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
        # autoload -U promptinit; promptinit

        # Hook direnv
        # emulate zsh -c "$(direnv hook zsh)"
        pfetch
      '';
    };
  };
}
