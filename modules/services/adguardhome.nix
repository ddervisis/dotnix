{
  config,
  pkgs,
  lib,
  ...
}: {
  containers.adguardhome = {
    config = {
      config,
      pkgs,
      ...
    }: {
      services.adguardhome = {
        enable = true;
        openFirewall = true;
        mutableSettings = true;
        settings = {
          bind_host = "127.0.0.1";
          bind_port = 3000;
          users = [
            {
              name = "test";
              password = "$2y$10$nZ8Nzu.zpn8CX/RWwgWmqu34MBA9v3Ai8Iybmw2hVLzMZMPEK.sMq";
            }
          ];
          dns = {
            bind_hosts = ["127.0.0.1"];
            anonymize_client_ip = true;
            blocked_services = {
              ids = ["tiktok"];
            };
            protection_enabled = true;
            filtering_enabled = true;
            blocking_mode = "nxdomain";
            blocked_response_ttl = 10;
            safe_search = {
              enabled = true;
              bing = true;
              duckduckgo = true;
              google = true;
            };
            rate_limit = 20;
            ratelimit_subnet_len_ipv4 = 24;
            ratelimit_subnet_len_ipv6 = 56;
            upstream_dns = [
              "https://family.dns.mullvad.net/dns-query"
              "https://1.1.1.3/dns-query"
            ];
            fallback_dns = [
              "https://dns.mullvad.net/dns-query"
              "https://1.1.1.1/dns-query"
            ];
            upstream_mode = "load_balance";
            use_http3_upstreams = true;
            rewrites = [
              {
                domain = "*.domain.com";
                answer = "1.1.1.1";
              }
            ];
          };
          filtering = {
            protection_enabled = true;
            filtering_enabled = true;
          };
        };
        extraArgs = [];
      };
    };
  };
}
