#include "../setUnitGlobalVars.sqf";

//if (bDebugMode) then {hint format["Points adjusting: %1", TRGM_Logic getVariable "PointsUpdating"]};

sleep random [1,2.5,5]; //to increase the chance of not fireing at same time! (not convinsed that the "PointsUpdating" variable actually helped)

waitUntil {!(TRGM_Logic getVariable "PointsUpdating")};
TRGM_Logic setVariable ["PointsUpdating", true, true];

params ["_pointsToAdd","_message"];

badPoints = badPoints + _pointsToAdd; 
publicVariable "badPoints";

BadPointsReason = BadPointsReason + format["\n%1 (%2)",_message,_pointsToAdd]; 
publicVariable "BadPointsReason";

TRGM_Logic setVariable ["PointsUpdating", false, true];
//test malden