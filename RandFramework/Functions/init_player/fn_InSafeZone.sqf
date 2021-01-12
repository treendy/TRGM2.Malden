format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
while {true} do {
	if (getMarkerPos "mrkHQ" distance player < TREND_PunishmentRadius) then {
		//if (!TREND_bDebugMode) then { player allowDamage false};
	}
	else {
		//if (!TREND_bDebugMode) then { player allowDamage true;};
		TREND_PlayersHaveLeftStartingArea =  true; publicVariable "TREND_PlayersHaveLeftStartingArea";
	};
	sleep 1;
};