""" fwlib test script
"""
import fwlib32
fwlib32.startupprocess()
libh = fwlib32.allclibhndl3("127.0.0.1")
print(f'{libh=}')


#print('sysinfo', fwlib32.sysinfo(libh))


fwlib32.freelibhndl(libh)
fwlib32.exitprocess()
