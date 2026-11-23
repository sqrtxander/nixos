{self, ...}: {
  flake.nixosModules.features = {...}: let
    modules = with self.nixosModules; [
      anki
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
      zotero
      zsh
    ];
  in {
    imports = modules;
  };
}
