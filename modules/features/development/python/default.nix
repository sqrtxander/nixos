{...}: {
  flake.nixosModules.development-python = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      python315
      python312
    ];
  };
}
