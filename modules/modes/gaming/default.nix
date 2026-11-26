{self, ...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    imports = with self.nixosModules; [
      steam
    ];
    environment.systemPackages = with pkgs; [
      (pkgs.prismlauncher.override {
        additionalLibs = with pkgs; [
          glfw3-minecraft
        ];
      })
    ];
  };
}
