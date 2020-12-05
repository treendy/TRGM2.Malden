params ["_AllowedIntelToShow", "_FoundViaType"];

if (side player == west) then {
	_IntelToShow = 0;
	_iAttemptCount = 0;
	while {_IntelToShow == 0 && _iAttemptCount < 100} do {
		_iAttemptCount = _iAttemptCount + 1;
		_IntelToShow = selectRandom _AllowedIntelToShow;
		if (_IntelToShow in TREND_IntelFound) then {_IntelToShow = 0};
	};


	TREND_TempIntelShowPos =  ""; publicVariable "TREND_TempIntelShowPos";


	if (_FoundViaType == "CommsTower") then {
		hint (localize "STR_TRGM2_PickingUpComms");
		sleep 4;
	};



	if (_IntelToShow == 0) then { //Nothing found
		hint (localize "STR_TRGM2_showIntel_NoIntel");
	}
	else {
		TREND_IntelFound pushBack _IntelToShow;
		publicVariable "TREND_IntelFound";
	};

	if (_IntelToShow == 1) then { //Mortor team location
		{
			TREND_TempIntelShowPos = nearestObjects [TREND_ObjectivePossitions select 0,sMortar + sMortarMilitia,3000];
			publicVariable "TREND_TempIntelShowPos";
		} remoteExec ["call", 2];
		waitUntil {typeName TREND_TempIntelShowPos == "ARRAY"};
		_iCount = count TREND_TempIntelShowPos;
		if (_iCount > 0) then {
			{
				_test = nil;
				_test = createMarker [format["MrkIntelMortor%1",_forEachIndex], getPos _x];
				_test setMarkerShape "ICON";
				_test setMarkerType "o_art";
				_test setMarkerText "Mortar";
			} forEach TREND_TempIntelShowPos;
			Hint (localize "STR_TRGM2_showIntel_MortarMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_MortarMapNoUpdate");
		};
	};
	if (_IntelToShow == 2) then { //AAA team location
		{
			TREND_TempIntelShowPos = nearestObjects [TREND_ObjectivePossitions select 0,[sAAAVeh] + [sAAAVehMilitia] + DestroyAAAVeh,3000];
			publicVariable "TREND_TempIntelShowPos";
		} remoteExec ["call", 2];
		waitUntil {typeName TREND_TempIntelShowPos == "ARRAY"};
		_iCount = count TREND_TempIntelShowPos;
		_iStep = 0;
		if (_iCount > 0) then {
			{
				_test = nil;
				_test = createMarker [format["MrkIntelAAA%1",_forEachIndex], getPos _x];
				_test setMarkerShape "ICON";
				_test setMarkerType "o_art";
				_test setMarkerText (localize "STR_TRGM2_showIntel_AAAMarker");
				_iStep = _iStep + 1;
			} forEach TREND_TempIntelShowPos;
			Hint (localize "STR_TRGM2_showIntel_AAAMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_AAAMapNoUpdate");
		};
	};
	if (_IntelToShow == 3) then { //Comms tower location
		if (TREND_bHasCommsTower) then {
			_test = nil;
			_test = createMarker ["CommsIntelAAA1", TREND_CommsTowerPos];
			_test setMarkerShape "ICON";
			_test setMarkerType "mil_destroy";
			_test setMarkerText (localize "STR_TRGM2_showIntel_CommsTowerMarker");
		  Hint (localize "STR_TRGM2_showIntel_CommsTowerMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_CommsTowerMapNoUpdate");
		};
	};
	if (_IntelToShow == 4) then { //All checkpoints
		_bFoundcheckpoints = false;
		{
			_distanceToCheckPoint = (_x select 0) distance (TREND_ObjectivePossitions select 0);
			_checkpointPos = _x select 0;
			if (_distanceToCheckPoint < 1000) then {
				_bFoundcheckpoints = true;
				_test = nil;
				_test = createMarker [format["MrkIntelCheckpoint%1%2",_checkpointPos select 0, _checkpointPos select 1], _checkpointPos];
				_test setMarkerShape "ICON";
				_test setMarkerType "o_inf";
				_test setMarkerText (localize "STR_TRGM2_setCheckpoint_MarkerText");
			};
		} forEach TREND_CheckPointAreas;
		if (_bFoundcheckpoints) then {
			Hint (localize "STR_TRGM2_showIntel_CheckpointMapUpdated");
		}
		else {
			hint (localize "STR_TRGM2_showIntel_CheckpointMapNoUpdate");
		};

	};
	if (_IntelToShow == 5) then { //AT Mine field
		if (count TREND_ATFieldPos == 0) then {
			Hint (localize "STR_TRGM2_showIntel_NoATArea");
		}
		else {
			{
				_test = nil;
				_test = createMarker [format["ATIntel%1%2",_x select 0,_x select 1], _x];
				_test setMarkerShape "ICON";
				_test setMarkerType "mil_warning";
				_test setMarkerText (localize "STR_TRGM2_showIntel_ATAreaMarker");
				Hint (localize "STR_TRGM2_showIntel_ATArea");
			} forEach TREND_ATFieldPos;
		};
	};
};


true;