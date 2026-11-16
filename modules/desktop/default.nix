{ moduleWithSystem, self, ...}: {
  flake.nixosModules.desktop = moduleWithSystem ({config, self', ...}: let
    modules = with self.nixosModules; [
      core
      networking
      foot
      niri
    ];
  in {
    imports = modules;
  });
}
