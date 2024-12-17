{ config, pkgs, lib, ... } :
{
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "iverberk";
    homeDirectory = "/home/iverberk";
    stateVersion = "23.11";

    packages = with pkgs; [
      bat
      fd
      fzf
      jq
      ripgrep
      tree
      watch
      nodejs
      firefox
      openvpn
      mutagen
      kubectl
      k9s
      kind
      tektoncd-cli
    ];

    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 128;
      x11.enable = true;
    };

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "nvim";
      PAGER = "less -FirSwX";
    };
  };

  services = {
    gpg-agent = {
      enable = true;
    };
  };

  programs = {

    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
    };

    wezterm = {
      enable = true;
      extraConfig = builtins.readFile config/wezterm.lua;
    };

    i3status = {
      enable = true;

      general = {
        colors = true;
        color_good = "#8C9440";
        color_bad = "#A54242";
        color_degraded = "#DE935F";
      };

      modules = {
        ipv6.enable = false;
        "wireless _first_".enable = false;
        "battery all".enable = false;
      };
    };

    gpg = {
      enable = true;
    };

    lazygit = {
      enable = true;
    };

    go = {
      enable = true;
    };

    neovim = {
      enable = true;
      package = pkgs.unstable.neovim-unwrapped;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = [pkgs.gcc];
    };

    starship = {
      enable = true;

      enableZshIntegration = true;
      settings = {
        add_newline = false;
      };
    };

    fzf = {
      enable = true;
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
      autocd = false;
      cdpath = [ "~/Code" ];
      plugins = [];

      initExtra = ''
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

        # Remove history data we don't want to see.
        export HISTIGNORE="pwd:ls:cd"

        export EDITOR="nvim"

        # Always color ls and group directories.
        alias ls='ls -la --color=auto'
      '';

      shellAliases = {
        g = "git";
        ga = "git add";
        gb = "git branch";
        gbr = "git branch";
        gc = "git commit -v --untracked-files=no";
        gcl = "git clone";
        gco = "git checkout";
        gcob = "git checkout -b";
        gcom = "git checkout master";
        gcp = "git cherry-pick";
        gd = "git diff";
        gdca = "git diff --cached";
        gf = "git fetch";
        gl = "git log";
        gm = "git merge";
        gma = "git merge --abort";
        gmff = "git fetch && git merge --ff-only";
        gp = "git push";
        gpl = "git pull";
        gplr = "git pull --rebase";
        gpo = "git push origin";
        gps = "git push";
        gpsu = "git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
        gr = "git reset";
        grbm = "git rebase master";
        grc = "git rebase --continue";
        grh = "git reset --hard";
        grst = "git reset";
        gs = "git show";
        gsp = "git fetch && git rebase --autostash && git push";
        gst = "git status";
        gt = "git tag";

        k = "kubectl";
        K = "kubectl -n kube-system";
        ka = "kubectl apply";
        Ka = "kubectl apply -n kube-system";
        kco = "kubectl config";
        kc = "kubectl create";
        Kc = "kubectl create -n kube-system";
        kcsn = "kubectl config set-context --current --namespace";
        kd = "kubectl describe";
        Kd = "kubectl describe -n kube-system";
        kdp = "kubectl describe pod";
        Kdp = "kubectl describe pod -n kube-system";
        kdd = "kubectl describe deployment";
        Kdd = "kubectl describe deployment -n kube-system";
        kdc = "kubectl describe configmaps";
        Kdc = "kubectl describe configmaps -n kube-system";
        kds = "kubectl describe services";
        Kds = "kubectl describe services -n kube-system";
        kdss = "kubectl describe statefulsets.apps";
        Kdss = "kubectl describe statefulsets.apps -n kube-system";
        kdn = "kubectl describe node";
        kg = "kubectl get";
        Kg = "kubectl get -n kube-system";
        kgp = "kubectl get pod";
        Kgp = "kubectl get pod -n kube-system";
        kgss = "kubectl get statefulsets.apps";
        Kgss = "kubectl get statefulsets.apps -n kube-system";
        kgd = "kubectl get deployment";
        Kgd = "kubectl get deployment -n kube-system";
        kgc = "kubectl get configmaps";
        Kgc = "kubectl get configmaps -n kube-system";
        kgs = "kubectl get services";
        Kgs = "kubectl get services -n kube-system";
        kgn = "kubectl get node";
        kD = "kubectl delete";
        KD = "kubectl delete -n kube-system";
        kDp = "kubectl delete pod";
        KDp = "kubectl delete pod -n kube-system";
        kDss = "kubectl delete statefulsets.apps";
        KDss = "kubectl delete statefulsets.apps -n kube-system";
        kDd = "kubectl delete deployment";
        KDd = "kubectl delete deployment -n kube-system";
        kDc = "kubectl delete configmaps";
        KDc = "kubectl delete configmaps -n kube-system";
        kDs = "kubectl delete services";
        KDs = "kubectl delete services -n kube-system";
        kDn = "kubectl delete node";
        KDn = "kubectl delete node -n kube-system";
        kr = "kubectl replace";
        ke = "kubectl explain";
        kl = "kubectl logs";
        Kl = "kubectl logs -n kube-system";
        kp = "kubectl proxy";
        kpf = "kubectl port-forward";
        kns = "kubectl config set-context $(kubectl config current-context) --namespace ";
        kro = "kubectl rollout";
        kx = "kubectl explain";

        c = "\clear";
        v = "nvim";
        lg = "lazygit";
        tf = "terraform";
      };

      profileExtra = ''
        setopt incappendhistory
        setopt appendhistory 
      '';
    };

    git = {
      enable = true;
      ignores = [ "*.swp" ];
      userName = "Ivo Verberk";
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
    };

  };

  xdg.enable = true;

  xdg.configFile."lazygit/config.yml".text = builtins.readFile config/lazygit.yml;
  xdg.configFile."starship.toml".text = builtins.readFile config/starship.toml;
  xdg.configFile."nvim" = { source = config/nvim; recursive = true; };
  xdg.configFile."i3/config".text = builtins.readFile config/i3;
  # xdg.configFile."ghostty/config".text = builtins.readFile config/ghostty;

  xresources.extraConfig = builtins.readFile config/Xresources;
}
