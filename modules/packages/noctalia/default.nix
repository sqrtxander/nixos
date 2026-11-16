{inputs, ...}: {
  perSystem = {unstablePkgs, ...}: {
    packages.noctalia = inputs.wrappers.wrappers.noctalia.wrap {
      pkgs = unstablePkgs;
    };
  };
}
