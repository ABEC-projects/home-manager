{ pkgs, config, lib, ...}:
let
waylandPackages = with pkgs; [ wl-clipboard rofi-wayland];
X11Packages = with pkgs; [ rofi ];
in {
  home.packages = lib.lists.flatten [
    (if config.useWayland == true then waylandPackages else [])
    (if config.useX11 == true then X11Packages else [])
  ];
  nixpkgs.overlays = [];
}
