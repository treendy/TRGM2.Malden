params ["_killed","_killer"];

if (isNil "CivDeathCount") then {
	CivDeathCount = 0;
	publicVariable "CivDeathCount";
};

_killer = [_killed, _killer] call TRGM_fnc_getFriendlyKiller;

if (!isNull _killer) then {
	bCivKilled = true;
	publicVariable "bCivKilled";

	CivDeathCount = CivDeathCount + 1;
	publicVariable "CivDeathCount";

	[0.1,format[localize "STR_TRGM2_CivKilled_Text", name _killer]] call TRGM_fnc_adjustBadPoints;
};
