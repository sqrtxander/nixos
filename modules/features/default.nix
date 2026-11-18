{self, ...}: {
  flake.nixosModules.features = {...}: let
    modules = with self.nixosModules; [
      development
      fonts
      foot
      git
      images
      librewolf
      niri
      noctalia
      tmux
      zsh
    ];
  in {
    imports = modules;
  };
}
