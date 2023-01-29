# setup-apple-silicon-mac
A guide on how to setup your new apple silicon mac for development. This repo does not include any specific tech-stacks. Rather, it focuses on the basics of system setup that almost every setup will benefit from.

## Before you setup
- Make sure you have a stable and fast internet connection. Setting up a new machine requires lots of downloads.
- Please run one step at a time and allow it to succeed before starting next steps.
- Open this repo in a browser on your earlier mac to follow the first few steps from its readme before you can open it on your new apple silicon mac.

## Initial steps
- Setup your user account and log into your Apple account during initial system setup. You may need your old mac to get the 2-factor authentication code to log into your new machine
- Update your macOS to the latest version available first thing as a best practice
- Login to github and open the readme in this repo: `https://github.com/chaudhryjunaid/setup-apple-silicon-mac` on Safari to follow the rest of these steps.
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
- If you need Xcode, please login to your apple account in AppStore and download/install Xcode. After Xcode installation completes, launch Xcode and accept the license agreement, then wait for it to install components. Then, set the command-line tools directory to point to Xcode:
  ```
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
  ```
- Install Rosetta 2 (which is the x86_64 emulation layer for M1s and will allow running legacy intel architecture programs on M1):
  ```
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
  ```
- Install Homebrew using following in arm Terminal:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```  
## Install apps
- Clone this repo on your apple silicon mac:
  ```
  cd ~
  git clone git@github.com:chaudhryjunaid/setup-apple-silicon-mac.git
  ```
- Open the arm Terminal and execute:
  ```
  which brew
  eval $(/opt/homebrew/bin/brew shellenv); # if brew is not detected
  which brew # should be detected now
  ```
  Above command should print /opt/homebrew/bin/brew if you are in the arm terminal. If not, you are not in arm terminal. Please make sure you are in the arm terminal for below commands to run brew cask and cli installs:
  ```
  cd ~/setup-apple-silicon-mac
  zsh arm-brew-cli.sh
  zsh arm-brew-cask.sh
  zsh opt-brew.sh # this is optional, please look into opt-brew.sh file to see the programs that will install
  ```
  This command will install CLI and GUI apps for your new apple silicon mac including Slack, Zoom, Chrome, Sequel Pro, PSequel, and others. Please inspect above scripts if you want to find out what exactly is being installed.
- Open Finder, goto Applications folder, then open the Utilities folder in it. There will be Terminal app in the utilities folder. Right click Terminal app in Finder and click `Get Info`. In the info tab, check `open using Rosetta` checkbox. From now on we will use iTerm as `the arm terminal` as it will execute arm binaries by default and we will use the Terminal app as `the rosetta terminal` as it will execute binaries in x86_64 mode by default. Close all original and duplicated terminal windows by selecting Quit from menu or icon right-click before re-opening for next commands.
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
- For finishing vim config, run the following in Terminal.app for this step only(`which brew` should print /usr/local/bin/brew):
  ```
  vim +PlugInstall +qall
  vim '+PlugClean!' +qall
  ```
- Open iTerm Preferences, open Profiles tab, then text section and check `use a different font for non-ascii text` and select the font whose name starts with `Meslo` from the font selector to enable vim and powerline features correctly. If you do not like meslo, you can head over to powerline fonts repo on github, download your favorite font, install it and then select that font from the iTerm font menu.
- Run the following commands to fix oh-my-zsh warnings ONLY IF you encouter warnings on iTerm / Terminal starup:
  ```
  chmod o-w /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions /usr/local/share/zsh /usr/local/share/zsh/site-functions
  chmod g-w /opt/homebrew/share/zsh /opt/homebrew/share/zsh/site-functions /usr/local/share/zsh /usr/local/share/zsh/site-functions
  ```
- Restart both iTerm and Terminal.app as needed to start using oh-my-zsh, zsh plugins and nodejs binaries.

## List of installed software
GUI apps:
- slack
- visual-studio-code
- zoom
- iterm2
- sequel-ace
- psequel
- google-chrome
- firefox
- sublime-text
- sublime-merge
- postico
- tunnelblick

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
- bat
- glances
- exa
- git-delta(delta)
- tldr
- procs
- httpie

Optional commercial apps:
- istat menus
- ngrok
- beyond compare
- goodsync
- tableplus

Optional OSS apps:
- licecap
- vlc
- caffeine
