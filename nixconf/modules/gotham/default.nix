{
  den,
  # gotham,
  ...
}:
{
  den.aspects.nixos = {
    provides.to-users = {
      includes = with den.aspects; [ base ];
    };
  };
  #
  # gotham.includes = with den.aspects; [ base ];
}
