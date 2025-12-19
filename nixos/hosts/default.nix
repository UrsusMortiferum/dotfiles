{ hostName, ... }:
{
  imports = [ ./${hostName}/configuration.nix ];
}
