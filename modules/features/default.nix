{self, ...}: {
  flake.nixosModules.features = {pkgs, ...}: let
    modules = with self.nixosModules; [
      development
      foot
      git
      niri
      noctalia
      zsh
    ];
  in {
    imports = modules;
  };
}
