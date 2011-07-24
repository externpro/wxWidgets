project(wxx)
cmake_minimum_required(VERSION 2.8.5)
set(wxx_libs
  wxIFM
  wxplotctrl
  wxthings
  #wxTreeListCtrl
  #wxTreeMultiCtrl
)
foreach(lib ${wxx_libs})
  add_subdirectory(${lib})
endforeach()

