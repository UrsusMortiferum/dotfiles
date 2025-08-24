{ ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "tokyo-night";
      truecolor = true;
      rounded_corners = false;
      update_ms = 2000;
      proc_tree = true;
    };
  };
}
