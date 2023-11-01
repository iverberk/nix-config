{ config, pkgs, lib, ... } :
{
  home-manager.enable = true;

  # Shared shell configuration
  zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = false;
    cdpath = [ "~/Code" ];
    plugins = [];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      export ALTERNATE_EDITOR=""
      export EDITOR="vim"

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = "iverberk";
    userEmail = "ivo.verberk@gmail.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	      editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      push.default = "tracking";
      rebase.autoStash = true;
    };
  };

  ssh = {
    enable = true;
    serverAliveInterval = 60;
    matchBlocks = {
      "dev" = {
        hostname = "10.131.6.7";
        identityFile = "~/.ssh/ncsc";
        forwardAgent = true;
        user = "ivver";
        localForwards = [
          {
            bind.port = 3390;
            host.address = "127.0.0.1";
            host.port = 3390;
          }
        ];
      };
    };
  };

}