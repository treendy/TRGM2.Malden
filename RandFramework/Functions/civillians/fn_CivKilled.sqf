params ["_killed","_killer"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_aceSource = _killed getVariable ["ace_medical_lastDamageSource", objNull];
if (!(_aceSource isEqualTo objNull)) then {
	_killer = _aceSource;
};

if (side _killer == west && str(_killed) != str(_killer)) then {
	TREND_bCivKilled =  true; publicVariable "TREND_bCivKilled";

	TREND_CivDeathCount = TREND_CivDeathCount + 1;
	publicVariable "TREND_CivDeathCount";

	[0.1,format[localize "STR_TRGM2_CivKilled_Text", name _killer]] spawn TREND_fnc_AdjustBadPoints;
};

true;