params ["_killed","_killer"];

if (isNil "CivDeathCount") then {
	CivDeathCount = 0;
	publicVariable "CivDeathCount";
};

_aceSource = _killed getVariable ["ace_medical_lastDamageSource", objNull];
if (!(_aceSource isEqualTo objNull)) then {
	_killer = _aceSource;
};

if (side _killer == west && str(_killed) != str(_killer)) then {
	bCivKilled = true;
	publicVariable "bCivKilled";

	CivDeathCount = CivDeathCount + 1;
	publicVariable "CivDeathCount";

	[0.1,format[localize "STR_TRGM2_CivKilled_Text", name _killer]] execVM "RandFramework\AdjustBadPoints.sqf";
};
