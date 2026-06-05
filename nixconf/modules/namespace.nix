{ inputs, den, ... }:
{
  imports = [
    (inputs.den.namespace "batcave" false) # terminal
    (inputs.den.namespace "gotham" false) # shared
    (inputs.den.namespace "batcomputer" false) # media, server
    (inputs.den.namespace "manor" false) # other
  ];
  _module.args.__findFile = den.lib.__findFile;
}
