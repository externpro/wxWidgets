#!/bin/bash

function usage()
{
  echo "Usage: $0 <path to sdlExtern>"
}

if [[ $# == 0 ]]; then
  usage
  exit
else
  SDLEXTERN=$1
  if [[ ! -d ${SDLEXTERN}/include ]]; then
    echo "Error: $1 does not appear to be sdlExtern"
    usage
    exit
  fi
fi

OS=$(uname -s)
MAKECMD=gmake
if [[ "$OS" == "Linux" ]]; then
MAKECMD=make
fi
DIRDBG=_${OS}_Debug
DIRREL=_${OS}_Release

# clean build -- if the directories exist, we'll wipe 'em out here
if [[ -d ${DIRDBG} ]]; then
  rm -rf ${DIRDBG}
fi
if [[ -d ${DIRREL} ]]; then
  rm -rf ${DIRREL}
fi

mkdir ${DIRDBG}
cd ${DIRDBG}
../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams --enable-debug --enable-debug_flag --enable-debug_info --enable-debug_gdb
${MAKECMD}
cd ..

mkdir ${DIRREL}
cd ${DIRREL}
../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams
${MAKECMD}
cd ..
./install-sh -c ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${DIRREL}/thewxconfig

# make sdlExtern directories if they don't already exist
if [[ ! -d ${SDLEXTERN}/bin ]]; then
  mkdir -p ${SDLEXTERN}/bin
fi
if [[ ! -d ${SDLEXTERN}/lib/wx/config ]]; then
  mkdir -p ${SDLEXTERN}/lib/wx/config
fi
if [[ ! -d ${SDLEXTERN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx ]]; then
  mkdir -p ${SDLEXTERN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
fi
if [[ ! -d ${SDLEXTERN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx ]]; then
  mkdir -p ${SDLEXTERN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx
fi

# copy to sdlExtern
cp ${DIRDBG}/lib/libwx*.a ${SDLEXTERN}/lib
cp ${DIRREL}/lib/libwx*.a ${SDLEXTERN}/lib
cp ${DIRDBG}/lib/wx/config/gtk2-ansi-debug-static-2.8 ${SDLEXTERN}/lib/wx/config
cp ${DIRDBG}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx/setup.h ${SDLEXTERN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
cp ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${SDLEXTERN}/lib/wx/config
cp ${DIRREL}/lib/wx/include/gtk2-ansi-release-static-2.8/wx/setup.h ${SDLEXTERN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx
cp ${DIRREL}/utils/wxrc/wxrc ${SDLEXTERN}/bin
cp ${DIRREL}/utils/wxrc/wxrc ${SDLEXTERN}/bin/wxrc-2.8
cp ${DIRREL}/thewxconfig ${SDLEXTERN}/bin/wx-config

