//Lowers reputation. Can be called from anywhere, the change is always made on the server so updates from different machines can't overwrite each other
params ["_pointsToAdd","_message"];

if (!isServer) exitWith {
	[_pointsToAdd, _message] remoteExecCall ["TRGM_fnc_adjustBadPoints", 2];
};

isNil { //run unscheduled so the read-modify-write can't be interrupted
	if (isNil "BadPointsReason") then {BadPointsReason = ""};
	private _totalRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
	if (_totalRep > 0) then {
		BadPoints = (BadPoints + _pointsToAdd) min MaxBadPoints;
		publicVariable "BadPoints";
		BadPointsReason = BadPointsReason + format["<br /><t color='#ff0000'>%1 (-%2)</t>",_message,_pointsToAdd];
		publicVariable "BadPointsReason";
	};
};
