project( wxIFM )

set(SOURCES 
  src/ifm/definterface.cpp
  src/ifm/defplugin.cpp
  src/ifm/dragndrop.cpp
  src/ifm/events.cpp
  src/ifm/manager.cpp
  src/ifm/plugin.cpp
  src/ifm/resize.cpp
  docs/building.dox
  docs/coordsystems.dox
  docs/internals.dox
  docs/main.dox
  docs/overview.dox
  Makefile
)

include_directories( 
  "$(ProjectDir).."
  "$(ProjectDir)../../include"
  include
  src/ifm/xpm
)

add_library( wxIFM STATIC ${SOURCES} )

