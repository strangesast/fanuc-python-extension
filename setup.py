from distutils.core import setup, Extension

name = "fwlib32"
version = "0.1"

setup(name=name, version=version, ext_modules=[Extension(name='_fwlib32', sources='fwlib32.i')])
