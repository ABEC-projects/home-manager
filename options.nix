{ lib, ... }:
let 
    nixgl = import <nixgl>{};
    package-path = nixgl.auto.nixGLDefault or "";
    exec = if package-path != "" then "${package-path}/bin/nixGL" else "";
in
{
  options.nixGLPrefix = lib.mkOption {
    type = lib.types.str;
    default = exec;
    description = ''
      Will be prepended to commands which require working OpenGL.

      This needs to be set to the right nixGL package on non-NixOS systems.
    '';
  };
}
