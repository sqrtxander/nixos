{moduleWithSystem, ...}: {
  flake.nixosModules.development-typst = moduleWithSystem ({unstablePkgs, ...}: {
    environment.systemPackages = with unstablePkgs; [
      typst
      tinymist
    ];
  });
}
