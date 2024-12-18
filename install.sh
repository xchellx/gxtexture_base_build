#!/usr/bin/env bash
dp0="$(dirname $(readlink -m $BASH_SOURCE))"
destdir="$(printf '%s' ${2} | sed -E -e 's/\\/\//g' -e 's/C:/\/c/g' -e 's/\"*([^\"]+)\"*/\1/')"
if [ -d "$dp0/build" ] && [ -d "$dp0/build/CMAKE/${1}" ] && [ -n "$destdir" ] && [ -d "$destdir" ] ; then
    echo "Installing built dlls to $destdir..."
    cp -f "$dp0/build/CMAKE/${1}/lib${1}.dll" "$destdir/lib${1}.dll"
    [ -n "${3}" ] && cp -f "$dp0/build/libc++.dll" "$destdir/libc++.dll"
    return 0 2>/dev/null
    exit 0
else
    echo "Invalid target directory $destdir"
    return 1 2>/dev/null
    exit 1
fi
