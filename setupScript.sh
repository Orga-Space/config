SETUP_NAME=
SETUP_EMAIL=

### install software ###
sudo apt update
sudo apt install htop tmux git wget curl -y

### configure local git ###
git config --global user.name "$SETUP_NAME"
git config --global user.email "$SETUP_EMAIL"

### prepare connection to github ###
GITHUB_PRIVATE_KEY="${HOME}/.ssh/github-id_ed25519"
if [ ! -f $GITHUB_PRIVATE_KEY ]; then
        ssh-keygen -t ed25519 -C "$SETUP_EMAIL" -f "${GITHUB_PRIVATE_KEY}" -N ""
        ssh-add $GITHUB_PRIVATE_KEY
echo "
Host github.com
    IdentityFile $GITHUB_PRIVATE_KEY
" >> $HOME/.ssh/config

fi


#####  post run  #####

### ssh key added to ssh agent ###
echo ""
echo "### check for ssh key here ###"
echo ""
ssh-add -L
echo ""
