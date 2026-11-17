{...}: {
  flake.nixosModules.development-nix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      alejandra # formatter
      nil # lsp
    ];
  };
}
