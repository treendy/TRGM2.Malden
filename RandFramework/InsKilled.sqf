params  ["_killed","_killer"];

//hint format ["killed: %1 - Killer: %2 - str1: %3 - str2: %4", str(side _killed), str(side _killer),str(_killed),str(_killer)];
//sleep 3;

debugMessages = debugMessages + "\n" + format ["InsKilledTest: KilledSide: %1 - KillerSide: %2 - KilledString: %3 - KillerString: %4",side _killed,side _killer,str(_killed),str(_killer)];
publicVariable "debugMessages";

sleep 3;

if (side _killer == west && str(_killed) != str(_killer)) then {
//if (false) then {
	//hint "IN IF";

	[0.2,format[localize "STR_TRGM2_InsKilled_RebelKilled", name _killer]] execVM "RandFramework\AdjustBadPoints.sqf";

	_nearestunits = nearestObjects [getPos _killed,["Man","Car","Tank"],2000];
	_grpName = createGroup east;
	{
		_isRebel = _x getVariable ["IsRebel", false];
		if (_isRebel) then {
			[_x] joinSilent _grpName;
		};
	} forEach _nearestunits;


	//{[_x] joinSilent _grpName;} forEach units group _killed;

}
else {
	//hint "IN ELSE";
};
