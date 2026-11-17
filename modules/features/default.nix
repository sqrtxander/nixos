{self, ...}: {
  flake.nixosModules.features = {pkgs, ...}: let
    modules = with self.nixosModules; [
      development
      foot
      git
      niri
      zsh
    ];
  in {
    imports = modules;
  };
}
