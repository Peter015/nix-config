# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  hardware = {
     pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      daemon.config = {
        default-sample-rate = 48000;
        default-fragments = 8;
        default-fragment-size-msec = 10;
      };
    };
    bluetooth.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  sound.enable = true;
    
  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };
  
  # networking  
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.checkReversePath = "loose";
  };
  
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  
  xdg.portal.wlr.enable = true;

  # services
  services = { 
    xserver = {
      layout = "us";
      xkbVariant = "";
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };
    tailscale.enable = true;
    flatpak.enable = true;
  };
  
 # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peterz = {
    isNormalUser = true;
    description = "Peter Zimmermann";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade.enable = true;
  
  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        foot
        swaybg  
      ];
    };
    starship.enable = true;
    light.enable = true;
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	helix # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  	wget
	  river
	  wayfire
	  chromium
	  emacs
	  kitty
    exa
    bat
    ripgrep
    pavucontrol
    slurp
    grim
    starship
    fuzzel
    fish
    thunderbird
    rlwrap
    waybar
    exercism
    vlc
    zathura
    restream
    discord
    xfce.thunar
    lsof
    mako
    wlogout
    kanshi
    hikari
    ksh
    spotify
    xdg-utils
    blueberry
    # programming
    cargo-tauri
    azure-cli
    git
    gh
    sbcl
    rustup
    gcc
    racket
    rnix-lsp
    ccls
    clang
    rust-analyzer
    nodePackages.bash-language-server
    nodePackages.ts-node    
    nodePackages.typescript-language-server
    nodePackages."@angular/cli"
    nodePackages.vscode-html-languageserver-bin
    python310Packages.ipython
    # python310Packages.python-lsp-server
    lispPackages.quicklisp
    lispPackages_new.sbclPackages.cl-project
    node2nix
    nodejs
  ];

  
  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    powerline-fonts
    ibm-plex
  ]; 
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "22.05"; # Did you read the comment?

}
