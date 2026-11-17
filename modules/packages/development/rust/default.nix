{...}: {
  flake.nixosModules.development-rust = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      rustup
    ];
  };
}
