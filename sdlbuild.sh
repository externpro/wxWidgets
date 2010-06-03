#!/bin/bash

cd $(dirname $0)

OS=$(uname -s)
MAKECMD=gmake
if [[ "$OS" == "Linux" ]]; then
MAKECMD=make
fi
DIRDBG=_${OS}_Debug
DIRREL=_${OS}_Release
DIRXTN=_${OS}_Extern

# Clean build -- if the directories exist, we'll wipe 'em out here
if [[ -d ${DIRDBG} ]]; then
  rm -Rf ${DIRDBG}
fi
if [[ -d ${DIRREL} ]]; then
  rm -Rf ${DIRREL}
fi
if [[ -d ${DIRXTN} ]]; then
  rm -RF ${DIRXTN}
fi

mkdir ${DIRDBG}
cd ${DIRDBG}
# Debug
../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams --enable-debug --enable-debug_flag --enable-debug_info --enable-debug_gdb
${MAKECMD}
cd ..

mkdir ${DIRREL}
cd ${DIRREL}
# Release
../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams
${MAKECMD}
cd ..
./install-sh -c ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${DIRREL}/thewxconfig

# Create _*_Extern directory structure
mkdir -p ${DIRXTN}/bin
mkdir -p ${DIRXTN}/lib/wx/config
mkdir -p ${DIRXTN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
mkdir -p ${DIRXTN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx

# Move/Copy to _*_Extern directory
mv ${DIRDBG}/lib/libwx*.a ${DIRXTN}/lib
mv ${DIRREL}/lib/libwx*.a ${DIRXTN}/lib
cp ${DIRDBG}/lib/wx/config/gtk2-ansi-debug-static-2.8 ${DIRXTN}/lib/wx/config
cp ${DIRDBG}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx/setup.h ${DIRXTN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
cp ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${DIRXTN}/lib/wx/config
cp ${DIRREL}/lib/wx/include/gtk2-ansi-release-static-2.8/wx/setup.h ${DIRXTN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx
cp ${DIRREL}/utils/wxrc/wxrc ${DIRXTN}/bin
cp ${DIRREL}/utils/wxrc/wxrc ${DIRXTN}/bin/wxrc-2.8
cp ${DIRREL}/thewxconfig ${DIRXTN}/bin/wx-config

echo "Done."

#end of script
