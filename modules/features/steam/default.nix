{moduleWithSystem, ...}: {
  flake.nixosModules.steam = moduleWithSystem ({unfreePkgs, ...}: {
    environment.systemPackages = with unfreePkgs; [
      steam
    ];
  });
}
