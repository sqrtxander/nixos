{
  description = "sqrtxander/nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrappers.url = "github:nix-community/nix-wrapper-modules";

    wallpaper-generator.url = "github:sqrtxander/wallpaper_generator";

    cyberdream.url = "github:scottmckendry/cyberdream.nvim";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);
}
