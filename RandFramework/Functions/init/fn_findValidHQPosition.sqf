params[["_player", objNull, [objNull]]];

if (_player != player) exitWith {false;};

private _isAdmin = (!isMultiplayer || isMultiplayer && !isDedicated && isServer || isMultiplayer && !isServer && (call BIS_fnc_admin) != 0);
if (_isAdmin && !TREND_IsAdminPlayerAvailable) then {
	TREND_IsAdminPlayerAvailable =  true; publicVariable "TREND_IsAdminPlayerAvailable";
};

if ((!TREND_IsAdminPlayerAvailable && str player == "sl") || (_isAdmin && TREND_IsAdminPlayerAvailable)) then {
	if (!TREND_HQPosFound) then {
		TREND_playerIsChoosingHQpos = true; publicVariable "TREND_playerIsChoosingHQpos";
		TREND_MapClicked = false;

		OnMapSingleClick "TREND_ClickedPos = _pos; TREND_MapClicked = true; publicVariable ""TREND_MapClicked""";
		openMap [true, true];
		titleText[localize "STR_TRGM2_InitClickSomewhere", "PLAIN"];

		while {true} do {
			if (TREND_MapClicked) then { // player has clicked the map
				_foundPickupPos = [TREND_ClickedPos, 0,50,25,0,0.15,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos; // find a valid pos
				_nearRoad = [_foundPickupPos,20] call BIS_fnc_nearestRoad;
				if ((!isNull _nearRoad) || (0 == _foundPickupPos select 0 && 0 == _foundPickupPos select 1)) then {
					// INVALID POS
					TREND_MapClicked = false;
					titleText[localize "STR_TRGM2_InitClickInvalidPos", "PLAIN"];
				} else {
					// VALID POS
					onMapSingleClick "";
					titleText[localize "STR_TRGM2_InitClickValidPos", "PLAIN"];
					openMap [false, false];
					TREND_foundHQPos = _foundPickupPOS;
					publicVariable "TREND_foundHQPos";
					TREND_HQPosFound = true; publicVariable "TREND_HQPosFound";
				};
			};
			sleep 1;
			if (TREND_HQPosFound) exitwith {};
		};
	};
};