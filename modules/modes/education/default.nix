{moduleWithSystem, ...}: {
  flake.nixosModules.education = moduleWithSystem ({
    pkgs,
    unfreePkgs,
    ...
  }: {
    environment.systemPackages =
      (with pkgs; [
        anki
        zotero
      ])
      ++ (with unfreePkgs; [
        zoom-us
      ]);
  });
}
