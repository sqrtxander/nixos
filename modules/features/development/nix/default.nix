{...}: {
  flake.nixosModules.development-nix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      alejandra # formatter
      nixd # lsp
    ];
  };
}
