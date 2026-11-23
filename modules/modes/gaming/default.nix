{self, ...}: {
  flake.nixosModules.gaming = {...}: {
    imports = with self.nixosModules; [
      steam
    ];
  };
}
