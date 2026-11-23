{moduleWithSystem, ...}: {
  flake.nixosModules.neovim = moduleWithSystem ({self', ...}: {
    programs.neovim = {
      enable = true;
      package = self'.packages.neovim;
    };
  });
  perSystem = {inputs', ...}: {
    packages.neovim = inputs'.neovim.packages.default;
  };
}
