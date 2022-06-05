{ config, pkgs, lib, user, ... }:

let
  rootDir = "/data/services/gitea";
in
{
  services.gitea = {
    enable = true;
    user = user;
    domain = "localhost";
    useWizard = false;
    stateDir = rootDir;
    ssh = {
      enable = true;
      clonePort = 2222;
    };
    rootUrl = "http://localhost:3000/";
    repositoryRoot = "${rootDir}/repositories";
    log = {
      level = "Info";
      rootPath = "${rootDir}/log";
    }
    lfs = {
      enable = false;
      contentDir = "${rootDir}/data/lfs";
    };
    httpPort = 3000;
    httpAddress = "0.0.0.0";
    dump = {
      enable = true;
      interval = "04:31";
      backupDir = "${rootDir}/dump";
    }
    disableRegistration = true;
    database = {
      user = "gitea";
      type = "postgres";
      socket = "postgresql://gitea:gitea@localhost:5432/gitea";
      port = 5432;
      path = null;
      password = "gitea";
      name = "gitea";
      host = "localhost";
      passwordFile = null;
      createDatabase = false;
    };
    cookieSecure = false;
    appName = "Gitea";
    staticRootPath = "${rootDir}/data";
    mailerPasswordFile = null;
    enableUnixSocket = false;
    # settings = {
    #   # https://github.com/go-gitea/gitea/blob/main/custom/conf/app.example.ini
    # };
  };
}

# TODO: run as NixOS container instead of bare metal
# containers.gitea = {
#   config =
#     { config, pkgs, ... }:
#     {
#       services.gitea = {
#         enable = true;
#       };
#     }
# };
