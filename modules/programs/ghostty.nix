{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      background-blur-radius = 20;
      background-opacity = 0.95;
      font-size = 12;
      font-family = "FiraCode Nerd Font";
      keybind = [
        "ctrl+h=goto_split:left"
        "ctrl+l=goto_split:right"
      ];
      theme = "catppuccin-macchiato";
    };
  };
}
