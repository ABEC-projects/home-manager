myConfig:
{ pkgs, config, lib, ...}:
let
waylandPackages = with pkgs; [ wl-clipboard rofi-wayland ];
X11Packages = with pkgs; [ rofi ];
in {
  home.packages = lib.lists.flatten [
    (if config.useWayland  then waylandPackages else [])
    (if config.useX11  then X11Packages else [])
  ];
  nixpkgs.overlays = [];
}
