# setup-apple-silicon-mac
A guide on how to setup your new apple silicon mac for development. This repo does not include any specific tech-stacks. Rather, it focuses on the basics of system setup that almost every setup will benefit from.

## Before you setup
- Make sure you have a stable and fast internet connection. Setting up a new machine requires lots of downloads.
- Please run one step at a time and allow it to succeed before starting next steps.

## Initial steps
- Setup your user account and log into your Apple account during initial system setup.
- Update your macOS to the latest version available first thing as a best practice
- Login to github and open the readme in this repo: `https://github.com/chaudhryjunaid/setup-apple-silicon-mac` on Safari to follow the rest of these steps.
- Generate your SSH key by following [Github's instructions](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh) and upload to [github keys page](https://github.com/settings/keys) after logging into github on Safari.
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
- Install Homebrew using following in Terminal.app:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```  
## Install apps
- Clone this repo on your apple silicon mac:
  ```
  cd ~
  git clone git@github.com:chaudhryjunaid/setup-apple-silicon-mac.git
  ```
- Open Terminal.app and execute:
  ```
  which brew
  eval $(/opt/homebrew/bin/brew shellenv); # if brew is not detected
  which brew # should be detected now; we're ready to brew now
  ```
- The scripts brew-cli.sh, brew-cask.sh, opt-brew.sh, etc, will install CLI and GUI apps for your new apple silicon mac including Chrome, Sublime Text, and others. You can omit corresponding installs by commenting out relevant lines. Please inspect and modify these scripts to ensure what you require is being installed only. You may even comment entire subscripts from install.sh if you require so.
- Execute the following commands to run specified installs:
  ```
  cd ~/setup-apple-silicon-mac
  ./install.sh
  ```
- Open Finder, goto Applications folder, then open the Utilities folder in it. There will be Terminal app in the utilities folder. Right click Terminal app in Finder and click `Get Info`. In the info tab, check `open using Rosetta` checkbox. From now on we will use iTerm as `the arm terminal` as it will execute arm binaries by default and we will use the Terminal app as `the rosetta terminal` as it will execute binaries in x86_64 mode by default. Close all original and duplicated terminal windows by selecting Quit from menu or icon right-click before re-opening for next commands.
- If you use Visual Studio Code, open Visual Studio Code on your old computer, turn Settings Sync on by going to preferences and hitting the `Turn on Settings Sync` button and following its steps to upload your visual studio code settings to github. Next, open Visual Studio Code on apple silicon mac and turn on settings sync using the same account. If prompted, select `Replace local config` option to override local settings with your old machine's vscode settings.

## Basic system setup
- Clone macos-setup repo, and run the macos-playbook.yml:
  ```
  cd ~
  git clone git@github.com:chaudhryjunaid/setup-macos.git
  cd setup-macos
  ansible-playbook macos-setup.yml --verbose
  ```
  This playbook will prompt you for your name and email and your preferred command line editor during its execution so that it may configure the system appropriately. Please keep an eye on the run for these prompts.
- For finishing (n)vim config:
  ```
  nvim +PlugInstall +qall
  nvim '+PlugClean!' +qall
  ```
- Open iTerm Preferences, open Profiles tab, then text section and check `use a different font for non-ascii text` and select the font whose name starts with `Meslo` from the font selector to enable vim and powerline features correctly. If you do not like meslo, you can head over to powerline fonts repo on github, download your favorite font, install it and then select that font from the iTerm font menu.
- Restart your terminal to activate oh-my-zsh and other goodies.

## List of included software

- Some included software may be disabled by default; you can enable installation of a disabled app by uncommenting the relevant line in the corresponding script

GUI apps:
- iterm2
- google-chrome
- firefox
- sublime-text
- sublime-merge
- visual-studio-code
- slack
- zoom

CLI apps:
- zsh
- vim
- git
- liquidprompt
- gh
- fzf
- the_silver_searcher
- binutils
- inetutils
- coreutils
- findutils
- moreutils
- htop
- cloc
- lynx
- nmap
- readline
- lua
- tmux
- screen
- ansible
- speedtest-cli
- aria2
- wget
- tree
- jq
- ack
- cmake
- cowsay
- mc
- bat
- glances
- exa
- git-delta(delta)
- tldr
- procs

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
