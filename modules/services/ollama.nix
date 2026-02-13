{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    user = "ollama";
    port = 11434;
    models = "/data/ai/ollama_models";
    host = "0.0.0.0";
    openFirewall = true;
  };
}
