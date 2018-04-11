#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

ln -fs $SCRIPTPATH/gitconfig $HOME/.gitconfig 
ln -fs $SCRIPTPATH/gitignore_global $HOME/.gitignore_global
