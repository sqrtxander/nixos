{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.starbattle = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      starbattleConfiguration
    ];
  };
}
