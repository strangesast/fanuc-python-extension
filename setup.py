from distutils.core import setup, Extension
import sysconfig

#extra_compile_args = sysconfig.get_config_var('CFLAGS').split()
#print(extra_compile_args)
#extra_compile_args += ['-m32']

module1 = Extension('fwlib', sources = ['fwlibmodule.c'], libraries=['fwlib32'],
        #extra_compile_args=extra_compile_args
)

setup (name = 'fwlib',
        version = '0.1',
        author='Sam Zagrobelny',
        author_email='strangesast@gmail.com',
        url='https://github.com/strangesast/fwlib-python-extension',
        description = 'Fanuc FOCAS',
        ext_modules = [module1])
