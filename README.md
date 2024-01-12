# Hnaufu Neovim Configuration

## Getting Started

1. **Clone this Repository:**
    ```shell
    git clone https://github.com/Hanufu/nvim.git ~/.config/nvim
    cd ~/.config/nvim
    ```

2. **Install the Packer Plugin Manager:**
    ```shell
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    ```

3. **Remove VI and Add Dependencies:**
    ```shell
    sudo apt purge vim vim-common vim-runtime vim-tiny
    sudo apt update
    sudo apt-get install clangd-12 make g++ cpp ripgrep unzip cmake gcc xclip fuse
    ```

4. **Download and Update Neovim:**
    ```shell
    wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
    sudo chmod u+x nvim.appimage && sudo mv nvim.appimage /usr/bin/nvim
    ```

## Usage

After completing the steps above, you can synchronize Packer and update the installed plugins by using the following command within Neovim:

```shell
:PackerSync
