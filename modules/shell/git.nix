{ pkgs, lib, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Dennis Dervisis";
      userEmail = "6106539+ddervisis@users.noreply.github.com";
      signing = {
        key = "8FE7059BD65CECFCFD1D26747B12776305F7CD12";
        signByDefault = true;
      };
      ignores = [
        "*~"
        ".DS_Store"
      ];
      extraConfig = {
        core = {
          editor = "nvim";
        };
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
        };
        gpg.program = "${pkgs.gnupg}/bin/gpg2";
        tag.gpgsign = true;
        commit = {
          gpgsign = true;
        };
        pull = {
          rebase = true;
        };
        push.autoSetupRemote = true;
        init = {
          defaultbranch = "main";
        };
        merge = {
          conflictstyle = "zdiff3";
        };
      };
    };
  };
}
