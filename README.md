# Personal neovim basic configuration

Heavily inspired by [ThePrimeagen](https://www.youtube.com/watch?v=w7i4amO_zaE) video. It was my starting point of serious dive into Vim.

## Predisposition

Install Packer

```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Install 

Clone this repository into `~/.config/nvim` folder.

Go to `~/.config/nvim/lua/krizos` and open `packer.lua` file. Source this file with `:so`.
Then close and re-open vim and run command `:PackerSync` and you should be done.

