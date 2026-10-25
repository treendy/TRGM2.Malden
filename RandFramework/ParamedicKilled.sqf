params ["_killed","_killer"];

_killer = [_killed, _killer] call TRGM_fnc_getFriendlyKiller;

if (!isNull _killer) then {
	[0.2,format["Paramedic Killed by %1", name _killer]] call TRGM_fnc_adjustBadPoints;
};
