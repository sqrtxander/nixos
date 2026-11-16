{ self, ... }: {
  flake.nixosModules.devDeps = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      rustup
      go
      python315
      python312
      bun
      nodejs
      perl
      typst

      wget
      curl
      jq
    ];
  };
}
