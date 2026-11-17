{self, ...}: {
  flake.nixosModules.development = {pkgs, ...}: let
    modules = with self.nixosModules; [
      development-c
      development-go
      development-nix
      development-perl
      development-python
      development-rust
      development-typst
      development-web
    ];
    systemPackages = with pkgs; [
      prek
      ripgrep
      wget
      curl
      jq
    ];
  in {
    imports = modules;
    environment.systemPackages = systemPackages;
  };
}
