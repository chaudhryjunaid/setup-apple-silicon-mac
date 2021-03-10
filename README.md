# setup-apple-silicon-mac
A guide on how to setup your new apple silicon mac for development. This repo does not include any specific tech-stacks. Rather, it focuses on the basics of system setup that almost every setup will benefit from.

## Before you setup
- Make sure you have a stable and fast internet connection. Setting up a new machine requires lots of downloads.
- Please run one step at a time and allow it to succeed before starting next steps.
- Open this repo in a browser on your earlier mac to follow the first few steps from its readme before you can open it on your new apple silicon mac.

## Initial steps
- Setup your user account and log into your Apple account during initial system setup. You may need your old mac to get the 2-factor authentication code to log into your new machine
- A) If airdrop is working for you and you want to use your existing ssh key, AirDrop your existing SSH keys (either id_rsa and id_rsa.pub OR id_ed25519 and id_ed25519.pub) to your apple silicon mac and put them in ~/.ssh folder
  ```
  mkdir ~/.ssh
  cp ~/Downloads/id_rsa* ~/.ssh
  OR
  cp ~/Downloads/id_ed25519* ~/.ssh
  ```

- OR B) Generate a new pair by following [Github's instructions](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) and upload to [github keys page](https://github.com/settings/keys) after logging into github on Safari.

- Install XCode command line tools
  ```
  xcode-select --install
  ```
- If you need Xcode, please login to your apple account in AppStore and download/install Xcode. Then, set the command-line tools directory to point to Xcode:
  ```
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
  ```
- Install Rosetta 2 (which is the x86_64 emulation layer for M1s and will allow running legacy intel architecture programs on M1):
  ```
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
  ```
- Open Finder, goto Applications folder, then open the Utilities folder in it. There will be Terminal app in the utilities folder. Right click Terminal app in Finder, select `Duplicate` and then right click the duplicated terminal in Finder and click `Get Info`. In the info tab, check `open using Rosetta` checkbox and in the name section rename app to `TerminalRosetta.app`. From now on we will call the Terminal launched from the original Terminal app `the arm terminal` as it will execute arm binaries by default and we will call the Terminal launched from TerminalRosetta.app as `the rosetta terminal` as it will execute binaries in x86_64 mode by default.
- Some commands will need to be run in the arm terminal and some in the rosetta terminal. Please make sure you are in the right terminal before executing commands to avoid messing up your setup. The following command which print `arm64` in arm terminal and `i386` or `x86_64` in the rosetta terminal:
  ```
  arch
  ```
  Always execute this command before each of the following steps to make sure you are in the right execution environment.
- Install Homebrew using following in arm Terminal:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- Now install homebrew using Rosetta 2 as well using TerminalRosetta.app:
  ```
  arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```
- Setup to use appropriate brew based on arch value and use bin folder of preferred arch first followed by the bin folder of the other arch by adding the following to your .zshrc. If .zshrc does not exist, you may create it by using `touch ~/.zshrc`. Then please open in vim or nano using `vim ~/.zshrc` and paste the following in the end.
  ```
  if [ "$(arch)" = "arm64" ]; then
    eval $(/opt/homebrew/bin/brew shellenv);
    export PATH="$PATH:/usr/local/bin:/usr/local/sbin";
  else
    eval $(/usr/local/bin/brew shellenv);
    export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin";
  fi
  ```
- Please restart all Terminal and TerminalRosetta windows for updated .zshrc to take effect.
  
## Install apps
- Login to github and open the readme in this repo: `https://github.com/chaudhryjunaid/setup-apple-silicon-mac` to follow the rest of these steps. Also, clone this repo on your apple silicon mac for later usage:
  ```
  cd ~
  git clone git@github.com:chaudhryjunaid/setup-apple-silicon-mac.git
  ```
- Open the arm Terminal and execute:
  ```
  which brew
  ```
  Above command should print /opt/homebrew/bin/brew if you are in the arm terminal. If not, you are not in arm terminal. Please make sure you are in the arm terminal for below commands to run brew cask and cli installs:
  ```
  cd ~/setup-apple-silicon-mac
  zsh arm-brew-cli.sh
  zsh arm-brew-cask.sh
  ```
  This command will install CLI and GUI apps for your new apple silicon mac including Slack, Zoom, Chrome, Sequel Pro, PSequel, and others. Please inspect above scripts if you want to find out what exactly is being installed.
- Just like we did for Terminal using Finder, go to the Applications folder in Finder and duplicate iTerm, set the duplicated iTerm to run using Rosetta and rename it to `iTermRosetta.app`
- If you use Visual Studio Code, open Visual Studio Code on your old computer, turn Settings Sync on by going to preferences and hitting the `Turn on Settings Sync` button and following its steps to upload your visual studio code settings to github. Next, open Visual Studio Code on apple silicon mac and turn on settings sync using the same account. If prompted, select `Replace local config` option to override local settings with your old machine's vscode settings.

## Basic system setup
- Open arm iTerm for below steps unless otherwise specified.
- Clone macos-setup repo, and run the macos-playbook.yml:
  ```
  cd ~
  git clone git@github.com:chaudhryjunaid/setup-macos.git
  cd setup-macos
  ansible-playbook macos-setup.yml --verbose
  ```
  This playbook will prompt you for your name and email and your preferred command line editor during its execution so that it may configure the system appropriately. Please keep an eye on the run for these prompts.
- For finishing vim config, run the following in iTermRosetta.app for this step only(`which brew` should print /usr/local/bin/brew):
  ```
  vim +PlugInstall +qall
  vim '+PlugClean!' +qall
  ```
- Open iTerm Preferences, open Profiles tab, then text section and check `use a different font for non-ascii text` and select the font whose name starts with `Meslo` from the font selector to enable vim and powerline features correctly. If you do not like meslo, you can head over to powerline fonts repo on github, download your favorite font, install it and then select that font from the iTerm font menu.
- Run the following commands to fix oh-my-zsh warnings:
  ```
  chmod o-w /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions /usr/local/share/zsh /usr/local/share/zsh/site-functions
  chmod g-w /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions /usr/local/share/zsh /usr/local/share/zsh/site-functions
  ```
- Restart both arm and rosetta iTerms to start using oh-my-zsh, zsh plugins and nodejs binaries.

## List of installed software
GUI apps:
- slack
- visual-studio-code
- zoom
- iterm2
- sequel-pro
- psequel
- google-chrome
- firefox

Homebrew/command-line apps:
- vim
- zsh
- liquidprompt
- the_silver_searcher
- aria2
- wget
- tree
- jq
- ack
- cmake
- cowsay
- tmux
- lynx
- nmap
- binutils
- inetutils
- htop
- cloc
- coreutils
- findutils
- readline
- lua
- moreutils
- mc
- screen
- gh
- elinks
- git
- fzf
- awscli
- ansible
- speedtest-cli
