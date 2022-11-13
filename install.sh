#!/bin/sh

zshrc() {

    echo "==========================================================="
    echo "             checking for starship                   "
    echo "-----------------------------------------------------------"
    if [ ! -f "$ZSH/oh-my-zsh.sh" ]; then
        echo "==========================================================="
        echo "             installing starship                   "
        echo "-----------------------------------------------------------"
        sh -c "$(curl -sS https://starship.rs/install.sh)"
    fi

    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
}

# change time zone
sudo ln -fs /usr/share/zoneinfo/Australia/Sydney /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> ~/.zshrc
echo "# remove ls and directory completion highlight color" >> ~/.zshrc
echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc
