format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
//loop here, sleep 5 (doesnt need to be too fast looping!!)
while {true} do {
	if (getPlayerUID player in TREND_KilledPlayers && (vehicle player == player) && alive(player)) then {
		{
			if (getPlayerUID player == _x select 0) then {
				//_forEachIndex
				if (player distance (_x select 1) < TREND_KilledZoneRadius) then {
					[(localize "STR_TRGM2_TRGMInitPlayerLocal_WarningArea")] call TREND_fnc_notify;
					if (player distance (_x select 1) < TREND_KilledZoneInnerRadius) then {
						cutText [localize "STR_TRGM2_TRGMInitPlayerLocal_Transfering","BLACK FADED", 0];
						sleep 1;
						player setPos [(getMarkerPos "respawn_west"), (getMarkerPos "respawn_west_HQ")] select (isNil "respawn_west");
					};
				};
			};
		} forEach TREND_KilledPositions;
	};
	sleep 5;
};