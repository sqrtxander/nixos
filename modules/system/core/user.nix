{...}: {
  flake.nixosModules.user = {...}: {
    users.users."xander" = {
      isNormalUser = true;
      description = "Xander James";
      initialPassword = "password";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
