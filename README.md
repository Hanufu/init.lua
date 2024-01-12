# Hnaufu init.lua

## Prerequisites

Before using this configuration, make sure you have [ripgrep](https://github.com/BurntSushi/ripgrep) installed.

## Getting Started

1. Clone this repository into your Neovim configuration directory:

    ```shell
    git clone https://github.com/Hanufu/nvim.git ~/.config/nvim
    cd ~/.config/nvim
    ```

2. Install the Packer plugin manager by cloning its repository:

    ```shell
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    ```

3. Remove VI and add dependencies:

    ```shell
    sudo apt purge vim vim-common vim-runtime vim-tiny
    sudo apt update
    sudo apt-get install clangd-12 make g++ cpp ripgrep unzip cmake gcc xclip
    ```

4. Download and update Neovim:

    ```shell
    wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
    chmod u+x nvim.appimage && ./nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
    ```

## Usage

After completing the steps above, you can synchronize Packer and update the installed plugins by using the following command within Neovim:

```shell
:PackerSync
