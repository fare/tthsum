#!/bin/sh
case "$1" in
    ""|asdf)
        cl-launch -l sbcl -s tthsum -o tthsum -d ! -E 'tthsum::main'
        ;;
    xcvb)
        xcvb make-build --build /tthsum/tthsum
        ;;
esac
