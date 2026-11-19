{moduleWithSystem, ...}: {
  flake.nixosModules.insync = moduleWithSystem ({unfreePkgs, ...}: {
    environment.systemPackages = with unfreePkgs; [
      insync
    ];
  });
}
