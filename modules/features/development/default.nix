{self, ...}: {
  flake.nixosModules.development = {pkgs, ...}: let
    modules = with self.nixosModules; [
      development-c
      development-go
      development-nix
      development-perl
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
      tree-sitter
      htop
      tree
    ];
  in {
    imports = modules;
    environment.systemPackages = systemPackages;
  };
}
