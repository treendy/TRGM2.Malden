//example: [0.3, _PointsAdjustMessage] execVM "RandFramework\AdjustMaxBadPoints.sqf";

#include "../setUnitGlobalVars.sqf";

//if (bDebugMode) then {hint format["Points adjusting: %1", TRGM_Logic getVariable "PointsUpdating"]};

sleep random [1,2.5,5]; //to increase the chance of not fireing at same time! (not convinsed that the "PointsUpdating" variable actually helped)

waitUntil {!(TRGM_Logic getVariable "PointsUpdating")};
TRGM_Logic setVariable ["PointsUpdating", true, true];

params ["_pointsToAdd","_message"];


MaxBadPoints = MaxBadPoints + _pointsToAdd; 
publicVariable "MaxBadPoints";

BadPointsReason = BadPointsReason + format["<br /><t color='#00ff00'>%1 (+%2)</t>",_message,_pointsToAdd]; 
publicVariable "BadPointsReason";

TRGM_Logic setVariable ["PointsUpdating", false, true];


