myConfig:
{ config, lib, ... }:
let
  plasma = <plasma-manager/modules>;
  enable = myConfig.usePlasma;
in
if enable then {
  imports = [plasma];
  programs.plasma = {
    enable = enable;
  };
}
else {}
