{ config, ...}: {
  programs = {
    zsh = {
      enable = true;
      dotDir = "${config.home.homeDirectory}/.config/zsh";
      autosuggestion.enable = true;
      enableCompletion = true;
      autocd = true;
      syntaxHighlighting.enable = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
        size = 10000;
      };

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
          "gpg-agent"
          "history"
          "jsontools"
          "last-working-dir"
          "man"
          "ssh-agent"
          "term_tab"
          "themes"
          "zsh-interactive-cd"
          "zsh-navigation-tools"
        ];
        theme = "agnoster";
        extraConfig = ''
          zstyle :omz:plugins:ssh-agent lazy yes
        '';
      };

      initContent = ''
        alias gs="gst"
      '';

      shellAliases.fixstore = "sudo nix-store --verify --check-contents --repair";
    };
  };
}
