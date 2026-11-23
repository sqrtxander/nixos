{...}: {
  flake.nixosModules.education = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      anki
      zotero
    ];
  };
}
