{...}: {
  flake.nixosModules.networking = {...}: {
    networking = {
      networkmanager.enable = true;
      nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      firewall.enable = true;
    };
  systemd.services.NetworkManager-wait-online.enable = false;
  };
}
