params ["_AllowedIntelToShow", "_FoundViaType"];

if (side player == FriendlySide) then {
	_IntelToShow = 0;
	_iAttemptCount = 0;
	while {_IntelToShow == 0 && _iAttemptCount < 100} do {
		_iAttemptCount = _iAttemptCount + 1;
		_IntelToShow = selectRandom _AllowedIntelToShow;
		if (_IntelToShow in IntelFound) then {_IntelToShow = 0};
	};




	if (_FoundViaType == "CommsTower") then {
		hint (localize "STR_TRGM2_PickingUpComms");
		sleep 4;
	};


if (_IntelToShow == 0) then { //Nothing found
		hint (localize "STR_TRGM2_showIntel_NoIntel");
	}
	else {
		IntelFound pushBack _IntelToShow; 

	};

	if (_IntelToShow == 1) then { //Mortor team location
		_foundObjs = nearestObjects [ObjectivePossitions select 0,sMortar + sMortarMilitia,3000]; //vehicles exist on every machine, no need to ask the server
		_iCount = count _foundObjs;
		if (_iCount > 0) then {
			{
				_test = createMarker [format["MrkIntelMortor%1",_forEachIndex], getPos _x];  
				_test setMarkerShape "ICON";  
				_test setMarkerType "o_art";  
				_test setMarkerText "Mortar"; 
			} forEach _foundObjs;
			Hint (localize "STR_TRGM2_showIntel_MortarMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_MortarMapNoUpdate");
		};
	};
	if (_IntelToShow == 2) then { //AAA team location
		_foundObjs = nearestObjects [ObjectivePossitions select 0,[sAAAVeh] + [sAAAVehMilitia] + DestroyAAAVeh,3000];
		_iCount = count _foundObjs;
		if (_iCount > 0) then {
			{
				_test = createMarker [format["MrkIntelAAA%1",_forEachIndex], getPos _x];  
				_test setMarkerShape "ICON";  
				_test setMarkerType "o_art";  
				_test setMarkerText (localize "STR_TRGM2_showIntel_AAAMarker");
			} forEach _foundObjs;
			Hint (localize "STR_TRGM2_showIntel_AAAMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_AAAMapNoUpdate");
		};
	};
	if (_IntelToShow == 3) then { //Comms tower location
		if (bHasCommsTower) then {
			_test = createMarker ["CommsIntelAAA1", CommsTowerPos];  
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
			_distanceToCheckPoint = (_x select 0) distance (ObjectivePossitions select 0);
			_checkpointPos = _x select 0;
			if (_distanceToCheckPoint < 1000) then {
				_bFoundcheckpoints = true;
				_test = createMarker [format["MrkIntelCheckpoint%1%2",_checkpointPos select 0, _checkpointPos select 1], _checkpointPos];  
				_test setMarkerShape "ICON";  
				_test setMarkerType "o_inf";  
				_test setMarkerText (localize "STR_TRGM2_setCheckpoint_MarkerText");
			};
		} forEach CheckPointAreas;
		if (_bFoundcheckpoints) then {		
			Hint (localize "STR_TRGM2_showIntel_CheckpointMapUpdated");
		}
		else {
			hint (localize "STR_TRGM2_showIntel_CheckpointMapNoUpdate");
		};

	};
	if (_IntelToShow == 5) then { //AT Mine field
		if (count ATFieldPos == 0) then {
			Hint (localize "STR_TRGM2_showIntel_NoATArea");
		}
		else {
			{
				_test = createMarker [format["ATIntel%1%2",_x select 0,_x select 1], _x];  
				_test setMarkerShape "ICON";  
				_test setMarkerType "mil_warning";  
				_test setMarkerText (localize "STR_TRGM2_showIntel_ATAreaMarker");
				Hint (localize "STR_TRGM2_showIntel_ATArea");
			} forEach ATFieldPos;
		};
	};
};