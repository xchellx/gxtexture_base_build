#!/usr/bin/env bash
dp0="$(dirname $(readlink -m $BASH_SOURCE))"
iswin=""
[ -n "${2}" ] && iswin="1"
isfile=""
if [ -n "${2}" ] && [ "${2}" == *dll ] ; then
    isfile="1"
fi
[ -n "${iswin}" ] && lext=".dll" || lext=".so"
if [ -n "${1}" ] ; then
    echo "Building with cmake into $dp0/build/lib${1}${lext}..."
    UPPER_NAME="$(echo ${1} | tr 'a-z' 'A-Z')"
    [ -d "$dp0/build" ] || cmake -S "$dp0/${1}" -B "$dp0/build" -DCMAKE_BUILD_TYPE=Release -G Ninja -DGXTEXTURE_BUILD_SSE2:BOOL=ON -DGXTEXTURE_BUILD_AVX:BOOL=ON -DGXTEXTURE_BUILD_AVX2:BOOL=ON -D${UPPER_NAME}_STATIC:BOOL=OFF
    if [ -d "$dp0/build" ] ; then
        cmake --build "$dp0/build"
        [ -n "${isfile}" ] && "$dp0/copylibs.sh" "$dp0/build"
        if [ -f "$dp0/build/CMAKE/${1}/lib${1}${lext}" ] ; then
            return 0 2>/dev/null
            exit 0
        elif [ -z "${2}" ] || [ -f "$dp0/build/${2}" ] ; then
            return 0 2>/dev/null
            exit 0
        else
            echo "Build files dont exist; build failed"
            return 1 2>/dev/null
            exit 1
        fi
    else
        echo "$dp0/build doesnt exist; build failed"
        return 1 2>/dev/null
        exit 1
    fi
fi
