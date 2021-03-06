#!./bin/linux-arm/pm

#- You may have to change pm to something else
#- everywhere it appears in this file

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/pm.dbd"
pm_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "db/user.substitutions"
dbLoadRecords "db/pmVersion.db", "user=PSM"
dbLoadRecords "db/dbSubExample.db", "user=PSM"
dbLoadRecords "db/time.db", "user=PSM"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs
#seq sncExample, "user=pi"
