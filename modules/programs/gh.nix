{pkgs, ...}: {
  programs = {
    gh = {
      enable = false;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
  };
}
