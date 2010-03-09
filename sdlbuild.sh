#!/bin/bash

cd $(dirname $0)
curDir=$(pwd)

function usage()
{
  echo -e "Usage: $(basename $0) [-cl] [--copy] [--lock] <path to sdlExtern>"                     >&2
  echo -e "\tWhere:\t[ -c | --copy ]     - tells it to copy the binaries to sdlExtern"            >&2
  echo -e "\t\t[ -l | --lock ]     - tells it to first svn lock the binaries in sdlExtern"        >&2
  echo -e "\t\t<path to sdlExtern> - is the relative or absolute path to the sdlExtern directory" >&2
  exit 1
}

let copy=0
let lock=0

# Parse the options and parameters.
cmdLine="$*"
while getopts "cl-:?h" Option
do
#{
  case ${Option} in
  #{
    # This will copy the binaries to the sdlExtern directory
    c ) let copy=1 ;;

    # This will svn lock the binaries in the sdlExtern directory before copying
    l ) let lock=1 ;;

    - ) if [ "${OPTARG}" == "copy" ]
        then
          # This will copy the binaries to the sdlExtern directory
          let copy=1
        elif [ "${OPTARG}" == "lock" ]
        then
          # This will svn lock the binaries in the sdlExtern directory before copying
          let lock=1
        elif [ "${OPTARG}" == "help" ]
        then
          # Display the usage of this tool and quit.
          usage
        fi ;;

    # Display usage and quit.
    '?' ) usage ;;
    'h' ) usage ;;
  #}
  esac
#}
done
shift $(($OPTIND - 1))

# Parse the parameter.
if [ -z "${1}" ]
then
  usage
else
  SDLEXTERN=${1}
  if [[ ! -d ${SDLEXTERN}/include ]]; then
    echo "Error: $1 does not appear to be sdlExtern" >&2
    usage
  fi
fi
# Make sure that it is an absolute path
cd ${SDLEXTERN}
SDLEXTERN=`pwd`
cd - >/dev/null

OS=$(uname -s)
MAKECMD=gmake
if [[ "$OS" == "Linux" ]]; then
MAKECMD=make
fi
DIRDBG=_${OS}_Debug
DIRREL=_${OS}_Release

# Clean build -- if the directories exist, we'll wipe 'em out here
if [[ -d ${DIRDBG} ]]; then
  rm -Rf ${DIRDBG}
fi
if [[ -d ${DIRREL} ]]; then
  rm -Rf ${DIRREL}
fi

mkdir ${DIRDBG}
cd ${DIRDBG}
# Debug
CXXFLAGS="-O2 -mcpu=ultrasparc -Wno-unknown-pragmas" CFLAGS="-O2 -mcpu=ultrasparc -Wno-unknown-pragmas" CXXFLAGS="-mcpu=ultrasparc" CFLAGS="-mcpu=ultrasparc" ../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams --enable-debug --enable-debug_flag --enable-debug_info --enable-debug_gdb
${MAKECMD}
cd ..

mkdir ${DIRREL}
cd ${DIRREL}
# Release
CXXFLAGS="-O2 -mcpu=ultrasparc -Wno-unknown-pragmas" CFLAGS="-O2 -mcpu=ultrasparc -Wno-unknown-pragmas" CXXFLAGS="-mcpu=ultrasparc" CFLAGS="-mcpu=ultrasparc" ../configure --with-gtk=2 --with-opengl --with-libjpeg=builtin --with-libpng=builtin --with-libtiff=builtin --with-expat=builtin --with-regex=builtin --with-zlib=builtin --disable-shared --disable-precomp-headers --enable-display --enable-std_string --enable-std_iostreams
${MAKECMD}
cd ..

# Now install the binaries.
${curDir}/sdlinstall.sh ${cmdLine}

echo "Done."

#end of script
