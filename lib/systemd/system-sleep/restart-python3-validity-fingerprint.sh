#!/bin/sh
set -e

if [ "$2" = "suspend" ] || [ "$2" = "hybrid-sleep" ]; then
    case "$1" in
        post) systemctl restart python3-validity ;;
    esac
fi
