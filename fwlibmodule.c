#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <stdio.h>
#include "external/fwlib/fwlib32.h"

unsigned short libh;

static PyObject *allclibhndl3(PyObject *self, PyObject *args)
{
  long timeout = 10;
  char *device_ip;
  unsigned short device_port = 8193;

  if (!PyArg_ParseTuple(args, "s", &device_ip))
    return NULL;

  printf("Connecting to %s:%d\n", device_ip, device_port);
  if (cnc_allclibhndl3(device_ip, device_port, timeout, &libh) != EW_OK)
  {
    PyErr_SetString(PyExc_Exception, "Failed to connect to cnc!");
    return NULL;
  }

  Py_RETURN_NONE;
}

static PyObject *freelibhndl(PyObject *self, PyObject *args)
{
  if (cnc_freelibhndl(libh) != EW_OK)
  {
    PyErr_SetString(PyExc_Exception, "Failed to free lib handle!");
    return NULL;
  }
  Py_RETURN_NONE;
}

static PyObject *rdcncid(PyObject *self, PyObject *args)
{
  PyObject *m;
  unsigned long cncIDs[4];
  char cncID[36];
  if (cnc_rdcncid(libh, cncIDs) != EW_OK)
  {
    PyErr_SetString(PyExc_Exception, "Failed to get cnc id!");
    return NULL;
  }

  sprintf(cncID, "%08lx-%08lx-%08lx-%08lx", cncIDs[0], cncIDs[1], cncIDs[2], cncIDs[3]);

  m = PyDict_New();
  PyObject *id = PyUnicode_FromString(cncID);
  PyDict_SetItemString(m, "id", id);

  return m;
}

static PyObject *rdaxisname(PyObject *self, PyObject *args)
{
  PyObject *m;

  short axisCount = MAX_AXIS;
  ODBAXISNAME axes[MAX_AXIS];
  if (cnc_rdaxisname(libh, &axisCount, axes) != EW_OK)
  {
    return NULL;
  }

  return NULL;
}

static PyObject *sysinfo(PyObject *self, PyObject *args)
{
  PyObject *m;
  ODBSYS sysinfo;
  char cnc_type[3]; /* cnc type <ascii char> */
  char mt_type[3];  /* M/T/TT <ascii char> */
  char series[5];   /* series NO. <ascii char> */
  char version[5];  /* version NO.<ascii char> */
  char axes[3];     /* axis number<ascii char> */

  // library handle.  needs to be closed when finished.
  if (cnc_sysinfo(libh, &sysinfo) != EW_OK)
  {
    PyErr_SetString(PyExc_Exception, "Failed to get cnc info!");
  }

  // short   addinfo ;       /* additional information  */
  // short   max_axis ;      /* maximum axis number */

  // Py_RETURN_NONE;
  return m;
}

static PyMethodDef methods[] = {
    {"allclibhndl3", allclibhndl3, METH_VARARGS, "Allocates the library handle and connects to CNC that has the specified IP address or the Host Name."},
    {"freelibhndl", freelibhndl, METH_VARARGS, "Frees the library handle which was used by the Data window library."},
    {"rdcncid", rdcncid, METH_VARARGS, "Reads the CNC ID number."},
    {"rdaxisname", rdaxisname, METH_VARARGS, "Reads various data relating to servo axis/spindle."},
    {"sysinfo", sysinfo, METH_VARARGS, "Reads system information such as kind of CNC system, Machining(M) or Turning(T), series and version of CNC system software and number of the controlled axes."},
    {NULL, NULL, 0, NULL}};

void cleanup()
{
  // clean up fwlib stuff
  cnc_freelibhndl(libh);
  cnc_exitprocess();
}

static struct PyModuleDef fwlibmodule = {PyModuleDef_HEAD_INIT,
                                         "fwlib", /* name of module */
                                         "",      /* module documentation, may be NULL */
                                         -1,      /* size of per-interpreter state of the module, or -1 if the module keeps state in global variables. */
                                         methods, /* a pointer to a table of module-level functions */
                                         NULL,    /* An array of slot definitions for multi-phase initialization */
                                         NULL,    /* A traversal function to call during GC traversal of the module object */
                                         NULL,    /* A clear function to call during GC clearing of the module object */
                                         cleanup};

PyMODINIT_FUNC PyInit_fwlib(void)
{
  PyObject *m;

  m = PyModule_Create(&fwlibmodule);
  if (m == NULL)
  {
    return NULL;
  }

  if (cnc_startupprocess(0, "focas.log") != EW_OK)
  {
    fprintf(stderr, "Failed to create required log file!\n");
    PyErr_SetString(PyExc_Exception, "Failed to create required log file!\n");
    return NULL;
  }

  return m;
}

// deinit
