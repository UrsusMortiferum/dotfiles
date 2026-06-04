{ shared, ... }:
{
  shared.everything.includes = [ shared.nvim ];
  shared.nvim = {
    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.neovim ];
      };
  };
}
