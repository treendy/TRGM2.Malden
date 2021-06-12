format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
_bAllowEnd = true;

if (isMultiplayer && (leader (group player)) != player) then {
	[(localize "STR_TRGM2_attemptendmission_Kilo1")] call TREND_fnc_notify;
	_bAllowEnd = false;
};

if (_bAllowEnd) then {
	[(localize "STR_TRGM2_attemptendmission_Ending")] call TREND_fnc_notify;
	[] spawn TREND_fnc_endMission;
};