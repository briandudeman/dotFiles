# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  #script test 7
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.optimise.automatic = true;

  # saved config garbage collection
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  systemd.services."backups" = {
  path = [ pkgs.nix ];
    script = "${pkgs.bash}/bin/bash /home/a_tree/runner.sh";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
  systemd.timers."backups" = {
    timerConfig = {
      OnActiveSec = "1s";
      OnUnitActiveSec = "1m";
      Persistent=true;
      Unit = "backups.service";
    };
    wantedBy = [ "timers.target" ];
  };



  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  stylix.enable = true;
  stylix.image = ./wallpaper_pink_mountain_1920x1080.jpg;
  

  #
  # Audio
  #
  #software.pulseaudio.enable = false; # Use Pipewire, the modern sound subsystem

  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment the following line if you want to use JACK applications
    # jack.enable = true;
  };

  #
  # Bluetooth
  #
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.a_tree = {
    isNormalUser = true;
    description = "Brian LewConklin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKkb1wZiV5YN+aS41GqNwBjAloJisdq2nxT0SPv136kg a_tree@nixos"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "a_tree" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  home-manager.useGlobalPkgs = false;
  home-manager.useUserPackages = true;
  security.polkit.enable = true;
  hardware.graphics.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  programs.ssh.startAgent = true;
  programs.ssh = {
    extraConfig = "

      Host grandview
        Hostname 192.168.1.70
        Port 22
        IdentityFile /home/a_tree/.ssh/CliveNetKey
        IdentitiesOnly yes    
        PasswordAuthentication yes    
    ";
  };

  programs.sway.enable = true;
  services.greetd.enable = true;
  programs.regreet.enable = true;
  services.pipewire.enable = true;  
  software.pulseaudio.enable = true;

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
  system.stateVersion = "25.11"; # Did you read the comment?

}
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


