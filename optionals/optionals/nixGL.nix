myConfig:
{ ... }:
let
nixgl = import <nixgl>{};
package-path = nixgl.auto.nixGLDefault or "";
exec = if package-path != "" then "${package-path}/bin/nixGL" else "";
in {
  nixGLPrefix = exec;
}
