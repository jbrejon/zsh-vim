mkdir ~/backup_zshv

mv ~/.vim* ~/backup_zshv
mv ~/.zshrc ~/backup_zshv
mv ~/.dircolors ~/backup_zshv
mv ~/.indent.pro ~/backup_zshv
mv ~/.oh-my-zsh ~/backup_zshv
echo "mv"

cp -r .oh-my-zsh ~/
cp .zshrc ~/
cp -r .vim* ~/
cp .dircolors ~/
cp .indent.pro ~/
echo "cp"

./gnome-terminal-colors-solarized/set_alternative_dark.sh
echo "bg set"
chsh -s $(which zsh)
echo "zsh set"

echo "done"
