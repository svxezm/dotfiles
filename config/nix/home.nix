{ config, pkgs, ... }:

{
  home = {
    username = "liz";
    homeDirectory = "/home/liz";
    stateVersion = "24.05";

    packages = with pkgs; [
      git
      gnupg
      alacritty
      neovim
      zsh
      zsh-completions
      zsh-syntax-highlighting
      fzf
      neofetch
      htop
      nvtopPackages.nvidia
      zoxide
      postman

      tmux
      unzip
      speedtest-cli
      ranger
      lxqt.lxqt-openssh-askpass
      mtr
      ani-cli
      mpv
      tor-browser
      krita
      obs-studio
      lmms
      gwenview
      imagemagick
      bun
      yt-dlp
      zip
      mkcert
      wl-clipboard-x11
      ngrok
      arduino-ide
      thonny
      gimp
      nodePackages.vercel
      translatepy
      poppler_utils
      koboldcpp
    ];

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      PATH = "${config.home.profileDirectory}/bin:${config.home.profileDirectory}/sbin:$PATH";
      SSH_ASKPASS = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
    };

    file = {
      ".config/alacritty/alacritty.toml".text = ''
      	[window]
	opacity = 0.7
	blur = true
	padding = { x = 15, y = 15 }
	dynamic_padding = true

	[font.normal]
	family = "FiraCode Nerd Font"
	style = "Regular"

	[colors]
	cursor = { text = "#6c393c", cursor = "#ecb5bb" }
	[colors.search]
	  matches = { foreground = "#4e186c", background = "#b66fdc" }
      '';
      ".gitconfig".text = ''
        [user]
	  name = svxezm
	  email = "igorb.kuhl@gmail.com"
	  signingkey = 19980C0A02DDC1CE
	[core]
	  sshCommand = ssh -i ~/.ssh/id_rsa
	[init]
	  defaultBranch = main
      '';
      ".zshrc".text = ''
	if [ "$TMUX" = "" ]; then tmux; fi

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
	aformat=sample_fmts=u8|s16:channel_layouts=stereo
      '';
      # use the command `ssh-keyscan github.com` and paste all the response in the field below
      ".ssh/known_hosts".text = ''
      '';
      ".ssh/config".text = ''
        Host *
	  ForwardAgent yes
      '';
      ".tmux.conf".text = ''
      	unbind C-b
	set-option -g prefix C-Space
	bind-key C-Space send-prefix

	bind h split-window -h
	bind v split-window -v
	unbind '"'
	unbind %

	bind r source-file ~/.tmux.conf

      	bind -n M-Left select-pane -L
      	bind -n M-Right select-pane -R
      	bind -n M-Up select-pane -U
      	bind -n M-Down select-pane -D

	set-option -g default-shell $SHELL
	set -sg escape-time 5

	# DESIGN TWEAKS

	# clock mode
	setw -g clock-mode-colour pink

	# panes
	set -g pane-border-style 'fg=pink'
	set -g pane-active-border-style 'fg=yellow'

	# statatusbar
	set -g status-position bottom
	set -g status-justify left
	set -g status-style 'fg=pink'

	set -g status-left ' '
	set -g status-left-length 10

	set -g status-right-style 'fg=black bg=pink'
	set -g status-right '%Y-%m-%d %H:%M '
	set -g status-right-length 50

	setw -g window-status-current-style 'fg=black bg=pink'
	setw -g window-status-current-format ' #I #W #F '

	setw -g window-status-style 'fg=pink bg=black'
	setw -g window-status-format ' #I #[f=white]#W #[fg=pink]#F '

	setw -g window-status-bell-style 'fg=colour250 bg=white bold'

	# messages
	set -g message-style 'fg=white bg=pink bold'
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
	theme = "funky";
	plugins = [ "git" "zoxide" "z" ];
      };
      shellAliases = {
	v = "nvim";
        nixrb = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
	homerb = "home-manager switch --flake /etc/nixos#liz";
	nixconf = "sudo nvim /etc/nixos/configuration.nix";
	flakeconf = "sudo nvim /etc/nixos/flake.nix";
	homeconf = "sudo nvim /etc/nixos/home.nix";
	hyprconf = "nvim ~/.config/hypr/hyprland.conf";
	genlist = "sudo nix-env --list-generations -p /nix/var/nix/profiles/system";
	upgrade = "sudo nixos-rebuild switch --upgrade";
	nixcg = "nix-collect-garbage";
	cleangens = "sudo nix-collect-garbage -d";
	copynix = "cp /etc/nixos/* ~/Downloads/dotties/nixos";
	copyhypr = "cp ~/.config/hypr/* ~/Downloads/dotties/hypr";
	copywaybar = "cp ~/.config/waybar/* ~/Downloads/dotties/waybar";
	copyfiles = "copynix && copyhypr && copywaybar";
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
