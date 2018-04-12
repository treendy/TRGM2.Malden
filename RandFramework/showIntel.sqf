_AllowedIntelToShow = _this Select 0;
_FoundViaType = _this Select 1;

if (side player == west) then {
	_IntelToShow = 0;
	_iAttemptCount = 0;
	while {_IntelToShow == 0 && _iAttemptCount < 100} do {
		_iAttemptCount = _iAttemptCount + 1;
		_IntelToShow = selectRandom _AllowedIntelToShow;
		if (_IntelToShow in IntelFound) then {_IntelToShow = 0};
	};


	TempIntelShowPos = "";
	publicVariable "TempIntelShowPos";


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
		{
    
			TempIntelShowPos = nearestObjects [ObjectivePossitions select 0,sMortar + sMortarMilitia,3000];
			publicVariable "TempIntelShowPos";
		} remoteExec ["bis_fnc_call", 2];
		waitUntil {typeName TempIntelShowPos == "ARRAY"};
		_iCount = count TempIntelShowPos;
		if (_iCount > 0) then {
			{
				_test = nil;
				_test = createMarker [format["MrkIntelMortor%1",_forEachIndex], getPos _x];  
				_test setMarkerShape "ICON";  
				_test setMarkerType "o_art";  
				_test setMarkerText "Mortar"; 
			} forEach TempIntelShowPos;
			Hint (localize "STR_TRGM2_showIntel_MortarMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_MortarMapNoUpdate");
		};
	};
	if (_IntelToShow == 2) then { //AAA team location
		{
			TempIntelShowPos = nearestObjects [ObjectivePossitions select 0,[sAAAVeh] + [sAAAVehMilitia] + DestroyAAAVeh,3000];
			publicVariable "TempIntelShowPos";
		} remoteExec ["bis_fnc_call", 2];
		waitUntil {typeName TempIntelShowPos == "ARRAY"};
		_iCount = count TempIntelShowPos;
		_iStep = 0;
		if (_iCount > 0) then {
			{
				_test = nil;
				_test = createMarker [format["MrkIntelAAA%1",_forEachIndex], getPos _x];  
				_test setMarkerShape "ICON";  
				_test setMarkerType "o_art";  
				_test setMarkerText (localize "STR_TRGM2_showIntel_AAAMarker");
				_iStep = _iStep + 1;
			} forEach TempIntelShowPos;
			Hint (localize "STR_TRGM2_showIntel_AAAMapUpdated");
		}
		else {
			Hint (localize "STR_TRGM2_showIntel_AAAMapNoUpdate");
		};
	};
	if (_IntelToShow == 3) then { //Comms tower location
		if (bHasCommsTower) then {
			_test = nil;
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
				_test = nil;
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
};