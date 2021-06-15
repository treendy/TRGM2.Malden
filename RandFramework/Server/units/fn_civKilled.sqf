params ["_killed","_killer"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

_aceSource = _killed getVariable ["ace_medical_lastDamageSource", objNull];
if (!(_aceSource isEqualTo objNull)) then {
	_killer = _aceSource;
};

if (side _killer isEqualTo west && str(_killed) != str(_killer)) then {
	TRGM_VAR_bCivKilled =  true; publicVariable "TRGM_VAR_bCivKilled";

	TRGM_VAR_CivDeathCount = TRGM_VAR_CivDeathCount + 1;
	publicVariable "TRGM_VAR_CivDeathCount";

	[0.1,format[localize "STR_TRGM2_CivKilled_Text", name _killer]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
};

true;