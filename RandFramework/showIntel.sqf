_IntelToShow = _this Select 0;
_FoundViaType = _this Select 1;


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
			_test setMarkerText "Mortar"; 
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
}