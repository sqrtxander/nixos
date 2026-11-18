{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.noctalia = moduleWithSystem ({self'}: {
    environment.systemPackages = [
      self'.packages.noctalia
    ];
  });
  perSystem = {unstablePkgs, ...}: {
    packages.noctalia = inputs.wrappers.wrappers.noctalia.wrap {
      pkgs = unstablePkgs;
      settings = fromTOML (builtins.readFile ./config.toml);
      colors = builtins.fromJSON (builtins.readFile ./cyberdream.json);
    };
  };
}
