{...}: {
  flake.nixosModules.development-web = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      bun
      nodejs
    ];
  };
}
