{ wayne, ... }:
{
  wayne.everything.includes = [ wayne.nvim ];
  wayne.nvim = {
    hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.neovim ];
      };
  };
}
