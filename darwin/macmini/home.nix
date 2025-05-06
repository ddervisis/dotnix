{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  programs = {
    zsh = {
      initContent = ''
        # source <(talhelper completion zsh)
      '';
    };
  };
}
