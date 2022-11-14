#!/bin/sh

zshrc() {
    echo "==========================================================="
    echo "             checking for fonts                   "
    echo "-----------------------------------------------------------"
    if [ ! -f "$HOME/.local/share/fonts/Hack-Regular.ttf" ]; then
        echo "==========================================================="
        echo "             installing Hack fonts                   "
        echo "-----------------------------------------------------------"
        sudo apt install unzip fontconfig -y
        sudo wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
        sudo unzip Hack-v3.003-ttf.zip -d hack-font
        sudo cp -r ./hack-font/ttf/ $HOME/.local/share/fonts/
        sudo fc-cache -vf
    fi

    echo "==========================================================="
    echo "             checking for starship                   "
    echo "-----------------------------------------------------------"
    if [ ! -f "$HOME/.config/starship.toml" ]; then
        echo "==========================================================="
        echo "             installing starship                   "
        echo "-----------------------------------------------------------"
        sh -c "$(curl -sS https://starship.rs/install.sh)"
        mkdir -p $HOME/.config && touch $HOME/.config/starship.toml
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

# # make directly highlighting readable - needs to be after zshrc line
# echo "" >> ~/.zshrc
# echo "# remove ls and directory completion highlight color" >> ~/.zshrc
# echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
# echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
# echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc
