dbLoadDatabase("../../dbd/modbusApp.dbd")
modbusApp_registerRecordDeviceDriver(pdbbase)

#drvAsynIPPortConfigure(const char *portName,
#                       const char *hostInfo,
#                       unsigned int priority,
#                       int noAutoConnect,
#                       int noProcessEos);
drvAsynIPPortConfigure("powerSupply","127.0.0.1:1502", 0, 0, 0)
asynSetOption("powerSupply", 0, "disconnectOnReadTimeout", "Y")
modbusInterposeConfig("powerSupply", 0, 2000, 0)

# drvModbusAsynConfigure("portName", "tcpPortName", slaveAddress, modbusFunction, modbusStartAddress, modbusLength, dataType, pollMsec, "plcType")
drvModbusAsynConfigure("powerOnR",   "powerSupply", 0, 1, 0x00, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("powerOnW",   "powerSupply", 0, 5, 0x00, 1,  "UINT16", 0,    "Power Supply")
drvModbusAsynConfigure("voltageOn",  "powerSupply", 0, 5, 0x01, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("resetBlks",  "powerSupply", 0, 5, 0x02, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("statBits",   "powerSupply", 0, 2, 0x00, 15, "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("statRegs",   "powerSupply", 0, 3, 0x00, 10, "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("outVolts",   "powerSupply", 0, 6, 0x0A, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("outAmpsMax", "powerSupply", 0, 6, 0x0B, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("errPause",   "powerSupply", 0, 6, 0x0C, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("errRate",    "powerSupply", 0, 6, 0x0D, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("coefKP",     "powerSupply", 0, 6, 0x0F, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("coefKI",     "powerSupply", 0, 6, 0x10, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("coefKD",     "powerSupply", 0, 6, 0x11, 1,  "UINT16", 2000, "Power Supply")
drvModbusAsynConfigure("devInfo",    "powerSupply", 0, 3, 0x14, 1,  "UINT16", 2000, "Power Supply")

# Enable ASYN_TRACEIO_HEX on octet server
# asynSetTraceIOMask("powerSupply", 0,4)
# Enable ASYN_TRACE_ERROR and ASYN_TRACEIO_DRIVER on octet server
# asynSetTraceMask("powerSupply", 0, 9)

dbLoadRecords("../../db/powerSupply.template", "PORT=ps1")

set_savefile_path("$(TOP)/iocBoot/$(IOC)")
set_pass1_restoreFile("auto_settings.sav")
save_restoreSet_DatedBackupFiles(1)
save_restoreSet_NumSeqFiles(0)

iocInit

create_triggered_set("auto_settings.req", "ps1:autosave", "PORT=ps1")
