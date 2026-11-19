{self, ...}: {
  flake.nixosModules.features = {...}: let
    modules = with self.nixosModules; [
      development
      fonts
      foot
      git
      images
      insync
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
