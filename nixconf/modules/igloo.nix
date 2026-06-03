{
  # host aspect
  den.aspects.igloo = {
    # host NixOS configuration
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.hello ];
      };

    provides.to-users.hjem =
      { pkgs, ... }:
      {
        packages = [ pkgs.vim ];
      };
    # host provides default home environment for its users
    # provides.to-users.homeManager =
    #   { pkgs, ... }:
    #   {
    #     home.packages = [ pkgs.vim ];
    #   };
  };
}
