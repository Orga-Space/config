SETUP_NAME=
SETUP_EMAIL=
DEFAULT_SHELL_CONFIG="${HOME}/.bashrc"

### install software ###
sudo apt update
sudo apt upgrade -y
sudo apt install htop neofetch tmux git wget curl -y

### configure local git ###
git config --global user.name "$SETUP_NAME"
git config --global user.email "$SETUP_EMAIL"

### prepare connection to github ###
SSH_DIR="${HOME}/.ssh"
GITHUB_PRIVATE_KEY="${SSH_DIR}/github-id_ed25519"
if [ ! -d "$SSH_DIR" ]; then
        mkdir "$SSH_DIR"
fi

if [ ! -f "$GITHUB_PRIVATE_KEY" ]; then
        ssh-keygen -t ed25519 -C "$SETUP_EMAIL" -f "$GITHUB_PRIVATE_KEY" -N ""
echo "
Host github.com
    IdentityFile $GITHUB_PRIVATE_KEY
" >> "${HOME}/.ssh/config"

fi

# todo all the file creation will be done with sudo, all the file will be owned by root, need to change the owner
# all the command need to be executed from the user
# https://askubuntu.com/questions/1033868/how-do-i-find-which-user-executes-the-script-when-is-used-sudo

### folder structure ###
if [ ! -d "${HOME}/sandbox" ]; then
        mkdir "${HOME}/sandbox"
fi

if [ ! -d "${HOME}/sandbox/config" ]; then
        git clone https://github.com/Orga-Space/config.git "${HOME}/sandbox/config"
fi

if [ ! -f "${HOME}/.aliases" ]; then
        cp "${HOME}/sandbox/config/.aliases" "$HOME/.aliases"
echo "
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi
" >> "$DEFAULT_SHELL_CONFIG"
fi

if [ ! -f "${HOME}/.tmux.conf" ]; then
        cp "${HOME}/sandbox/config/.tmux.conf" "$HOME/.tmux.conf"
fi

if [ ! -f "${HOME}/.vimrc" ]; then
        cp "${HOME}/sandbox/config/.vimrc" "$HOME/.vimrc"
fi

#####  post run  #####

### ssh key added to ssh agent ###
echo ""
echo "### copy pub key for github ###"
echo "https://github.com/settings/keys"
echo ""
cat "${GITHUB_PRIVATE_KEY}.pub"
echo ""
