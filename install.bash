#!/bin/bash

# environment setup script, intended to be executed as `curl`

DISTRO="$(source /etc/os-release; echo -n $ID)"

case $DISTRO in
    fedora)
        source $HOME/env/install/fedora.bash
    ;;
    *)
        echo "Unknown distro $DISTRO"
        return 1
    ;;
esac

unset DISTRO
