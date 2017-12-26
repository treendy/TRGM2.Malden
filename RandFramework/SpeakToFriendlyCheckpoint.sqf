_thisCheckpointUnit = _this select 0;
_thisPlayer = _this select 1;
_thisArrayParams = _this select 3;

_CheckpointPos = _thisArrayParams select 0;

[_thisCheckpointUnit] remoteExec ["removeAllActions", 0, true];

if (alive _thisCheckpointUnit) then {

	_nearestLocation = [];
	_nearestDistance = 0;
	{	
		//hint format ["test:%1",_x select 0];
		//hint format ["test:%1",_CheckpointPos];
		//sleep 1;
		_distanceToCheckPoint = _x select 0 distance _CheckpointPos;
		if (_distanceToCheckPoint < 1000 && _distanceToCheckPoint > 200) then {
			if (_distanceToCheckPoint < _nearestDistance || _nearestDistance == 0) then {
				_nearestDistance = _distanceToCheckPoint;
				_nearestLocation = _x select 0;
			};
		};
	} forEach CheckPointAreas;
	if (count _nearestLocation > 0) then {
		_test = nil;
		_test = createMarker [format["MrkIntelCheckpoint%1%2",_nearestLocation select 0, _nearestLocation select 1], _nearestLocation];  
		_test setMarkerShape "ICON";  
		_test setMarkerType "o_inf";  
		_test setMarkerText "Checkpoint"; 
		Hint "Take a look at your map.  I will show you the the nearest enemy checkpoint location";
	}
	else {
		hint "We havent any intel of any checkpoints in the area";
	};
	if (bHasCommsTower) then {
		sleep 3;
		hint "also, take a look at your map, this is the possition of a comms tower being used by the enemy";
		_test = nil;
		_test = createMarker ["CommsIntelAAA1", CommsTowerPos];  
		_test setMarkerShape "ICON";  
		_test setMarkerType "mil_destroy";  
		_test setMarkerText "Comms Tower"; 		
	};

}
else {
	hint "He doesnt seem to be saying much at this time";
};



