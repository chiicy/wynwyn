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

## Features
This theme currently supports the following features:

### Git status
Shows:
* Branch name
* Icon to show if branch has diverged from it's origin
* Indicators for different git changes (new file added, existing file changed, stashed files etc)
* Last commit time

### Docker container list
If you're in a directory that contains a `Dockerfile` or `docker-compose.yml` you will see the docker indicator.
This will display the names of any currently running containers or if there are more than 4 active it will show the number currently running. 

### Node projects
If you're in a directory that contains a `node_modules` directory it will show the current version of node being used.

### Python projects
When you activate a pythong virtual environment it will show the environment name.

### Operating system icon
Displays an icon specific to the operating system you're currently using.
For example if I ssh into my home PC from my work macbook, my prompt would look like:

Currently supports:
* macOS
* Ubuntu
* Rasbian

### Root user warning
If you're logged in as the root user, your prompt will keep you reminded.

## Customising
The colours used by this theme have been set to local variables so they can be used in multiple places.
If you want to replace any colours with ones you prefer, you can set your own values in the colour scheme section at the top of the file.

To find the colour codes required you can run the command `spectrum_ls` in your zsh shell which will print out the colour colour codes with text to demonstrate them.

