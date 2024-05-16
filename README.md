<div align="center">

# dotfiles

### Terminal Of Choice - WezTerm

#### Why WezTerm?

- cross-platform support
- simple, well documented configuration using lua

#### Few words about configuration

My main platform is MacOs, hence everything putted here is focused on it.
As I also use Windows (WSL), I wanted to also make my config there, and that's
why some of the configurations are related only to a single system.

While I'll skip for now how it was actually configured (mainly due to already
available tutorials and docs), I want to leave a small tip from my side.

Configuration is being stored in **%USERPROFILE%/.config/wezterm/** directory,
instead of default recommended **%USERPROFILE%/.wezterm.lua**. The reason
behind it is really simple, as I want to keep config as cohesive across
platforms as possible.
