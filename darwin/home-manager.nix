{ config, pkgs, lib, home-manager, user, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... } : {

      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        stateVersion = "21.11";
      };

      programs = {} // import ../shared/home-manager/programs.nix { inherit config pkgs lib; };
    };
  };

  homebrew = {
    enable = true;
    casks = [
      "microsoft-remote-desktop"
      "teamviewer"
      "slack"
      "caffeine"
      "alfred"
      "drawio"
      "firefox"
      "istat-menus"
      "microsoft-auto-update"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-outlook"
      "microsoft-teams"
      "onedrive"
      "rectangle"
      "spotify"
      "vmware-fusion"
      "whatsapp"
      "zoom"
      "openvpn-connect"
      "wezterm"
      "visual-studio-code"
    ];
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
      { path = "/Applications/Visual Studio Code.app/"; }
      { path = "/Applications/Spotify.app/"; }
      { path = "/Applications/Wezterm.app/"; }
      { path = "/Applications/WhatsApp.app/"; }
      { path = "/Applications/VMware Fusion.app/"; }
    ];
  };

}
