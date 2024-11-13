myConfig:
{ config, lib, pkgs, ... }:
let
  plasma = <plasma-manager/modules>;
in
myConfig "useRust" {
  home.packages = with pkgs;[
    rustup
    bacon
  ];
}
