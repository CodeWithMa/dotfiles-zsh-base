Plugins are loaded from `plugins/` in alphabetical directory order.
`zsh-syntax-highlighting` must be loaded last — ensure its directory name
sorts after all other plugins.

``` shell
git clone https://codeberg.org/CodeWithMa/dotfiles-zsh-base.git ~/.config/zsh
git -C ~/.config/zsh submodule update --init --recursive
cp ~/.config/zsh/.zshrc ~/
```
