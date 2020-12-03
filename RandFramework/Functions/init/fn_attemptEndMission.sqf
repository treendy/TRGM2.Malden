_bAllowEnd = true;

if (isMultiplayer && (leader (group player)) != player) then {
	hint (localize "STR_TRGM2_attemptendmission_Kilo1");
	_bAllowEnd = false;
};

if (_bAllowEnd) then {
	//hint (localize "STR_TRGM2_attemptendmission_Ending");
	[] call TREND_fnc_endMission;
};