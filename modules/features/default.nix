{self, ...}: {
  flake.nixosModules.features = {...}: let
    modules = with self.nixosModules; [
      development
      fonts
      foot
      git
      helium
      images
      insync
      librewolf
      niri
      noctalia
      steam
      tmux
      zsh
    ];
  in {
    imports = modules;
  };
}
