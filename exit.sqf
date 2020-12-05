
"Exit.sqf" call TREND_fnc_log;
if (TREND_SaveType != 0) then {
	[TREND_SaveType,false] spawn TREND_fnc_ServerSave;
};


true;