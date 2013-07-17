#!/bin/bash

prompt_yn() {
    read -p "$1 [Yn] " answer
    if [ "${answer}" == n -o "${answer}" == N ]; then
        return 1
    fi

    return 0
}

REPODIR="${PWD}"
INSTALL=(muttrc lbdbrc)
postsync=postsync-offlineimap.sh

for target in ${INSTALL[@]}; do
    if [ -e "${HOME}/.${target}" ]; then
        echo ".${target} exists in ${HOME}. Symlink yourself."
    else
        ln -s "${REPODIR}/${target}" "${HOME}/.${target}"
    fi
done

notmuch=$(/bin/which notmuch)
if [ $? -eq 0 ]; then
    if [ ! -e "${HOME}/.notmuch-config" ];
        prompt_yn "Set up notmuch?" && notmuch config
    fi
fi

offlineimap=$(/bin/which offlineimap)
if [ $? -eq 0 ]; then
    installed_hook=$(grep '^ *postsynchook *=' "${HOME}/.offlineimaprc" |
                     cut -d= -f2 | tr -d ' ')

    if [ -n "${installed_hook}" ]; then
        diff -q "${installed_hook}" "${postsynchook}" && exit 0
    fi
    prompt_yn "Install postsync script for offlineimap?" || exit 0

    installed=$(/bin/which ${postsync})

    if [ $? -eq 0 ]; then
        echo "${postsync} installed at ${installed}"
    else
        installed="${HOME}/bin/${postsync}"
        test -d "${HOME}/bin" || mkdir "${HOME}/bin"
        ln -s "${REPODIR}/${postsync}" "${installed}"
    fi

    if [ -e "${HOME}/.offlineimaprc" ]; then
        echo "Add this line to your account in ~/.offlineimaprc:"
        echo "postsynchook = ${installed}"
    fi
fi
