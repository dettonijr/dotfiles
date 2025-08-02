#!/bin/bash

set -e

npm --version

brew install neovim
brew install cmake
brew install lazygit

ln -s $HOME/dotfiles/.profile $HOME || true 
ln -s $HOME/dotfiles/.wezterm.lua $HOME || true
ln -s $HOME/dotfiles/.gitconfig $HOME || true

mkdir -p $HOME/.config
ln -s $HOME/dotfiles/.config/nvim $HOME/.config || true
