//shows which build is running (bump the last number in version.sqf on every code change)
call compile preprocessFileLineNumbers "version.sqf";
systemChat format[localize "STR_TRGM2_Version", TRGM_Version];
titleText [format[localize "STR_TRGM2_Version", TRGM_Version], "PLAIN DOWN", 3];

#include "setUnitGlobalVars.sqf";
#include "RandFramework\General\TRGMInitPlayerLocal.sqf";
