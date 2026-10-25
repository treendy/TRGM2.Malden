//creates a crewed, stationary objective vehicle at _pos, publishes it under _sName and spawns _loopFnc on it (if given); returns the vehicle
params ["_className", "_sName", "_pos", ["_loopFnc", {}], ["_spawnPos", [0,0,500]]];

private _objVehicle = _className createVehicle _spawnPos;
_objVehicle setVariable [_sName, _objVehicle, true];
createVehicleCrew _objVehicle;
missionNamespace setVariable [_sName, _objVehicle];
_objVehicle setPos _pos;
_objVehicle disableAI "MOVE";
[_objVehicle] spawn _loopFnc;
_objVehicle
