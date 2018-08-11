# Oh-My-ZSH Custom Theme
A theme for oh-my-zsh which borrows (reads, just straight up copies) a number of things from the default 'avit' theme which comes bundled by default and a few things from Spaceship prompt (https://github.com/denysdovhan/spaceship-prompt).

## Requirements
1. You will need a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) installed for the icons used in the theme to display properly.
Follow the instructions in the Nerd Font projet to install a patched fon't for your terminal.

2. Download the the dev icons associations file from the Nerd Font repo (`bin/scripts/lib/i_dev.sh`), and save it in your local font config directory (`~/.local/share/fonts`).

3. Source the dev icons file in your `.zshrc`.

## Enabling
1. Clone this repository.

2. Create a symlink to the tristan.zsh-theme file in `~/.oh-my-zsh/custom/themes/` directory. 
```zsh
ln -s $PWD/tristan.zsh-theme ~/.oh-my-zsh/custom/themes/tristan.zsh-theme
```
(assuming you are in the directory, so `$PWD` will expand correctly)

3. In your `.zshrc` file, set `ZSH_THEME="tristan"`

## Customising
The colours used by this theme have been set to local variables so they can be used in multiple places.
If you want to replace any colours with ones you prefer, you can set your own values in the colour scheme section at the top of the file.

To find the colour codes required you can run the command `spectrum_ls` in your zsh shell which will print out the colour colour codes with text to demonstrate them.

