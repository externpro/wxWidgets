project( wxthings )

set(SOURCES 
  ../src/block.cpp
  ../src/bmpcombo.cpp
  ../src/dropdown.cpp
  ../src/filebrws.cpp
  ../src/genergdi.cpp
  ../src/geometry.cpp
  ../src/menubtn.cpp
  ../src/optvalue.cpp
  ../src/range.cpp
  ../src/spinctld.cpp
  ../src/toggle.cpp
  ../Makefile
)

include_directories( 
  "$(ProjectDir)../.."
  "$(ProjectDir)../../../include"
  ../include
)

add_library( wxthings STATIC ${SOURCES} )

