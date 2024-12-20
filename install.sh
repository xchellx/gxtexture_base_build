#!/usr/bin/env bash
dp0="$(dirname $(readlink -m $BASH_SOURCE))"
destdir="$(printf '%s' ${2} | sed -E -e 's/\\/\//g' -e 's/C:/\/c/g' -e 's/\"*([^\"]+)\"*/\1/')"
iswin=""
[ -n "${3}" ] && iswin="1"
isfile=""
if [ -n "${3}" ] && [ "${3}" == *dll ] ; then
    isfile="1"
fi
[ -n "${iswin}" ] && lext=".dll" || lext=".so"
if [ -d "$dp0/build" ] && [ -d "$dp0/build/CMAKE/${1}" ] && [ -n "$destdir" ] && [ -d "$destdir" ] ; then
    echo "Installing built dlls to $destdir..."
    cp -f "$dp0/build/CMAKE/${1}/lib${1}${lext}" "$destdir/lib${1}${lext}"
    [ -n "${isfile}" ] && cp -f "$dp0/build/${3}" "$destdir/${3}"
    return 0 2>/dev/null
    exit 0
else
    echo "Invalid target directory $destdir"
    return 1 2>/dev/null
    exit 1
fi
