params ["_killed","_killer"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (side _killer isEqualTo west && str(_killed) != str(_killer)) then {
	//bCivKilled = true;
	//publicVariable "bCivKilled";

	//CivDeathCount = CivDeathCount + 1;
	//publicVariable "CivDeathCount";

	[0.2,format["Paramedic Killed by %1", name _killer]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
};

true;