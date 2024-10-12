configFile:
let
  optionsFromToml = path: fromTOML (builtins.readFile path);
  optionsFromJson = path: builtins.fromJSON (builtins.readFile path);
in
if configFile ? path && configFile ? type then
  (if configFile.type == "TOML" then
    optionsFromToml configFile.path
  else
    builtins.seq
      (if configFile.type == "JSON" then "ok" else throw "configFile.path should be either `JSON` or `TOML`" )
      optionsFromJson configFile.path)
  else throw "`path` and `type` in configFile option should be set!"
