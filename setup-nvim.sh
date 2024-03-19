## Required (remove and backup your old nvim config)
mv ~/.config/nvim{,.bak}

# Optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

## clone the latest LazyVim config from the starter repo
git clone https://github.com/LazyVim/starter ~/.config/nvim

## (Optional) remove the original .git folder if you want to customize the config
#rm -rf ~/.config/nvim/.git

## Refer to the comments in the lua config files on how to customize LazyVim.
## It is recommended to run :LazyHealth after installation.
## This will load all plugins and check if everything is working correctly.

## KEYMAP DOCS: https://www.lazyvim.org/keymaps
## DOCS SITE: https://www.lazyvim.org/
