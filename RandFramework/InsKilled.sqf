params  ["_killed","_killer"];


debugMessages = debugMessages + "\n" + format ["InsKilledTest: KilledSide: %1 - KillerSide: %2 - KilledString: %3 - KillerString: %4",side _killed,side _killer,str(_killed),str(_killer)];
publicVariable "debugMessages";

sleep 3;

if (side _killer == west && _killed != _killer) then {

	[0.2,format[localize "STR_TRGM2_InsKilled_RebelKilled", name _killer]] execVM "RandFramework\AdjustBadPoints.sqf";

	_rebels = allUnits select {(_x getVariable ["IsRebel", false]) && {side _x != east && _x distance _killed < 2000}};
	if (count _rebels > 0) then {
		_grpName = createGroup east;
		_rebels joinSilent _grpName;
	};


};
