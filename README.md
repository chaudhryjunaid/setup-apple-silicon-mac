## This repo has been archived
The info in the repo has been merged to, and is usable from the following repo:
  https://github.com/chaudhryjunaid/setup-macos

# setup-apple-silicon-mac
This repo includes scripts and a guide to setup a fresh install of macos for development (alternate steps have been added for supporting legacy intel macs also). It does not focus on any specific tech-stack. Rather, it focuses on the basics of system setup that almost every setup will benefit from. However, we install nodejs, and python nonetheless.

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
- (Optional) If you do need Xcode, please login to your apple account in AppStore and download/install Xcode. After Xcode installation completes, launch Xcode and accept the license agreement, then wait for it to install components. Then, set the command-line tools directory to point to Xcode:
  ```
  sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
  ```
- Install Homebrew using following in Terminal.app:
  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

## Install apps
- Clone this repo on your mac:
  ```
  cd ~
  git clone git@github.com:chaudhryjunaid/setup-apple-silicon-mac.git
  ```
- Open Terminal.app and execute:
  ```
  which brew
  # if brew is not detected and you are on apple silicon
  eval $(/opt/homebrew/bin/brew shellenv); 
  # if brew is not detected and you are on an intel mac
  eval $(/usr/local/bin/brew shellenv); 
  which brew # should be detected now; we're ready to brew now
  ```
- Inspect all the brew install scripts and comment out installs that you don't want as well as uncomment any installs that you want that are disabled by default. Remember `#` is the line comment character for shell scripts.
- The scripts brew-cli.sh, brew-cask.sh, opt-brew.sh, etc, will install CLI and GUI apps for your new apple silicon mac including Google Chrome and others. You can omit corresponding installs by commenting out relevant lines. Please inspect and modify these scripts to ensure what you require is being installed only. You may even comment entire subscripts from install.sh if you require so.
- Execute the following commands to run the configured installs:
  ```
  cd ~/setup-apple-silicon-mac
  ./install.sh
  ```
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
- If you don't want to use vim as the default editor in terminal which this setup repo configures as default, please edit the file ~/.zshrc.custom and at the start of the file replace vim on line 3 with nano inside double quotes and nvim on line 6 with the string next to your editor of choice below (also inside double quotes):
  - vscode: "code --wait"
  - sublime-text: "subl -w"
  - nano: "nano"
- Open iTerm Preferences, open Profiles tab, then text section and select the nerd font installed during setup font whose name starts with `Meslo` from the font selector to enable vim/neovim and powerline features correctly. If you do not like meslo, you can install another nerd font from brew and select that instead. You may execute `brew search font` or `brew search nerd` for this.
- Restart your terminal to activate oh-my-zsh and other goodies.

## List of included software
- Please look at the shell script files to find out what software is installed by default and what additional software is available by uncommenting lines in these scripts.
