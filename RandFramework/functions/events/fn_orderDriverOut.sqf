//makes the driver of a vehicle get out and join a new friendly group (server side, the AI unit is local there)
params ["_veh"];
if (!isServer) exitWith {[_veh] remoteExec ["TRGM_fnc_orderDriverOut", 2];};

private _unit = driver _veh;
if (!alive _unit) exitWith {};
_unit action ["getout", _veh];
_unit disableAI "MOVE";
private _tempGroup1 = createGroup WEST;
(units group _unit) joinSilent _tempGroup1;
[group _unit] call TRGM_fnc_deleteAllWaypoints;
