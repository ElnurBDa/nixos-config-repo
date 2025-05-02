{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  users.users.deployer = {
    isNormalUser = true;
    description = "Deployment User";
    extraGroups = [ "wheel" "docker" ];
    password = "deployer";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    btop
    ctop
    docker-compose
    git
    bat
    httpie
    duf
  ];

  # Aliases
  environment.shellAliases = {
    cat = "bat -p ";
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "insecure-registries" = [ "registry-1.docker.io" ];
    };
  };

  # OpenSSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "no";
  };

  # No Firewall
  networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
