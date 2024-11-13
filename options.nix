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
  options.configFile = lib.mkOption {
    type = lib.types.uniq lib.mkOptionType {
      name = "Option config file";
      description = "Sets file that will be used by autoOptions.nix
                     to read options declarations from TOML or JSON";
    };
    default = {};
    example = { type = "TOML"; path = ./config.toml; };
    description = ''
      Used for getting options definitions from a file.
      `type` should be either `TOML` or `JSON`.
      `path` is the path to file containing attrset
        which represents the options set.
    '';
  };
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
  options.usePlasma = mkOptionDisabled ''
    Weather to use plasma DE configuration
  '';
  options.useKitty = mkOptionDisabled ''
    Weather to use kitty configuration
  '';
  options.useRust = mkOptionDisabled ''
    Wheather to use rust tooling
  '';
}
