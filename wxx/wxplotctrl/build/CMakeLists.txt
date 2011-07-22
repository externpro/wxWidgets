project( wxplotctrl )

set(SOURCES 
  ../src/fourier.c
  ../src/fparser.cpp
  ../src/fpoptimizer.cc
  ../src/lm_lsqr.cpp
  ../src/plotctrl.cpp
  ../src/plotcurv.cpp
  ../src/plotdata.cpp
  ../src/plotdraw.cpp
  ../src/plotfunc.cpp
  ../src/plotmark.cpp
  ../src/plotprnt.cpp
  ../Makefile
)

include_directories( 
  "$(ProjectDir)../.."
  "$(ProjectDir)../../../include"
  ../../wxthings/include
  ../include
)

add_library( wxplotctrl STATIC ${SOURCES} )

