#include "../setUnitGlobalVars.sqf";

//if (bDebugMode) then {hint format["Points adjusting: %1", TRGM_Logic getVariable "PointsUpdating"]};

sleep random [1,2.5,5]; //to increase the chance of not fireing at same time! (not convinsed that the "PointsUpdating" variable actually helped)

waitUntil {!(TRGM_Logic getVariable "PointsUpdating")};
TRGM_Logic setVariable ["PointsUpdating", true, true];

_PointsToAdd = _this select 0;
_Message = _this select 1;

badPoints = badPoints + _PointsToAdd; 
publicVariable "badPoints";

BadPointsReason = BadPointsReason + format["\n%1 (%2)",_Message,_PointsToAdd]; 
publicVariable "BadPointsReason";


TRGM_Logic setVariable ["PointsUpdating", false, true];
