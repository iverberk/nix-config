{ config, pkgs, lib, home-manager, user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... } : {

      home = {
        enableNixpkgsReleaseCheck = false;
        packages = [ pkgs.dockutil ];
        stateVersion = "21.11";
      };
    };
  };

  homebrew = {
    enable = true;

    brews = [
      "mas"
    ];

    casks = [
      "ollama"
      "lm-studio"
      "microsoft-remote-desktop"
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
      "openvpn-connect"
      "rectangle"
      "spotify"
      "vmware-fusion"
      "whatsapp"
      "zoom"
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
      { path = "/Applications/Microsoft Outlook.app/"; }
      { path = "/Applications/Microsoft To Do.app"; }
      { path = "/Applications/Spotify.app/"; }
      { path = "/Applications/WhatsApp.app/"; }
      { path = "/Applications/VMware Fusion.app/"; }
      { path = "/Applications/Bitwarden.app/"; }
    ];
  };

}
