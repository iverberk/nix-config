{ config, pkgs, lib, home-manager, user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;

    users.${user} = { pkgs, ... } : {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = [ pkgs.dockutil ];
        stateVersion = "24.05";
      };
    };
  };

  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      "mas"
    ];

    casks = [
      "teamviewer"
      "slack"
      "alfred"
      "drawio"
      "firefox"
      "istat-menus"
      "microsoft-auto-update"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "microsoft-outlook"
      "microsoft-teams"
      "onedrive"
      "rectangle"
      "spotify"
      "vmware-fusion"
      "visual-studio-code"
      "whatsapp"
      "zoom"
      "obsidian"
    ];

    masApps = {
      "Amphetamine " = 937984704;
      "Microsoft To Do" = 1274495053;
      "Bitwarden" = 1352778147;
    };

  };

  imports = [
   ./dock
  ];

  # Fully declarative dock using the latest from Nix Store
  local.dock = {
    enable = true;
    entries = [
      { path = "/Applications/Firefox.app/"; }
      { path = "/Applications/Ghostty.app/"; }
      { path = "/Applications/Visual Studio Code.app/"; }
      { path = "/Applications/Microsoft Outlook.app/"; }
      { path = "/Applications/Microsoft To Do.app"; }
      { path = "/Applications/Spotify.app/"; }
      { path = "/Applications/WhatsApp.app/"; }
      { path = "/Applications/VMware Fusion.app/"; }
      { path = "/Applications/Bitwarden.app/"; }
    ];
  };

}
