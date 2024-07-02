{ config, pkgs, ... }:

{
  home = {
    username = "moni";
    homeDirectory = "/home/moni";
    stateVersion = "24.05";

    packages = with pkgs; [
      pkgs.jdk8

      # wget
      swww # for wallpapers
      meson
      tofi
      wl-clipboard
      grim
      slurp

      whatsapp-for-linux
      steam
      steam-run
      bottles
      lutris

      firefox
      dunst
      git
      spotify
      alacritty
      warp-terminal
      neovim
      zsh
      zsh-completions
      zsh-syntax-highlighting
      dolphin
      fzf
      neofetch
      htop
      tmux
      unzip
      speedtest-cli
      ranger
    ];

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
	theme = "agnoster";
	plugins = [ "git" ];
      };
      shellAliases = {
        z = "zoxide";
        nixrb = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
	homerb = "home-manager switch --flake /etc/nixos#moni";
	nixconf = "sudo nvim /etc/nixos/configuration.nix";
	flakeconf = "sudo nvim /etc/nixos/flake.nix";
	homeconf = "sudo nvim /etc/nixos/home.nix";
	genlist = "sudo nix-env --list-generations -p /nix/var/nix/profiles/system";
      };
    };
  };
}
