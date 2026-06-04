{ inputs, den, ... }:
{
  imports = [ (inputs.den.namespace "shared" true) ];
  _module.args.__findFile = den.lib.__findFile;
}
