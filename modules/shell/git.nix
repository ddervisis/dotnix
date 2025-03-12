{
  pkgs,
  lib,
  vars,
  ...
}: {
  programs = {
    git = {
      enable = true;
      userName = vars.git.user;
      userEmail = vars.git.email;
      signing = {
        key = vars.git.gpgKey;
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
        gpg.program = "${lib.getExe pkgs.gnupg}";
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
        rerere.enabled = true;
      };
    };
  };
}
