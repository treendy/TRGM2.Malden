format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
//loop here, sleep 5 (doesnt need to be too fast looping!!)
while {true} do {
	if (getPlayerUID player in TRGM_VAR_KilledPlayers && (vehicle player isEqualTo player) && alive(player)) then {
		{
			if (getPlayerUID player isEqualTo _x select 0) then {
				//_forEachIndex
				if (player distance (_x select 1) < TRGM_VAR_KilledZoneRadius) then {
					[(localize "STR_TRGM2_TRGMInitPlayerLocal_WarningArea")] call TRGM_GLOBAL_fnc_notify;
					if (player distance (_x select 1) < TRGM_VAR_KilledZoneInnerRadius) then {
						cutText [localize "STR_TRGM2_TRGMInitPlayerLocal_Transfering","BLACK FADED", 0];
						sleep 1;
						player setPos [(getMarkerPos "respawn_west"), (getMarkerPos "respawn_west_HQ")] select (isNil "respawn_west");
					};
				};
			};
		} forEach TRGM_VAR_KilledPositions;
	};
	sleep 5;
};