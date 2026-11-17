{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.noctalia = moduleWithSystem ({
    self',
    pkgs,
  }: {
    environment.systemPackages = [
      self'.packages.noctalia
    ];
  });
  perSystem = {unstablePkgs, ...}: {
    packages.noctalia = inputs.wrappers.wrappers.noctalia.wrap {
      pkgs = unstablePkgs;
      settings = builtins.fromTOML (builtins.readFile ./config.toml);
    };
  };
}
