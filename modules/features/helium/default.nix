{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.helium = moduleWithSystem ({system, ...}: {
    environment.systemPackages = [
      inputs.helium.packages.${system}.default
    ];
  });
}
