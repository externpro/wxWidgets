#!/bin/bash
mkdir _SunOS_Debug _SunOS_Release
cd _SunOS_Debug
../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams --enable-debug --enable-debug_flag --enable-debug_info --enable-debug_gdb
gmake
cd ../_SunOS_Release
../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams
gmake
cd ..
./install-sh -c _SunOS_Release/lib/wx/config/gtk2-ansi-release-static-2.8 _SunOS_Release/thewxconfig

# copy to sdlExtern
cp _SunOS_Debug/lib/libwx*.a ~/src/sdlExtern/lib
cp _SunOS_Release/lib/libwx*.a ~/src/sdlExtern/lib
cp _SunOS_Debug/lib/wx/config/gtk2-ansi-debug-static-2.8 ~/src/sdlExtern/lib/wx/config
cp _SunOS_Debug/lib/wx/include/gtk2-ansi-debug-static-2.8/wx/setup.h ~/src/sdlExtern/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
cp _SunOS_Release/lib/wx/config/gtk2-ansi-release-static-2.8 ~/src/sdlExtern/lib/wx/config
cp _SunOS_Release/lib/wx/include/gtk2-ansi-release-static-2.8/wx/setup.h ~/src/sdlExtern/lib/wx/include/gtk2-ansi-release-static-2.8/wx
cp _SunOS_Release/utils/wxrc/wxrc ~/src/sdlExtern/bin
cp _SunOS_Release/utils/wxrc/wxrc ~/src/sdlExtern/bin/wxrc-2.8
cp _SunOS_Release/thewxconfig ~/src/sdlExtern/bin/wx-config

