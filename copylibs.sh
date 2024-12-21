#!/usr/bin/env bash
dp0="$(dirname $(readlink -m $BASH_SOURCE))"
if [ -n "$1" ] && [ -d "$1" ] ; then outdir="$1" ; else outdir="$dp0/build" ; fi
if [ -n "$2" ] && [ -d "$2" ] ; then _MSYS_PATH="$2" ; else _MSYS_PATH="/c/msys64/clang64/bin" ; fi
echo "Copying $_MSYS_PATH/libc++.dll to $outdir/libc++.dll..."
cp "$_MSYS_PATH/libc++.dll" "$outdir/libc++.dll"
