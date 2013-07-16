#!/bin/bash

# Update notmuch if installed
notmuch=$(/bin/which notmuch)
if [ $? -eq 0 ]; then
    notmuch new
fi

# Update lbdb if installed
lbdb=$(/bin/which lbdb-fetchaddr)
if [ $? -eq 0 ]; then
    for mail in ${HOME}/Mail/*/*/new/*; do
        cat "${mail}" | lbdb-fetchaddr
    done
fi
