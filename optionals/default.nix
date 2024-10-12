{lib, ...}:
let
  configFile = { path = ../options.toml; type = "TOML"; };
  setAndTrue = self: name: self ? ${name} && self.${name};
  applyIfTrue = self: name: attrs: if self ? ${name} && self.${name} then attrs else {};
  myOptions = import ../autoOptions.nix configFile
    // {__functor = applyIfTrue; inherit setAndTrue applyIfTrue;};
  readDirToListRec = path: lib.attrsets.mapAttrsToList (name: value: 
      if value == "directory"
      then readDirToListRec (path + ("/" + name))
      else path + ("/" + name)
    ) (builtins.readDir path);
  importList = builtins.map (path: import (path) myOptions) (lib.lists.flatten (readDirToListRec ./optionals));
in importList
