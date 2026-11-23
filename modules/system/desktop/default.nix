{
  self,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.desktop = moduleWithSystem ({...}: {
    imports = with self.nixosModules; [
      audio
      core
      networking
      niri
      noctalia
    ];
  });
}
