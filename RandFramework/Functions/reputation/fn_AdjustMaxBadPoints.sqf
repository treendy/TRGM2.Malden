//example: [0.3, _PointsAdjustMessage] spawn TREND_fnc_AdjustMaxBadPoints;

//if (TREND_bDebugMode) then {hint format["Points adjusting: %1", TRGM_Logic getVariable "PointsUpdating"]};

if (!TREND_CoreCompleted) exitWith {};

sleep random [1,2.5,5]; //to increase the chance of not fireing at same time! (not convinsed that the "PointsUpdating" variable actually helped)

waitUntil {!(TRGM_Logic getVariable "PointsUpdating")};
TRGM_Logic setVariable ["PointsUpdating", true, true];

params ["_pointsToAdd","_message"];


TREND_MaxBadPoints = TREND_MaxBadPoints + _pointsToAdd;
publicVariable "TREND_MaxBadPoints";

TREND_BadPointsReason = TREND_BadPointsReason + format["<br /><t color='#00ff00'>%1 (+%2)</t>",_message,_pointsToAdd];
publicVariable "TREND_BadPointsReason";

TRGM_Logic setVariable ["PointsUpdating", false, true];


TREND_MaxBadPoints;