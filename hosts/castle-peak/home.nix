{
  config,
  pkgs,
  vars,
  monitors,
  ...
}: {
  imports = [];

  home = {
    packages = with pkgs; [fzf];
  };
}
