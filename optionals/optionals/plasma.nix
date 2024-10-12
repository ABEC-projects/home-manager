myConfig:
{ config, lib, ... }:
let
  plasma = <plasma-manager/modules>;
in
myConfig "usePlasma" {
  imports = [plasma];
  programs.plasma = {
    enable = true;
  };
}
