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

#
OS=$(uname -s)
DIRDBG=_${OS}_Debug
DIRREL=_${OS}_Release

if [ ${copy} -eq 1 ]
then
  echo "Making the wxWidgets directories in sdlExtern..."
  ./install-sh -c ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${DIRREL}/thewxconfig
  # Make sdlExtern directories if they don't already exist
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
fi

if [ ${lock} -eq 1 ]
then
  echo "SVN Locking wxWidgets binaries..."
  # Lock the binary files in sdlExtern/lib
  for libFile in ${DIRDBG}/lib/libwx*.a ${DIRREL}/lib/libwx*.a
  do
    svn lock ${SDLEXTERN}/lib/$(basename ${libFile})
  done

  # Lock the binary files in sdlExtern/bin
  for binFile in ${SDLEXTERN}/bin/wxrc ${SDLEXTERN}/bin/wxrc-2.8
  do
    svn lock ${SDLEXTERN}/bin/$(basename ${binFile})
  done
fi

if [ ${copy} -eq 1 ]
then
  echo "Installing the wxWidgets binaries..."
  # Copy to sdlExtern
  cp ${DIRDBG}/lib/libwx*.a ${SDLEXTERN}/lib
  cp ${DIRREL}/lib/libwx*.a ${SDLEXTERN}/lib
  cp ${DIRDBG}/lib/wx/config/gtk2-ansi-debug-static-2.8 ${SDLEXTERN}/lib/wx/config
  cp ${DIRDBG}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx/setup.h ${SDLEXTERN}/lib/wx/include/gtk2-ansi-debug-static-2.8/wx
  cp ${DIRREL}/lib/wx/config/gtk2-ansi-release-static-2.8 ${SDLEXTERN}/lib/wx/config
  cp ${DIRREL}/lib/wx/include/gtk2-ansi-release-static-2.8/wx/setup.h ${SDLEXTERN}/lib/wx/include/gtk2-ansi-release-static-2.8/wx
  cp ${DIRREL}/utils/wxrc/wxrc ${SDLEXTERN}/bin
  cp ${DIRREL}/utils/wxrc/wxrc ${SDLEXTERN}/bin/wxrc-2.8
  cp ${DIRREL}/thewxconfig ${SDLEXTERN}/bin/wx-config
fi

#end of script
