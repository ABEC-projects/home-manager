{lib, ...}:
let
  configFile = { path = ../options.toml; type = "TOML"; };
  myOptions = import ../autoOptions.nix configFile;
  readDirToListRec = path: lib.attrsets.mapAttrsToList (name: value: 
      if value == "directory" 
      then readDirToListRec (path + ("/" + name))
      else path + ("/" + name)
    ) (builtins.readDir path);
  importList = builtins.map (path: import (path) myOptions) (lib.lists.flatten (readDirToListRec ./optionals));
in importList
