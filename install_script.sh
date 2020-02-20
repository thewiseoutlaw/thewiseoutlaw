#!/bin/bash
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\e[0m'
RED='\e[31m'
GREEN='\e[32m'
ORANGE='\e[33m'
BLUE='\e[34m'
PURPLE='\e[35m'
CYAN='\e[36m'
LIGHTGRAY='\e[37m'
DARKGRAY='\e[30m'
LIGHTRED='\e[31m'
LIGHTGREEN='\e[32m'
YELLOW='\e[33m'
LIGHTBLUE='\e[34m'
LIGHTPURPLE='\e[35m'
LIGHTCYAN='\e[36m'
WHITE='\e[37m'

if (( $EUID == 0 )); then
  echo -e "${ORANGE}Don't run as root, I'll ask for sudo password as it comes up${NOCOLOR}"
  exit 1 
fi

echo -e "${GREEN}Snap install neovim${NOCOLOR}"
sudo snap install neovim --classic

echo -e "${GREEN}Install zsh and zim${NOCOLOR}"
sudo snap install zsh
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

echo -e "${GREEN}Adding node 13.x ppa${NOCOLOR}"
sudo snap install node --edge --classic

echo -e "${GREEN}Changing default shell to zsh${NOCOLOR}"
chsh -s /bin/zsh

echo -e "${GREEN}Installing neovim with deps${NOCOLOR}"
#sudo apt-get install -y neovim
#sudo apt-get install -y python3-dev python3-pip
sudo pip3 install pynvim
sudo npm install -g neovim
#sudo apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
#needed for ruby neovim
echo -e "${GREEN}Installing ruby${NOCOLOR}"
sudo snap install ruby --classic
#sudo apt-get install -y ruby ruby-dev ruby-full
sudo gem install neovim
#needed for clipboard support
#sudo apt-get install -y xclip xsel
#needed for coc bash support
sudo npm i -g bash-language-server
#needed for dockerfile coc support
sudo npm i -g dockerfile-language-server-nodejs
#for python coc autocompletion
sudo pip3 install 'python-language-server[all]'

echo -e "${GREEN}Making nvim backup dir incase it doesn't exit${NOCOLOR}"
mkdir -p ~/.local/share/nvim/backup

echo -e "${GREEN}going to backup old dot files${NOCOLOR}"
mv ~/.zimrc ~/.zimrc.bak.`ls ~/.zimrc* | wc -l`
mv ~/.zshrc ~/.zshrc.bak.`ls ~/.zshrc* | wc -l`
mv ~/.tmux.conf ~/.tmux.conf.bak.`ls ~/.tmux.conf* | wc -l`
mv ~/.config/nvim ~/config/nvim.bak.`ls ~/.config/nvim* | wc -l`
mv ~/.config/Pecan ~/config/Pecan.bak.`ls ~/.config/Pecan* | wc -l`
echo -e "${GREEN}Copy files${NOCOLOR}"
cp `pwd`/.zimrc ~/.zimrc
cp `pwd`/.zshrc ~/.zshrc
cp `pwd`/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config
cp -r `pwd`/config/nvim ~/.config/nvim
cp -r `pwd`/config/Pecan ~/.config/Pecan


echo -e "${GREEN}Installing bat to replace cat${NOCOLOR}"
sudo snap install bat --classic

echo -e "${GREEN}Install latest go via snap${NOCOLOR}"
sudo snap install --classic go

#get nerd fonts you want from
#git clone git@github.com:ryanoasis/nerd-fonts.git
#cd nerd-fonts && ./install.sh

#download the jetbrains font
echo -e "${GREEN}Downloading jetbrains font from nerd fonts${NOCOLOR}"
curl https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf --output JetBrainsNerdFont.ttf
mkdir ~/.fonts
mv JetBrainsNerdFont.ttf ~/.fonts
sudo apt-get install -y fontconfig
fc-cache -f -v
#install ccyrpt
echo -e "${GREEN}Install ccrypt to encrypt files${NOCOLOR}"
#sudo apt-get install -y ccrypt
# encrypt with ccrypt file
# decrypt with ccdecrypt file
go get -u github.com/sourcegraph/go-langserver
sudo chown -R $USER:$USER ~/
echo -e "${GREEN}switch to zsh, type zimfw install to install modules${NOCOLOR}"
echo -e "${GREEN}NOTE: when starting nvim!${NOCOLOR}"
echo -e "${GREEN}run :PlugInstall${NOCOLOR}"
echo -e "${GREEN}run :CocInstall coc-python${NOCOLOR}"
echo -e "${GREEN}run :CocInstall coc-java${NOCOLOR}"
echo -e "${GREEN}run :CocInstall coc-go${NOCOLOR}"
echo -e "${ORANGE} .zshrc changed vim to use nvim, cat to use bat${NOCOLOR}"
