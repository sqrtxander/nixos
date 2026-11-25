{self, ...}: {
  flake.nixosModules.development = {pkgs, ...}: {
    imports = with self.nixosModules; [
      git
      neovim
      tmux
    ];
    environment.systemPackages = with pkgs; [
      alejandra
      ffmpeg
      htop
      jq
      prek
      tree
    ];
  };
}
