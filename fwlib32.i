%module fwlib32
%{
#include "external/fwlib/fwlib32.h"
%}

%inline %{
unsigned short libh;
%}

extern short cnc_startupprocess(long /* log level */, const char * /* log filename */);
%pythoncode %{
def startupprocess(log_level = 0, log_filename = "focas.log"):
  ret = cnc_startupprocess(log_level, log_filename)
  if ret:
    raise Exception("startupprocess failed with " + ret)
  return
%}

extern short cnc_allclibhndl3( const char * /* device ip */, unsigned short /* device port */, long /* timeout */, unsigned short * /* lib handle*/);
%pythoncode %{
def allclibhndl3(device_ip, device_port = 8193, timeout = 10):
  ret = cnc_allclibhndl3(device_ip, device_port, timeout, _fwlib32.cvar.libh)
  if ret:
    raise Exception("allclibhndl3 failed with " + ret)
  return
%}

extern short cnc_freelibhndl( unsigned short /* lib handle */);
%pythoncode %{
def freelibhndl():
  ret = cnc_freelibhndl(_fwlib32.cvar.libh)
  if ret:
    raise Exception("freelibhndl failed with " + ret)
  return
%}

extern short cnc_rdcncid( unsigned short /* lib handle */, unsigned long * /* cnc id array long[4] */);
%pythoncode %{
def rdcncid():
  cncids = [0 for _ in range(4)]
  ret = cnc_rdcncid(_fwlib32.cvar.libh, cncids)
  if ret:
    raise Exception("freelibhndl failed with " + ret)
  return cncids
%}

extern short cnc_exitprocess();
%pythoncode %{
def exitprocess():
  ret = cnc_exitprocess()
  if ret:
    raise Exception("exitprocess failed with " + ret)
  return
%}

extern short cnc_sysinfo( unsigned short /* lib handle */, ODBSYS * /* sysinfo */);
extern struct odbsys {
    short   addinfo ;       /* additional information  */
    short   max_axis ;      /* maximum axis number */
    char    cnc_type[2] ;   /* cnc type <ascii char> */
    char    mt_type[2] ;    /* M/T/TT <ascii char> */
    char    series[4] ;     /* series NO. <ascii char> */
    char    version[4] ;    /* version NO.<ascii char> */
    char    axes[2] ;       /* axis number<ascii char> */
};

extern short cnc_rdaxisdata( unsigned short /* lib handle */, short /* path */, short * /* types array */, short /* axis num */, short /* len */, ODBAXDT * /* result interface */);
extern struct odbaxdt {
    char    name[4];    /* axis name */
    long    data;       /* position data */
    short   dec;        /* decimal position */
    short   unit;       /* data unit */
    short   flag;       /* flags */
    short   reserve;    /* reserve */
};

%pythoncode %{
def rdaxisdata():
  cncids = [0 for _ in range(4)]
  ret = cnc_rdcncid(fwlib.cvar.libh, cncids)
  if ret:
    raise Exception("freelibhndl failed with " + ret)
  return cncids
%}

extern short cnc_getfigure( unsigned short /* lib handle */, short /* 0 */, short * /* count */, short * /* inprec */, short * /* outprec */);

extern short cnc_rdaxisname( unsigned short /* lib handle */, short * /* axisCount */, ODBAXISNAME * /* axes */);
extern struct odbaxisname {
    char name;          /* axis name */
    char suff;          /* suffix */
};

%pythoncode %{
def exitprocess():
  sysinfo = _fwlib32.odbsys()
  ret = cnc_sysinfo(_fwlib32.cvar.libh, sysinfo)
  if ret:
    raise Exception("exitprocess failed with " + ret)
  return odbsys
%}