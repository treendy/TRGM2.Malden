params ["_killed","_killer"];

sleep 3;

_killer = [_killed, _killer] call TRGM_fnc_getFriendlyKiller;

if (!isNull _killer) then {

	[0.2,format[localize "STR_TRGM2_InsKilled_RebelKilled", name _killer]] call TRGM_fnc_adjustBadPoints;

	//killing a friendly rebel turns the rebels nearby hostile
	_rebels = allUnits select {(_x getVariable ["IsRebel", false]) && {side _x != east && _x distance _killed < 2000}};
	if (count _rebels > 0) then {
		_grpName = createGroup east;
		_rebels joinSilent _grpName;
	};

};
