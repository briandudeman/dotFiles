{ cfg, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "a_tree";
  home.homeDirectory = "/home/a_tree";
  

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user.email = "brianjl1944@gmail.com";
      user.name = "briandudeman";
      safe.directory = "/etc/nixos";
    };
  };

#  services.greetd = {
#    enable = true;
#    settings = rec {
#      initial_session = {
#        command = "${pkgs.sway}/bin/sway";
#        user = "a_tree";
#      };
#      default_session = initial_session;
#    };
#  };





  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
        modules-center = [ "sway/window" "custom/hello-from-waybar" ];
        modules-right = [ "mpd" "custom/mymodule#with-css-id" "temperature" ];
  
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };

  };



  wayland.windowManager.sway = rec {
    enable = true;
    package = pkgs.swayfx;
    checkConfig = false;
    config = rec {
      modifier = "Mod4"; 
      terminal = "kitty";
      gaps = {
        inner = 5;
        #outer = 5;
      };
      startup = [
        {command = "firefox";}
      ];
      keybindings =
        let modifier = config.modifier; terminal = config.terminal;
        in lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+q" = "kill";
          "${modifier}+f" = "exec firefox";  
          "${modifier}+w" = "exec :";  
      };
      
    };
    extraConfig = ''
      corner_radius 4
      bar {
        swaybar_command waybar
      }
    '';

  };

    

  stylix = rec {
    base16Scheme = {
    base00 = "433434";
    base01 = "3c3836";
    base02 = "504945";
    base03 = "8F6E6E"; # comments, invisibles, line highlighting
    base04 = "bdae93";
    base05 = "dbb9ae"; # default foreground, caret, delimiters, operators
    base06 = "ebdbb2";
    base07 = "fbf1c7";
    base08 = "fcedc1"; # variables, xml tags, markup link text, markup lists, diff deleted
    base09 = "df8f5f"; # integers, boolean, constants, xml attributes, markup link url
    base0A = "b7d5ed"; # classes, markup bold, search text background
    base0B = "cab1d8"; # strings, inherited class, markup code, diff inserted, default kitty text with stylix
    base0C = "8ec07c"; # support, regex, escape characters
    base0D = "f6cdc6"; #  functions, methods, attribute ids, headings
    base0E = "d3869b"; # keywords, storage, selector, markup italic, diff changed
    base0F = "d65d0e";
    };
    enable = true;
    image = ./wallpaper_pink_mountain_1920x1080.jpg;
    targets.kitty = {
      enable = true;
      colors.enable = true;
      colors.override = base16Scheme;
    };
  };

  programs.vim = {
    enable = true;
    settings = {
      number = true;
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      background = "light";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      dynamic_background_opacity = "yes";
    };
    extraConfig = "background_opacity 0.9";
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    regreet
    kitty
    wget
    firefox
    
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/a_tree/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  
  # Let Home Manager install and manage itself.

  programs.home-manager.enable = true;
}
