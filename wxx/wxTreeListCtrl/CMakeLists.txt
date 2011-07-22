project( wxTreeListCtrl )

set(SOURCES 
  src/treelistctrl.cpp
  Makefile
)

include_directories( 
  "$(ProjectDir).."
  "$(ProjectDir)../../include"
  include
)

add_library( wxTreeListCtrl STATIC ${SOURCES} )

