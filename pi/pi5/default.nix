{ pkgs, config, lib, hostName, vars, ... }: {
  environment.systemPackages = with pkgs; [ vim ];
  services.openssh.enable = true;
  networking.hostName = hostName;
  users = {
    users.${vars.user} = {
      password = vars.user;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
  networking = { };
  system.stateVersion = "23.11";
}
