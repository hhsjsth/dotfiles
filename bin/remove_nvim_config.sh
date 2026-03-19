#!/bin/bash

echo "Removing nvim config"
# rm -rf ~/.config/nvim
cd ~/.config/nvim && \
find . -mindepth 1 \
  ! -path './init.vim' \
  -exec rm -rf {} +
rm -rf ~/.cache/nvim                                                                                          
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
echo "Removing AstroNvim config"
rm -rf ~/.config/AstroNvim
rm -rf ~/.cache/AstroNvim                                                                                          
rm -rf ~/.local/state/AstroNvim
rm -rf ~/.local/share/AstroNvim
echo "Removing LazyVim config"
rm -rf ~/.config/LazyVim
rm -rf ~/.cache/LazyVim
rm -rf ~/.local/state/LazyVim
rm -rf ~/.local/share/LazyVim

# bash ~/.local/share/lunarvim/lvim/utils/installer/uninstall.sh

## 有一个 LazyVim [🛠️ Installation | LazyVim](https://www.lazyvim.org/installation)
## 还有一个 lazy.nvim [🛠️ Installation | lazy.nvim](https://lazy.folke.io/installation)
## LazyNvim 安装方式和其他不一样, 需要编辑 ~/.config/LazyNvim/init.lua
## 因此不能直接 rm -rf ~/.config/LazyNvim
## 而是删除 ~/.config/LazyNvim/init.lua 和 ~/.config/LazyNvim/lua/config/lazy.lua
## 后来看了 LazyVim 的页面, 才发现是完全基于 LazyNvim 的, 所以不需要自己搞 LazyNvim
#cd ~/.config/LazyNvim && \
#find . -mindepth 1 \
#  ! -path './init.lua' \
#  ! -path './lua' \
#  ! -path './lua/config' \
#  ! -path './lua/config/lazy.lua' \
#  ! -path './lua/plugins' \
#  -exec rm -rf {} +
#rm -rf ~/.cache/LazyNvim
#rm -rf ~/.local/state/LazyNvim
#rm -rf ~/.local/share/LazyNvim

echo "Removing kickstart config"
rm -rf ~/.config/kickstart
rm -rf ~/.cache/kickstart
rm -rf ~/.local/state/kickstart
rm -rf ~/.local/share/kickstart
echo "Removing NvChad config"
rm -rf ~/.config/NvChad
rm -rf ~/.cache/NvChad
rm -rf ~/.local/state/NvChad
rm -rf ~/.local/share/NvChad
echo "Remove completed!"
