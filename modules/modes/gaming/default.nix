{self, ...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    imports = with self.nixosModules; [
      steam
    ];
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
  };
}
