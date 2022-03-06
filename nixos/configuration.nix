{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.video.hidpi.enable = true;

  boot = {
    initrd = {
      availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  time.timeZone = "Europe/Amsterdam";

  networking = {
    hostName = "nixos";
    useDHCP = false;
    interfaces = {
      ens33.useDHCP = true;
      ens34.useDHCP = true;
    };
    firewall.enable = false;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  users.mutableUsers = false;
  users.users.root.initialPassword = "root";
  users.users.iverberk = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" ];
    initialPassword = "iverberk";
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    dpi = 220;
    autoRepeatDelay = 150;
    autoRepeatInterval = 30;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;
    };

    windowManager = {
      i3.enable = true;
    };
  };

  # virtualisation.docker.enable = true;
  virtualisation.vmware.guest.enable = true;

  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "yes";

  environment.systemPackages = with pkgs; [ ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

