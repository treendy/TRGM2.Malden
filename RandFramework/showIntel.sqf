_AllowedIntelToShow = _this Select 0;
_FoundViaType = _this Select 1;


_IntelToShow = 0;
_iAttemptCount = 0;
while {_IntelToShow == 0 && _iAttemptCount < 100} do {
	_iAttemptCount = _iAttemptCount + 1;
	_IntelToShow = selectRandom _AllowedIntelToShow;
	if (_IntelToShow in IntelFound) then {_IntelToShow = 0};
};


if (_FoundViaType == "HackData") then {
	//so here, can set a sleep timer, while sound plays (example, dialup sound when hacking data... or keyboard typeing sound)
};

if (_IntelToShow == 0) then { //Nothing found
	hint "No intel to report";
}
else {
	IntelFound pushBack _IntelToShow; 
};

if (_IntelToShow == 1) then { //Mortor team location
	_iCount = count nearestObjects [ObjectivePossitions select 0,sMortar + sMortarFriendInsurg,3000];
	if (_iCount > 0) then {
		{
			_test = nil;
			_test = createMarker [format["MrkIntelMortor%1",_forEachIndex], getPos _x];  
			_test setMarkerShape "ICON";  
			_test setMarkerType "o_art";  
			_test setMarkerText "Mortar"; 
		} forEach nearestObjects [ObjectivePossitions select 0,sMortar + sMortarFriendInsurg,3000];
		Hint "Map updated with enemy mortar possitions (if any 3k within main AO)";
	}
	else {
		Hint "Intel confirms no mortar threat within 3k of main AO";
	};
};
if (_IntelToShow == 2) then { //AAA team location
	_iCount = count nearestObjects [ObjectivePossitions select 0,[sAAAVeh] + [sAAAVehFriendInsurg],3000];
	if (_iCount > 0) then {
		{
			_test = nil;
			_test = createMarker [format["MrkIntelAAA%1",_forEachIndex], getPos _x];  
			_test setMarkerShape "ICON";  
			_test setMarkerType "o_art";  
			_test setMarkerText "AAA"; 
		} forEach nearestObjects [ObjectivePossitions select 0,[sAAAVeh] + [sAAAVehFriendInsurg],3000];
		Hint "Map updated with any enemy AAA possitions (if any 3k within main AO)";
	}
	else {
		Hint "Intel confirms no AAA threat within 3k of main AO";
	};
};
if (_IntelToShow == 3) then { //Comms tower location
	if (bHasCommsTower) then {
		_test = nil;
		_test = createMarker ["CommsIntelAAA1", CommsTowerPos];  
		_test setMarkerShape "ICON";  
		_test setMarkerType "mil_destroy";  
		_test setMarkerText "Comms Tower"; 		
		Hint "Map updated with any enemy comms tower possitions (if any 3k within main AO)";
	}
	else {
		Hint "Enemy are not using any nearby comms towers!";
	};
};
if (_IntelToShow == 4) then { //All checkpoints
	_nearestLocation = [];
	_nearestDistance = 0;
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
			_test setMarkerText "Checkpoint";
		};
	} forEach CheckPointAreas;
	if (_bFoundcheckpoints) then {		
		Hint "Take a look at your map.  location of enemy checkpoints that are within one click of the main AO have been marked";
	}
	else {
		hint "We havent any intel of any checkpoints within a click of the main AO";
	};

};