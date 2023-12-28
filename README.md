# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).

## Installation

### Windows

```bash
# Make a backup of your current Neovim files:

# required
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

# optional but recommended
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak

# Clone the starter:
git clone git@github.com:zeekcheung/LazyVim_config.git $env:LOCALAPPDATA\nvim
```

### Linux/MacOS

```bash
# Make a backup of your current Neovim files:

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

# Clone the starter:
git clone git@github.com:zeekcheung/LazyVim_config.git ~/.config/nvim
```
