{
  config,
  lib,
  pkgs,
  vars,
  stateVersion,
  ...
}: {
  programs = {
    zsh = {
      initContent = ''
        alias docker="podman"
        if [ -f ~/.pypi.sh ]; then
          source ~/.pypi.sh
        fi
      '';
    };
  };
}
