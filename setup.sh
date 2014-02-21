#!/bin/bash

function init_virtualenv() {
    VIRTUALENV=`which virtualenv-2.7`
    if [ "$VIRTUALENV" == "" ]; then
        VIRTUALENV=`which virtualenv-2.6`
    fi
    if [ "$VIRTUALENV" == "" ]; then
        VIRTUALENV=`which virtualenv`
    fi
    if [ "$VIRTUALENV" == "" ]; then
        echo "Missing virtualenv!"
        exit 1
    fi

    if [ ! -e xsqutils_env ]; then
        echo "Initializing virtualenv folder (xsqutils_env)"
        $VIRTUALENV --no-site-packages xsqutils_env
    fi

    . xsqutils_env/bin/activate

    pip install numpy
    pip install cython
    pip install numexpr
    pip install tables==2.3.1
}

function init_anaconda() {
  conda_default="$HOME/bin/conda"
  read -p "Path of conda command of the anaconda package [$conda_default]:" conda_path
  echo
  conda="${conda_path:-$conda_default}"

    if  [ ! -x "$conda" ]; then
        echo "Missing conda, you need to install anaconda first!"
        exit 1
    fi
  conda_real_path=$(readlink -f "$conda")
  #echo $conda_real_path
  ANACONDA_ROOT=${conda_real_path%/bin/conda}/envs

    if [ ! -e "$ANACONDA_ROOT/xsqutils_env" ]; then
        echo "Initializing conda virtualenv folder (xsqutils_env)"
        $conda create -n xsqutils_env pytables
    fi
    #source ${conda_real_path%/conda}/activate xsqutils_env
    cp -rf "$DIR" "$ANACONDA_ROOT/xsqutils_env/"
    xsq_dir="$ANACONDA_ROOT/xsqutils_env/${DIR##*/}"
    cd "$ANACONDA_ROOT/xsqutils_env/bin" && ln -sf ../${DIR##*/}/xsq ./
    echo  "conda environment $ANACONDA_ROOT/xsqutils_env is ready"
    echo "You should be able to run 'source activate xsqutils_env'"
    echo "And then 'which xsq' should show \"$ANACONDA_ROOT/xsqutils_env/bin/xsq\""

}
################-MAIN-#############################
echo "Please choose conda (1) or virtualenv (2) as python environment to run xsqutils."
read -p "Conda is recommended." in_choice
echo
env_choice=${in_choice:-'1'}
REAL=`python -c 'import os,sys;print os.path.realpath(sys.argv[1])' "$0"`
DIR=`dirname "$REAL"`

case "$env_choice" in
    1)
        init_anaconda
        ;;
    2)
        init_virtualenv
        ;;
    *)
        echo "Unknown option for xsqutils python environment: $env_choice"
        ;;

esac
