{ config, pkgs, ... }:

{
  home = {
    username = "moni";
    homeDirectory = "/home/moni";
    stateVersion = "24.05";

    packages = with pkgs; [
      git
      gnupg
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
      lxqt.lxqt-openssh-askpass
      mtr
      ani-cli
      mpv
    ];

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      PATH = "${config.home.profileDirectory}/bin:${config.home.profileDirectory}/sbin:$PATH";
      SSH_ASKPASS = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
    };

    file = {
      ".gitconfig".text = ''
        [user]
	  name = monitzz
	  email = "igorb.kuhl@gmail.com"
	[core]
	  sshCommand = ssh -i ~/.ssh/id_rsa
      '';
      ".zshrc".text = ''
        if [ -e "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh" ]; then
          source "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
        fi

        if [ -z "$SSH_AUTH_SOCK" ]; then
          eval `ssh-agent -s`
          ssh-add ~/.ssh/id_rsa
        fi

	sleep 2

	Hyprland
      '';
      ".config/mpv/mpv.conf".text = ''
        ao=pulse
	ao=alsa
	af=lavfi=[acompressor]
      '';
      # use the command `ssh-keyscan github.com` and paste all the response in the field below
      ".ssh/known_hosts".text = ''
      '';
      ".ssh/config".text = ''
        Host *
	  ForwardAgent yes
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";
      oh-my-zsh = {
        enable = true;
	theme = "agnoster";
	plugins = [ "git" "zoxide" "z" ];
      };
      shellAliases = {
	vim = "nvim";
        nixrb = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
	homerb = "home-manager switch --flake /etc/nixos#moni";
	nixconf = "sudo nvim /etc/nixos/configuration.nix";
	flakeconf = "sudo nvim /etc/nixos/flake.nix";
	homeconf = "sudo nvim /etc/nixos/home.nix";
	hyprconf = "nvim ~/.config/hypr/hyprland.conf";
	genlist = "sudo nix-env --list-generations -p /nix/var/nix/profiles/system";
	upgrade = "sudo nixos-rebuild switch --upgrade";
	nixcg = "nix-collect-garbage";
	cleangens = "sudo nix-collect-garbage -d";
	copyfiles = "cp ~/.config/hypr/* ~/Downloads/dotfiles/hypr && cp /etc/nixos/* ~/Downloads/dotfiles/nixos";
      };
    };
    home-manager.enable = true;
    ssh = {
      enable = true;
      extraConfig = ''
        AddKeysToAgent yes
      '';
      forwardAgent = true;
    };
  };
}
