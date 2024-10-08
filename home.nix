{ config, pkgs, ... }:
let 
  nixGL = import ./nixGL.nix { inherit pkgs config; };
  nixGLOverlay = pkg_name: final: previous: {"${pkg_name}" = (nixGL previous."${pkg_name}");};
in
{
  imports = [ ./options.nix <plasma-manager/modules>];

  nixpkgs.overlays = [
      (nixGLOverlay "kitty")
      (nixGLOverlay "steam")
      (nixGLOverlay "mpv")
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_:true);
  };
  home.username = "abec";
  home.homeDirectory = "/home/abec";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    fooyin
    bat
    lsd
    yazi
    nil
    obsidian
    syncthing
    maestral
    neovim
    keepassxc
    git
    gh
    mesa
    tree-sitter
    zoxide
    fzf
    gcc
    zig
    zls
    mpv
    (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" ]; })
    steam
    gamemode
    nomacs
    kitty
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/zsh";
    ".zshrc".source = "${config.home.homeDirectory}/.config/home-manager/.zshrc";
  };

  fonts.fontconfig.enable = true;


  programs.kitty = {
    enable = true;
    settings = {
        font_family = "Bitstream Wera";
        enable_audio_bell = "no";
        wheel_scroll_multiplier = "20.0";
        wheel_scroll_min_lines = "2";
        touch_scroll_multiplier = "10.0";
        kitty_mod = "ctrl+alt";
    };
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
  #  /etc/profiles/per-user/abec/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  systemd.user.services.syncthing = {
    Unit = {Description = "Run syncting on boot";};
    Install = {WantedBy = [ "default.target" ];};
    Service = {
      ExecStart = "${pkgs.syncthing}/bin/syncthing";
    };

  };

  systemd.user.services.maestral = {
    Unit = {Description = "Run maestral on boot";};
    Service = {
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
    };
  };

  programs = {
    plasma = {
      enable = true;
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
