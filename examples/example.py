import fwlib
from contextlib import contextmanager

@contextmanager
def get_machine_connection(machine_ip, machine_port, timeout = 10):
    print('connect')
    fwlib.allclibhndl3(machine_ip) #, machine_port, timeout)
    try:
        yield
    finally:
        print('disconnect')
        fwlib.freelibhndl()

if __name__ == '__main__':
    with get_machine_connection('localhost', 8193):
        cnc_id = fwlib.rdcncid()
        print(cnc_id)
        #fwlib.get_status
    print('toast!')
