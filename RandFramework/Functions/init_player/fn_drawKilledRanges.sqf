format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if (getPlayerUID player in TREND_KilledPlayers) then {
	{
		if (getPlayerUID player isEqualTo TREND_KilledPlayers select _forEachIndex) then {
			//draw marker at TREND_KilledPositions select _forEachIndex
			_color = "ColorBlack";
			_mrkPos = createMarkerLocal [format["mrkNoGoA%1",_forEachIndex], _x select 1];
			_mrkPos setMarkerShapeLocal "ELLIPSE";
			_mrkPos setMarkerSizeLocal [TREND_KilledZoneRadius,TREND_KilledZoneRadius];
			_mrkPos setMarkerColorLocal "ColorRed";
			_mrkPos setMarkerAlphaLocal 0.5;

			_mrkPos2 = createMarkerLocal [format["mrkNoGoB%1",_forEachIndex], _x select 1];
			_mrkPos2 setMarkerShapeLocal "ELLIPSE";
			_mrkPos2 setMarkerSizeLocal [TREND_KilledZoneInnerRadius,TREND_KilledZoneInnerRadius];
			_mrkPos2 setMarkerColorLocal _color;
			_mrkPos2 setMarkerAlphaLocal 0.5;
		};

	} forEach TREND_KilledPositions;
};