#!/bin/bash
#gcc -shared example.o example_wrap.o \
#  -L/home/beazley/projects/lib \
#  -lfoo \
#  -Xlinker -rpath /home/beazley/projects/lib  \
# c -o _example.so
swig -python fwlib32.i && \
	gcc -shared -o _fwlib32.so fwlib32_wrap.c -I/usr/include/python3.8/ -{L,I}$(pwd)/external/fwlib/ -lfwlib32 -fPIC
