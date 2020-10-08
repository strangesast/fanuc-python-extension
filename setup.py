""" ayy wrap fwlib32
"""
from distutils.core import setup, Extension

NAME = "fwlib32"
VERSION = "0.1"

setup(name=NAME, version=VERSION, ext_modules=[Extension(name='_fwlib32', sources=['fwlib32.i'])])
