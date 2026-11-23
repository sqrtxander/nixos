{...}: {
  flake.nixosModules.zotero = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zotero
    ];
  };
}
