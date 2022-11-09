# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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
  
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
    ];
  };
  
  services.tailscale.enable = true;
  

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
    pcmanfm
    joplin-desktop
    ranger
    waybar
    exercism
    blueberry
    vlc
    firefox
    zathura
    restream
    discord
    element-desktop
    # programming
    git
    gh
    drawio
    sbcl
    go
    rustup
    gcc
    racket-minimal
    rnix-lsp
    ccls
    rust-analyzer
    nodejs
    nodePackages.pyright
    nodePackages.bash-language-server
    nodePackages.ts-node    
    python310
    python310Packages.pytest
    spyder
    lispPackages.quicklisp
    omnisharp-roslyn
    mono
    dotnet-sdk
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
  ]; 
  
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };        
    };
  };  
  
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      foot  
    ];
  };
  
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
    bluetooth = {
      enable = true;
    };
  };

  sound.enable = true;

  programs.starship = {
    enable = true;
  };

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
