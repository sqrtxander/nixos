{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.zsh = moduleWithSystem ({
    self',
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [
      (final: prev: {
        zsh = self'.packages.zsh;
      })
    ];
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        histSize = 1000;
      };
      zoxide = {
        enable = true;
        flags = ["--cmd cd"];
        enableZshIntegration = true;
      };
    };
    users.defaultUserShell = pkgs.zsh;
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages = {
      zsh = inputs.wrappers.wrappers.zsh.wrap {
        inherit pkgs;
        runtimePkgs = with pkgs; [zoxide fzf];
        zshAliases = {
          ls = "ls --color";
          ll = "ls -alF";
          aac = "NVIM_APPNAME=\"aac.nvim\" ${lib.getExe pkgs.neovim}";
        };
        zshrc.content = ''
          autoload -Uz compinit && compinit
          bindkey -e
          export MANPAGER="${lib.getExe pkgs.neovim} -c 'Man!' -o -"
          export EDITOR="${lib.getExe pkgs.neovim}"
          eval "$(${lib.getExe self'.packages.ohMyPosh} init zsh)"
          source <(${lib.getExe pkgs.fzf} --zsh)
          bindkey '^Y' autosuggest-accept
        '';
      };
      ohMyPosh = inputs.wrappers.wrappers.oh-my-posh.wrap {
        inherit pkgs;
        configFile = ./config.toml;
      };
    };
  };
}
