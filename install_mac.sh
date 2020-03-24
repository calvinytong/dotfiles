#!/bin/sh

brew install curl htop python3 python3-pip tmux vim wget fish


brew install neovim
pip3 install neovim
pip3 install --upgrade neovim

mkdir -p $HOME/.config/nvim
ln -nfs $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
ln -nfs $HOME/dotfiles/vimrc $HOME/.vimrc

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

brew install fzf
$(brew --prefix)/opt/fzf/install

brew install ripgrep

ln -nfs $HOME/dotfiles/bash_aliases $HOME/.bash_aliases

ln -nfs $HOME/dotfiles/gitconfig $HOME/.gitconfig

# Needed for Deoplete
pip3 install --user pynvim
