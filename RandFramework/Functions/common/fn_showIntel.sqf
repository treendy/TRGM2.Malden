params ["_AllowedIntelToShow", "_FoundViaType"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (side player isEqualTo west) then {
	_IntelToShow = 0;
	_iAttemptCount = 0;
	while {_IntelToShow isEqualTo 0 && _iAttemptCount < 100} do {
		_iAttemptCount = _iAttemptCount + 1;
		_IntelToShow = selectRandom _AllowedIntelToShow;
		if (_IntelToShow in TREND_IntelFound) then {_IntelToShow = 0};
	};


	TREND_TempIntelShowPos =  ""; publicVariable "TREND_TempIntelShowPos";


	if (_FoundViaType isEqualTo "CommsTower") then {
		[(localize "STR_TRGM2_PickingUpComms")] call TREND_fnc_notify;
		sleep 4;
	};



	if (_IntelToShow isEqualTo 0) then { //Nothing found
		[(localize "STR_TRGM2_showIntel_NoIntel")] call TREND_fnc_notify;
	}
	else {
		TREND_IntelFound pushBack _IntelToShow;
		publicVariable "TREND_IntelFound";
	};

	if (_IntelToShow isEqualTo 1) then { //Mortor team location
		{
			TREND_TempIntelShowPos = nearestObjects [TREND_ObjectivePossitions select 0,(call sMortar) + (call sMortarMilitia),3000];
			publicVariable "TREND_TempIntelShowPos";
		} remoteExec ["call", 2];
		waitUntil {sleep 2; typeName TREND_TempIntelShowPos isEqualTo "ARRAY"};
		_iCount = count TREND_TempIntelShowPos;
		if (_iCount > 0) then {
			{
				_test = nil;
				_test = createMarker [format["MrkIntelMortor%1",_forEachIndex], getPos _x];
				_test setMarkerShape "ICON";
				_test setMarkerType "o_art";
				_test setMarkerText "Mortar";
			} forEach TREND_TempIntelShowPos;
			[(localize "STR_TRGM2_showIntel_MortarMapUpdated")] call TREND_fnc_notify;
		}
		else {
			[(localize "STR_TRGM2_showIntel_MortarMapNoUpdate")] call TREND_fnc_notify;
		};
	};
	if (_IntelToShow isEqualTo 2) then { //AAA team location
		{
			TREND_TempIntelShowPos = nearestObjects [TREND_ObjectivePossitions select 0,[(call sAAAVeh)] + [(call sAAAVehMilitia)] + (call DestroyAAAVeh),3000];
			publicVariable "TREND_TempIntelShowPos";
		} remoteExec ["call", 2];
		waitUntil {sleep 2; typeName TREND_TempIntelShowPos isEqualTo "ARRAY"};
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
			[(localize "STR_TRGM2_showIntel_AAAMapUpdated")] call TREND_fnc_notify;
		}
		else {
			[(localize "STR_TRGM2_showIntel_AAAMapNoUpdate")] call TREND_fnc_notify;
		};
	};
	if (_IntelToShow isEqualTo 3) then { //Comms tower location
		if (TREND_bHasCommsTower) then {
			_test = nil;
			_test = createMarker ["CommsIntelAAA1", TREND_CommsTowerPos];
			_test setMarkerShape "ICON";
			_test setMarkerType "mil_destroy";
			_test setMarkerText (localize "STR_TRGM2_showIntel_CommsTowerMarker");
		  [(localize "STR_TRGM2_showIntel_CommsTowerMapUpdated")] call TREND_fnc_notify;
		}
		else {
			[(localize "STR_TRGM2_showIntel_CommsTowerMapNoUpdate")] call TREND_fnc_notify;
		};
	};
	if (_IntelToShow isEqualTo 4) then { //All checkpoints
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
			[(localize "STR_TRGM2_showIntel_CheckpointMapUpdated")] call TREND_fnc_notify;
		}
		else {
			[(localize "STR_TRGM2_showIntel_CheckpointMapNoUpdate")] call TREND_fnc_notify;
		};

	};
	if (_IntelToShow isEqualTo 5) then { //AT Mine field
		if (count TREND_ATFieldPos isEqualTo 0) then {
			[(localize "STR_TRGM2_showIntel_NoATArea")] call TREND_fnc_notify;
		}
		else {
			{
				_test = nil;
				_test = createMarker [format["ATIntel%1%2",_x select 0,_x select 1], _x];
				_test setMarkerShape "ICON";
				_test setMarkerType "mil_warning";
				_test setMarkerText (localize "STR_TRGM2_showIntel_ATAreaMarker");
				[(localize "STR_TRGM2_showIntel_ATArea")] call TREND_fnc_notify;
			} forEach TREND_ATFieldPos;
		};
	};
};


true;