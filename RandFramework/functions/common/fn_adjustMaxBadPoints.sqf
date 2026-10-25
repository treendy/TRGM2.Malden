//Raises reputation. Can be called from anywhere, the change is always made on the server so updates from different machines can't overwrite each other
params ["_pointsToAdd","_message"];

if (!isServer) exitWith {
	[_pointsToAdd, _message] remoteExecCall ["TRGM_fnc_adjustMaxBadPoints", 2];
};

isNil { //run unscheduled so the read-modify-write can't be interrupted
	if (isNil "BadPointsReason") then {BadPointsReason = ""};
	MaxBadPoints = MaxBadPoints + _pointsToAdd;
	publicVariable "MaxBadPoints";
	BadPointsReason = BadPointsReason + format["<br /><t color='#00ff00'>%1 (+%2)</t>",_message,_pointsToAdd];
	publicVariable "BadPointsReason";
};
