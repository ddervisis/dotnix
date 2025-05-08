{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      background-blur-radius = 20;
      background-opacity = 0.95;
      font-size = 12;
      font-family = "FiraCode Nerd Font";
      keybind = [
        "ctrl+l=clear_screen"
      ];
      theme = "catppuccin-macchiato";
    };
  };
}
