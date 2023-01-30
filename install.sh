#!/bin/bash

echo "Installing selected applications..."

bash brew-cli.sh
bash brew-cask.sh
bash brew-pg.sh
bash brew-python.sh
bash fonts-brew.sh
bash opt-brew.sh

echo "All Done!"
