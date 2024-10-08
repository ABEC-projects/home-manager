{ config, pkgs, ... }:
{
  imports = [ 
    ./options.nix
    <plasma-manager/modules> 
    ./packages.nix
    ./programs.nix
  ];

  home.username = "abec";
  home.homeDirectory = "/home/abec";


  home.file = {
    ".config/zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/zsh";
    ".zshrc".source = "${config.home.homeDirectory}/.config/home-manager/.zshrc";
  };

  fonts.fontconfig.enable = true;

  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/abec/etc/profile.d/hm-session-vars.sh
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
}
