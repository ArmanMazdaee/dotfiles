#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo "Install git"
$SCRIPTPATH/git/install.sh

echo "Install zsh"
$SCRIPTPATH/zsh/install.sh

echo "Install vim"
$SCRIPTPATH/vim/install.sh
