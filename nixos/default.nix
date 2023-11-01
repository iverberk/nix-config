{ config, inputs, pkgs, ... } :
{
  imports = [
    ./disk-config.nix
    ./vmware-guest.nix
    ../shared
  ];

  ## Settings

  # Setup qemu so we can run x86_64 binaries
  # boot.binfmt.emulatedSystems = ["x86_64-linux"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 42;

  # VMware, Parallels both only support this being 0 otherwise you see
  # "error switching console mode" on boot.
  boot.loader.systemd-boot.consoleMode = "0";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [ "uhci_hcd" "xhci_pci" "ahci" "nvme" "usbhid" "sr_mod" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.hostName = "dev"; # Define your hostname.
  networking.useDHCP = false;
  networking.interfaces.ens160.useDHCP = true;
  networking.firewall.enable = false;

  # Turn on flag for proprietary software
  nix = {
    nixPath = [ "nixos-config=/home/iverberk/.local/share/src/nixos-config:/etc/nixos" ];
    settings = {
      allowed-users = [ "iverberk" ];
    };
  };

  # Video support
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  disabledModules = [ "virtualisation/vmware-guest.nix" ];
  virtualisation.vmware.guest.enable = true;

  # Add docker daemon
  virtualisation.docker.enable = true;
  virtualisation.docker.logDriver = "json-file";

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  ## Sway settings
  security.polkit.enable = true;
  
  ##

  users = {
    users.iverberk = {
      isNormalUser = true;
      home = "/home/iverberk";
      extraGroups = [ "docker" "wheel" ];
      shell = pkgs.zsh;
      hashedPassword = "$6$9C2p8Wlxq6KBZWyg$HnwZhzP4tfgsw/3/p.kd47A3bk09kU05.EYrwJBeW2923JaPjXHcEzBlpK.Qp38fXI9BS1idBxhjBaf9VZ0pT0";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFAy4KxFlFnpvVhGzr4U/2w30N/t6BErFu0P+Sb6ulav" ]; 
    };

    mutableUsers = false;
  };

  # Share our host filesystem
  fileSystems."/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:/";
    options = [
      "umask=22"
      "uid=1000"
      "gid=1000"
      "allow_other"
      "auto_unmount"
      "defaults"
    ];
  };

  system.stateVersion = "23.05"; # Don't change this

  ## Services

  services.openssh = {
    enable = true;
    settings = { 
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  ## Programs

  programs.gnupg.agent.enable = true;
  programs.zsh.enable = true;

  ## Packages

  environment = {
    systemPackages = with pkgs; [
      cachix
      gnumake
      killall
      rxvt_unicode
      xclip
      gtkmm3

      # For hypervisors that support auto-resizing, this script forces it.
      # I've noticed not everyone listens to the udev events so this is a hack.
      (writeShellScriptBin "xrandr-auto" ''
        xrandr --output Virtual-1 --auto
      '')
    ];

    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS="1";
    };
  };

}