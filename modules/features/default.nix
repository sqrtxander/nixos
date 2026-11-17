{self, ...}: {
  flake.nixosModules.features = {pkgs, ...}: let
    modules = with self.nixosModules; [
      development
      fonts
      foot
      git
      librewolf
      niri
      noctalia
      zsh
    ];
  in {
    imports = modules;
  };
}
