# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
    ];

/*  boot.loader.grub.device = "/dev/sda";
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };
*/

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [ "nvidia-drm.modeset=1" "nvidia.NVreg_UsePageAttributeTable=1" ];
    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure keymap in X11
  services = {
    nscd.enable = false;
    libinput.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = "moni";
      };
     sddm = {
       wayland.enable = true;
       enable = true;
     };
     defaultSession = "hyprland";
    };
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "colemak";
        options = "eurosign:e";
      };
      videoDrivers = [ "nvidia" ];
      deviceSection = ''
        Section "Device"
	  Identifier "Device0"
	  Driver "nvidia"
	  Option "AllowEmptyInitialConfiguration"
	  Option "PrimaryGPU" "yes"
	EndSection
      '';
    };
    getty.autologinUser = "moni";
    dbus = {
      enable = true;
      packages = with pkgs; [
        pkgs.dbus
        pkgs.elogind
	pkgs.polkit
      ];
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;

    };
    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
	vaapiVdpau
	libvdpau-va-gl
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  sound.enable = true;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.moni = {
    isNormalUser = true;
    home = "/home/moni";
    description = "moni";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
      })
    ];
  };
  
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  
  fonts.packages = with pkgs; [
    nerdfonts
    meslo-lgs-nf
  ];

  environment = {
    systemPackages = with pkgs; [
      home-manager

      hyprland
      hyprpaper
      hyprlock
      hyprshade
      hyprpicker
      hyprcursor
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
      wlroots
      wayland-protocols
      wayland-utils
      waybar
      swww
      meson
      dunst
      wl-clipboard
      tofi
      grim
      slurp
      lxqt.lxqt-openssh-askpass

      discord
      whatsapp-for-linux
      steam
      steam-run
      bottles
      lutris
      firefox
      spotify

      gcc
      dotnet-sdk_8
      dotnet-runtime_8
      dotnet-aspnetcore_8
      dotnetCorePackages.dotnet_8.aspnetcore
      dotnetCorePackages.dotnet_8.runtime
      dotnetCorePackages.dotnet_8.sdk
      csharp-ls
      nodejs_22
      python313
      rustc
      cargo
   ];

   etc = {
     "profile.d/hm-session-vars.sh".source = "${pkgs.home-manager}/etc/profile.d/hm-session-vars.sh";
   };

    # Hint Electron apps to use wayland 
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    shells = [ pkgs.zsh ];
  };

  programs = {
    hyprland.enable = true;
     zsh = {
       enable = true;
     };
    mtr.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    ssh = {
      enableAskPassword = true;
      askPassword = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
    };
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  

  # List services that you want to enable:
  services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  system.nssModules = lib.mkForce [];

}
