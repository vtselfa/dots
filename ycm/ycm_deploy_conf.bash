#!/usr/bin/env bash

for vob in ci rx top srftools com; do
    echo "Autocompletion for $vob"
    ln -s -f $HOME/dots/ycm/${vob}.ycm_extra_conf.py $WORKAREA/${vob}/.ycm_extra_conf.py
done
