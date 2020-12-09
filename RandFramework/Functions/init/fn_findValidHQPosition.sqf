params[["_player", objNull, [objNull]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (_player != player) exitWith {false;};

private _isAdmin = (!isMultiplayer || isMultiplayer && !isDedicated && isServer || isMultiplayer && !isServer && (call BIS_fnc_admin) != 0);
if (_isAdmin && !TREND_IsAdminPlayerAvailable) then {
	TREND_IsAdminPlayerAvailable =  true; publicVariable "TREND_IsAdminPlayerAvailable";
};

if ((!TREND_IsAdminPlayerAvailable && str player isEqualTo "sl") || (_isAdmin && TREND_IsAdminPlayerAvailable)) then {
	if (!TREND_HQPosFound) then {
		TREND_playerIsChoosingHQpos = true; publicVariable "TREND_playerIsChoosingHQpos";
		TREND_MapClicked = 0; publicVariable "TREND_MapClicked";

		OnMapSingleClick "TREND_ClickedPos = _pos; TREND_MapClicked = 1; publicVariable ""TREND_MapClicked""";
		openMap [true, false];
		hintC (localize "STR_TRGM2_InitClickSomewhere");

		while {true} do {
			if (TREND_MapClicked isEqualTo 1) then { // player has clicked the map
				_foundPickupPos = [TREND_ClickedPos, 0,50,25,0,0.15,0,[],[[0,0,0],[0,0,0]]] call TREND_fnc_findSafePos; // find a valid pos
				_nearRoad = [_foundPickupPos,20] call BIS_fnc_nearestRoad;
				if ((!isNull _nearRoad) || (0 == _foundPickupPos select 0 && 0 == _foundPickupPos select 1) || (TREND_ClickedPos isEqualTo _foundPickupPos)) then {
					// INVALID POS
					TREND_MapClicked = false;
					hintC (localize "STR_TRGM2_InitClickInvalidPos");
				} else {
					// VALID POS - Ask the player if they want to use the pos...
					OnMapSingleClick "TREND_MapClicked = 2; publicVariable ""TREND_MapClicked""";
					hintC (localize "STR_TRGM2_InitClickValidPos");
					_HQPosMarker = createMarker [format ["%1", random 10000], _foundPickupPos];
					_HQPosMarker  setMarkerShape "ICON";
					_HQPosMarker  setMarkerType "hd_dot";
					_HQPosMarker  setMarkerSize [5,5];
					_HQPosMarker  setMarkerColor "ColorGreen";
					_HQPosMarker  setMarkerText "HQ Location";
					waitUntil { (TREND_MapClicked isEqualTo 2 || !visibleMap); };
					deleteMarker _HQPosMarker;
					if (TREND_MapClicked isEqualTo 2) then {
						TREND_MapClicked = 0; publicVariable "TREND_MapClicked";
						OnMapSingleClick "TREND_ClickedPos = _pos; TREND_MapClicked = 1; publicVariable ""TREND_MapClicked""";
					} else {
						onMapSingleClick "";
						openMap [false, false];
						TREND_foundHQPos = _foundPickupPOS;
						publicVariable "TREND_foundHQPos";
						TREND_HQPosFound = true; publicVariable "TREND_HQPosFound";
					};
				};
			};
			sleep 1;
			if (TREND_HQPosFound) exitwith {true;};
			if !(visibleMap) then {openMap [true, false]; hintC (localize "STR_TRGM2_InitClickSomewhere");};
		};
	};
};