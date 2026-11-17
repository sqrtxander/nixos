{moduleWithSystem, ...}: {
  flake.nixosModules.development-typst = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      typst
      tinymist
    ];
  });
  perSystem = {unstablePkgs, ...}: {
    packages.typst = unstablePkgs.typst;
    packages.tinymist = unstablePkgs.tinymist;
  };
}
