{ vars, ... }:
{
  services.cloudflared = {
    enable = true;
    user = vars.user;
    group = "users";
    tunnels = {
      "external" = {
        credentialsFile = "/home/${vars.user}/.cloudflared/external.json";
        # credentialsFile = "/tmp/cfd";
        default = "http_status:404";
        ingress = {
          "*.bodenlos.dev" = "https://10.11.0.10";
        };
      };
    };
  };
}
