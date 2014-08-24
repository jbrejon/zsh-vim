mkdir ~/backup_zshv

mv ~/.vim* ~/backup_zshv
mv ~/.zshrc ~/backup_zshv
mv ~/.dircolors ~/backup_zshv
mv ~/.indent.pro ~/backup_zshv
mv ~/.oh-my-zsh ~/backup_zshv

cp -r .oh-my-zsh ~/
cp .zshrc ~/
cp -r .vim* ~/
cp .dircolors ~/
cp .indent.pro ~/

./gnome-terminal-colors-solarized/set_alternative_dark.sh
chsh -s $(which zsh)

echo "done"
