params ["_killed","_killer"];

if (isNil "CivDeathCount") then {
	CivDeathCount = 0;
	publicVariable "CivDeathCount";
};

if (side _killer == west && str(_killed) != str(_killer)) then {
	bCivKilled = true;
	publicVariable "bCivKilled";

	CivDeathCount = CivDeathCount + 1;
	publicVariable "CivDeathCount";

	[0.1,format[localize "STR_TRGM2_CivKilled_Text", name _killer]] execVM "RandFramework\AdjustBadPoints.sqf";
};
