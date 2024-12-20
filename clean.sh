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
if [ -n "$destdir" ] && [ -d "$destdir" ] ; then
    echo "Cleaning compilation..."
    [ -d "$dp0/build" ] && rm -rf "$dp0/build"
    rm -f "$destdir/lib${1}${lext}"
    [ -n "${isfile}" ] && rm -f "$destdir/${3}"
    "$dp0/delcfg.sh"
    return 0 2>/dev/null
    exit 0
else
    echo "Invalid target directory $destdir"
    return 1 2>/dev/null
    exit 1
fi
