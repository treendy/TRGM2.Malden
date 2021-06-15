
//if (TRGM_VAR_bDebugMode) then {[format["Points adjusting: %1", TRGM_Logic getVariable "PointsUpdating"]] call TRGM_GLOBAL_fnc_notify;};

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
if (isNil "TRGM_VAR_CoreCompleted") then { TRGM_VAR_CoreCompleted =   false; publicVariable "TRGM_VAR_CoreCompleted"; };
if (!TRGM_VAR_CoreCompleted) exitWith {};

sleep random [1,2.5,5]; //to increase the chance of not fireing at same time! (not convinsed that the "PointsUpdating" variable actually helped)


if (isNil { TRGM_Logic getVariable "PointsUpdating" }) then {
    TRGM_Logic setVariable ["PointsUpdating", false, true];
};

waitUntil {sleep 2; !(TRGM_Logic getVariable "PointsUpdating")};
TRGM_Logic setVariable ["PointsUpdating", true, true];

params ["_pointsToAdd","_message"];

_totalRep = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;

if (_totalRep > 0) then {
    TRGM_VAR_BadPoints = TRGM_VAR_BadPoints + _pointsToAdd;
    if (TRGM_VAR_BadPoints > TRGM_VAR_MaxBadPoints) then {
        TRGM_VAR_BadPoints = TRGM_VAR_MaxBadPoints;
    };
    publicVariable "TRGM_VAR_BadPoints";
    TRGM_VAR_BadPointsReason = TRGM_VAR_BadPointsReason + format["<br /><t color='#ff0000'>%1 (-%2)</t>",_message,_pointsToAdd];
    publicVariable "TRGM_VAR_BadPointsReason";
};

TRGM_Logic setVariable ["PointsUpdating", false, true];

TRGM_VAR_BadPoints;