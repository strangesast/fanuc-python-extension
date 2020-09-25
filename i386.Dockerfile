from i386/python:3-buster

copy ./external/fwlib/libfwlib32-linux-x86.so.1.0.5 /usr/local/lib/
run ln -s /usr/local/lib/libfwlib32-linux-x86.so.1.0.5 /usr/local/lib/libfwlib32.so && ldconfig

workdir /usr/src/app

copy . .
run python3 setup.py install

workdir /examples
copy examples .
