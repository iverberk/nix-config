{ config, pkgs, user, ... }:
{
  imports = [
    ./home-manager.nix
    ../shared
  ];

  nix = {
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  networking.hostName = "mbp";

  system = {
    primaryUser = "iverberk";

    stateVersion = 4;

    activationScripts.postActivation.text = ''
      # Update Homebrew taps to latest versions
      echo "Updating Homebrew taps..."
      sudo -H -u ${user} /opt/homebrew/bin/brew update
      
      # Upgrade all Homebrew packages to latest versions
      echo "Upgrading Homebrew packages..."
      sudo -H -u ${user} /opt/homebrew/bin/brew upgrade --greedy || echo "Some packages failed to upgrade, continuing..."
    '';

    checks = {
      verifyNixPath = false;
    };

    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };

      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        FXPreferredViewStyle = "Nlsv";
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
