TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += testSupport

# Compile and add code to the support library
testSupport_SRCS += xxxRecord.c
testSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
testSupport_SRCS += dbSubExample.c
testSupport_SRCS += devtestVersion.c
testSupport_SRCS += testHello.c
testSupport_SRCS += initTrace.c

testSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = testVersion.h
# Macro name
GENVERSIONMACRO = testVERSION

# Build the IOC application
PROD_IOC = test

# test.dbd will be created and installed
DBD += test.dbd

# test.dbd will include these files:
test_DBD += base.dbd
test_DBD += xxxSupport.dbd
test_DBD += dbSubExample.dbd
test_DBD += devtestVersion.dbd
test_DBD += testHello.dbd
test_DBD += initTrace.dbd

# test_registerRecordDeviceDriver.cpp derives from test.dbd
test_SRCS += test_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
test_SRCS_DEFAULT += testMain.cpp
test_SRCS_vxWorks += -nil-

# Link in the code from our support library
test_LIBS += testSupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into testSupport
    sncExample_SNCFLAGS += +r
    test_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    testSupport_SRCS += sncExample.stt
    testSupport_LIBS += seq pv
    test_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    test_LIBS += qsrv
    test_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    test_DBD += PVAServerRegister.dbd
    test_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
test_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devtestVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
