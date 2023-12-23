{
  programs.direnv = {
    enable = true;
    #loadInNixShell = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
