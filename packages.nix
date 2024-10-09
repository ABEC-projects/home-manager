{ pkgs, config, lib, ...}:
let
nixGL = import ./nixGL.nix { inherit pkgs config; };
nixGLOverlay = pkg_name: final: previous: {"${pkg_name}" = (nixGL previous."${pkg_name}");};
in
{
  imports = [./windowSystemSpecific.nix];
  nixpkgs.overlays = lib.lists.flatten [
    (nixGLOverlay "kitty")
    (nixGLOverlay "steam")
    (nixGLOverlay "mpv")
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_:true);
  };

  home.packages = with pkgs; lib.lists.flatten  [
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
    lazygit
    nodejs_22
    go
  ];
}
