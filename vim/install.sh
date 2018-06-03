#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
VIMDIR=$HOME/.vim

mkdir --parents $VIMDIR
ln -fs $SCRIPTPATH/vimrc $VIMDIR/vimrc 
