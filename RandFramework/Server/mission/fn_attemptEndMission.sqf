format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_bAllowEnd = true;

if (isMultiplayer && (leader (group player)) != player) then {
	[(localize "STR_TRGM2_attemptendmission_Kilo1")] call TRGM_GLOBAL_fnc_notify;
	_bAllowEnd = false;
};

if (_bAllowEnd) then {
	[(localize "STR_TRGM2_attemptendmission_Ending")] call TRGM_GLOBAL_fnc_notify;
	[] spawn TRGM_SERVER_fnc_endMission;
};