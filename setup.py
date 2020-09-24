from distutils.core import setup, Extension

module1 = Extension('fwlib', sources = ['fwlibmodule.c'], libraries=['fwlib32'])

setup (name = 'fwlib',
        version = '0.1',
        description = 'Fanuc FOCAS',
        ext_modules = [module1])
