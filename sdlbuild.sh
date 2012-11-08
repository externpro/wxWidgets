#!/bin/bash

# linux: sudo apt-get install libgtk2.0-dev libglu1-mesa-dev

cd $(dirname $0)

OS=$(uname -s)
MAKECMD=gmake
if [[ "$OS" == "Linux" ]]; then
MAKECMD=make
fi
if [[ "$OS" == "Darwin" ]]; then
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
  rm -Rf ${DIRXTN}
fi

mkdir ${DIRDBG}
cd ${DIRDBG}
# Debug
if [[ "$OS" == "Darwin" ]]; then
  arch_flags="-arch i386"
  ../configure CFLAGS="$arch_flags" CXXFLAGS="$arch_flags" CPPFLAGS="$arch_flags" LDFLAGS="$arch_flags" OBJCFLAGS="$arch_flags" OBJCXXFLAGS="$arch_flags" --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams --enable-debug --enable-debug_flag --enable-debug_info --enable-debug_gdb
else
  ../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams --enable-debug --enable-debug_flag --enable-debug_info --enable-debug_gdb
fi
${MAKECMD}
cd ..

mkdir ${DIRREL}
cd ${DIRREL}
# Release
if [[ "$OS" == "Darwin" ]]; then
  arch_flags="-arch i386"
  ../configure CFLAGS="$arch_flags" CXXFLAGS="$arch_flags" CPPFLAGS="$arch_flags" LDFLAGS="$arch_flags" OBJCFLAGS="$arch_flags" OBJCXXFLAGS="$arch_flags" --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams
else
  ../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams
fi

${MAKECMD}
cd ..

if [[ "$OS" == "Darwin" ]]; then
  ./install-sh -c ${DIRREL}/lib/wx/config/mac-ansi-release-static-2.8 ${DIRREL}/thewxconfig
else
  ./install-sh -c ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${DIRREL}/thewxconfig
fi

# Create _*_Extern directory structure
mkdir -p ${DIRXTN}/bin
mkdir -p ${DIRXTN}/lib/wx/config
if [[ "$OS" == "Darwin" ]]; then
  mkdir -p ${DIRXTN}/lib/wx/include/mac-ansi-debug-static-2.8/wx
  mkdir -p ${DIRXTN}/lib/wx/include/mac-ansi-release-static-2.8/wx
else
  mkdir -p ${DIRXTN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
  mkdir -p ${DIRXTN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx
fi

# Move/Copy to _*_Extern directory
mv ${DIRDBG}/lib/libwx*.a ${DIRXTN}/lib
mv ${DIRREL}/lib/libwx*.a ${DIRXTN}/lib
if [[ "$OS" == "Darwin" ]]; then
  cp ${DIRDBG}/lib/wx/config/mac-ansi-debug-static-2.8 ${DIRXTN}/lib/wx/config
  cp ${DIRDBG}/lib/wx/include/mac-ansi-debug-static-2.8/wx/setup.h ${DIRXTN}/lib/wx/include/mac-ansi-debug-static-2.8/wx
  cp ${DIRREL}/lib/wx/config/mac-ansi-release-static-2.8 ${DIRXTN}/lib/wx/config
  cp ${DIRREL}/lib/wx/include/mac-ansi-release-static-2.8/wx/setup.h ${DIRXTN}/lib/wx/include/mac-ansi-release-static-2.8/wx
else
  cp ${DIRDBG}/lib/wx/config/gtk2-ansi-debug-static-2.8 ${DIRXTN}/lib/wx/config
  cp ${DIRDBG}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx/setup.h ${DIRXTN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
  cp ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${DIRXTN}/lib/wx/config
  cp ${DIRREL}/lib/wx/include/gtk2-ansi-release-static-2.8/wx/setup.h ${DIRXTN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx
fi
cp ${DIRREL}/utils/wxrc/wxrc ${DIRXTN}/bin
cp ${DIRREL}/utils/wxrc/wxrc ${DIRXTN}/bin/wxrc-2.8
cp ${DIRREL}/thewxconfig ${DIRXTN}/bin/wx-config

echo "Done."

#end of script
