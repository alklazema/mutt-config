#!/bin/bash

REPODIR="${PWD}"
INSTALL=(muttrc mutt lbdb)

for target in ${INSTALL[@]}; do
    if [ -e "${HOME}/.${target}" ]; then
        echo ".${target} exists in ${HOME}. Symlink yourself."
    else
        ln -s "${REPODIR}/${target}" "${HOME}/.${target}"
    fi
done
