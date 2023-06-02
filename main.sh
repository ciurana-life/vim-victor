#!/bin/bash

# Create ~/.vimrc and its contents or update with the .vimrc on this repo
vimrc_file="$HOME/.vimrc"
myfile="./.vimrc"

if [ ! -e "$vimrc_file" ]; then
    echo "Creating $vimrc_file..."
    touch "$vimrc_file"
    echo "Created $vimrc_file."
else
    echo "$vimrc_file already exists."
fi

echo "Adding contents of $myfile to $vimrc_file..."
cat "$myfile" > "$vimrc_file"
echo "Contents of $myfile appended to $vimrc_file."

# Add Vundle if it does not exist
vundle_dir="$HOME/.vim/bundle/Vundle.vim"

if [ -d "$vundle_dir" ]; then
    echo "Vundle.vim plugin directory exists, ignoring step."
else
    echo "Installing Vundle.vim"
    git clone https://github.com/gmarik/Vundle.vim.git "$vundle_dir"
fi

# Add YouCompleteMe if it does not exist
ycm_dir="$HOME/.vim/bundle/YouCompleteMe"

if [ -d "$ycm_dir" ]; then
    echo "YouCompleteMe plugin directory exists, ignoring step."
else
    echo "Installing YouCompleteMe"
    git clone https://github.com/Valloric/YouCompleteMe.git "$ycm_dir"
    git -C "$ycm_dir" submodule update --init --recursive 
    python3 "$ycm_dir/install.py" --clangd-completer
fi

# Add vim-flake 8 if it does not exist
flake8_dir="$HOME/.vim/pack/flake8/start/"

if [ -d "$flake8_dir" ]; then
    echo "Flake 8 installed, ignoring step."
else
    echo "Installing vim-flake8"
    mkdir -p "$flake8_dir"
    git clone https://github.com/nvie/vim-flake8.git "$flake8_dir"
fi

vim +PluginInstall +qall

# Install color theme
theme_dir="$HOME/.vim/colors"

if [ -d "$theme_dir" ]; then
    echo "Theme installed, ignoring step."
else
    echo "Installing color theme"
    mkdir -p "$HOME/.vim/colors"
    curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim --output "$theme_dir/molokai.vim"
fi

echo "DONE"
