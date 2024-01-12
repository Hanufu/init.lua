# Hnaufu init.lua

Prerequisite: install [ripgrep](https://github.com/BurntSushi/ripgrep).

After cloning this repository, clone the Packer plugin manager, so you can use ":PackerSync" and get updates for the installed plugins.

Removing VI and Adding dependences
```shell
sudo apt purge vim vim-common vim-runtime vim-tiny && sudo apt-get install clangd-12 make g++ cpp ripgrep unzip cmake gcc xclip
```
Donwload Nvim updated
```shell
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
```
make it executable
```shell
chmod u+x nvim.appimage && ./nvim.appimage
```
Move to /usr/bin/nvim
```shell
sudo mv nvim.appimage /usr/bin/nvim
```
```shell
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
