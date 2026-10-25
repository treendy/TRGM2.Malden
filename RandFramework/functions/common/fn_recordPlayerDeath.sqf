//records where a player was killed (for the "circles of death" no-go zones). Always runs on the server, unscheduled, so deaths at the same time cannot overwrite each other
params ["_uid", "_pos"];
if (!isServer) exitWith {[_uid, _pos] remoteExecCall ["TRGM_fnc_recordPlayerDeath", 2];};

isNil {
	if (isNil "KilledPlayers") then {KilledPlayers = [];};
	if (isNil "KilledPositions") then {KilledPositions = [];};
	KilledPlayers pushBack _uid;
	KilledPositions pushBack [_uid, _pos];
	publicVariable "KilledPlayers";
	publicVariable "KilledPositions";
};
