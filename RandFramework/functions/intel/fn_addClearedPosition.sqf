//Adds a position to ClearedPositions and broadcasts it. Can be called from anywhere, the change is always made on the server so clients can't overwrite each other's updates
params ["_pos"];

if (!isServer) exitWith {
	[_pos] remoteExecCall ["TRGM_fnc_addClearedPosition", 2];
};

isNil { //run unscheduled so the read-modify-write can't be interrupted
	if (isNil "ClearedPositions") then {ClearedPositions = [];};
	ClearedPositions pushBack _pos;
	publicVariable "ClearedPositions";
};
