let
  addNumbers =
    {
      x,
      y ? 0,
    }:
    x + y;
in
addNumbers { x = 2; }
