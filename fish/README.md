# MacOS -> default shell setup

```sh
brew install fish
```

```sh
fish
```

```sh
fish_add_path /opt/homebrew/bin
```

```sh
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
```

```sh
chsh -s /opt/homebrew/bin/fish
```
