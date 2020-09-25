from python:3-slim-buster as base

copy ./external/fwlib/libfwlib32-linux-x64.so.1.0.5 /usr/local/lib/
run ln -s /usr/local/lib/libfwlib32-linux-x64.so.1.0.5 /usr/local/lib/libfwlib32.so && ldconfig

workdir /usr/src/app

#from base as builder
run apt-get update && apt-get install -y build-essential

copy . .
#run python3 setup.py sdist
run python3 setup.py install

#from base
#copy --from=builder /usr/src/app/dist/fwlib-0.1.tar.gz /tmp/
#run pip install /tmp/fwlib-0.1.tar.gz
workdir /examples

copy examples .
