{ lib, ... }:
let 
nixgl = import <nixgl>{};
package-path = nixgl.auto.nixGLDefault or "";
exec = if package-path != "" then "${package-path}/bin/nixGL" else "";
mkOptionDisabled = description:
  lib.mkOption {
    type = with lib.types; uniq bool;
    default = false;
    example = true;
    inherit description;
  };
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
  options.useWayland = mkOptionDisabled ''
    Weather to include wayland-specific configs, packages, etc.
  '';
  options.useX11 = mkOptionDisabled ''
    Weather to include X11-specific configs, packages, etc.
  '';
  options.useNixGL = mkOptionDisabled ''
    Weather to include nixGL overlays.
    May be helpful on not nixOS distros if you are having problems with some apps
  '';
}
