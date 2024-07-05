{ config, pkgs, ... }:

{
  home = {
    username = "moni";
    homeDirectory = "/home/moni";
    stateVersion = "24.05";

    packages = with pkgs; [
      pkgs.jdk8

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
    ];

    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      PATH = "${config.home.profileDirectory}/bin:${config.home.profileDirectory}/sbin:$PATH";
      SSH_ASKPASS = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
    };

    file = {
      ".zshrc".text = ''
        if [ -e "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh" ]; then
          source "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"
        fi

        if [ -z "$SSH_AUTH_SOCK" ]; then
          eval `ssh-agent -s`
          ssh-add ~/.ssh/id_rsa
        fi
      '';
      ".ssh/known_hosts".text = ''
        github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
	github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
	github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
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
        nixrb = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
	homerb = "home-manager switch --flake /etc/nixos#moni";
	nixconf = "sudo nvim /etc/nixos/configuration.nix";
	flakeconf = "sudo nvim /etc/nixos/flake.nix";
	homeconf = "sudo nvim /etc/nixos/home.nix";
	genlist = "sudo nix-env --list-generations -p /nix/var/nix/profiles/system";
      };
    };
    ssh = {
      enable = true;
      extraConfig = ''
        AddKeysToAgent yes
      '';
      forwardAgent = true;
    };
  };
}
