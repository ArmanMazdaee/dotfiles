#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source $SCRIPTPATH/zshenv

mkdir --parents $ZDOTDIR
ln -fs $SCRIPTPATH/zshenv $HOME/.zshenv
ln -fs $SCRIPTPATH/zshrc $ZDOTDIR/.zshrc
