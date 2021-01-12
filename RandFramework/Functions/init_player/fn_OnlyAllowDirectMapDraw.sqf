format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
while {isMultiplayer && (TREND_AdvancedSettings select TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX == 1)} do {
	{
		//WaitUntil {count allMapMarkers > 0};
		_sTest = _x splitString "/";
		if (count _sTest > 2) then {
			if (str(_sTest select 2) != str("5")) then {
				deleteMarker _x;
			};
		};
	} forEach allMapMarkers;
	sleep 1;
};