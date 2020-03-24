#!/bin/sh
# Inspired by https://github.com/adamAlnatsheh/dotfiles/blob/master/install.sh

sudo dnf update -y
sudo dnf install -y curl htop python3-pip tmux vim wget zsh

curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  > $HOME/Miniconda3-latest-Linux-x86_64.sh
sh $HOME/Miniconda3-latest-Linux-x86_64.sh
rm $HOME/Miniconda3-latest-Linux-x86_64.sh

dnf install -y neovim python3-neovim

mkdir -p $HOME/.config/nvim
ln -nfs $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
ln -nfs $HOME/dotfiles/vimrc $HOME/.vimrc

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
sudo dnf install -y ripgrep

ln -nfs $HOME/dotfiles/bash_aliases $HOME/.bash_aliases

ln -nfs $HOME/dotfiles/gitconfig $HOME/.gitconfig
