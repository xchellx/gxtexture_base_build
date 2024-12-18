#!/usr/bin/env bash
dp0="$(dirname $(readlink -m $BASH_SOURCE))"
destdir="$(printf '%s' ${2} | sed -E -e 's/\\/\//g' -e 's/C:/\/c/g' -e 's/\"*([^\"]+)\"*/\1/')"
if [ -n "$destdir" ] && [ -d "$destdir" ] ; then
    echo "Cleaning compilation..."
    [ -d "$dp0/build" ] && rm -rf "$dp0/build"
    rm -f "$destdir/lib${1}.dll"
    [ -n "${3}" ] && rm -f "$destdir/libc++.dll"
    "$dp0/delcfg.sh"
    return 0 2>/dev/null
    exit 0
else
    echo "Invalid target directory $destdir"
    return 1 2>/dev/null
    exit 1
fi
