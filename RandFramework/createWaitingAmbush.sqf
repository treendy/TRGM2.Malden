//Must be set on a road!
_triggerArea = _this select 0;

_triggerSize = 100;

_nearestHidingPlaces = nearestTerrainObjects [_triggerArea, ["HIDE","BUSH"], 150];
_HidingPlacesTooClose = nearestTerrainObjects [_triggerArea, ["HIDE","BUSH"], 50];
_nearestHidingPlaces = _nearestHidingPlaces - _HidingPlacesTooClose;

if (count _nearestHidingPlaces > 5) then {
	_ambushGroup = createGroup east;

	_groupSize = selectRandom [5,6,7];
	_iCount = 0;
	while {_iCount < _groupSize} do {
		_iCount = _iCount + 1;
		_objMilUnit = _ambushGroup createUnit [selectRandom[sRiflemanMilitia,sRiflemanMilitia,sRiflemanMilitia,sRiflemanMilitia,sRiflemanMilitia,sRiflemanMilitia,sATManMilitia,sMachineGunManMilitia],getPos (selectRandom _nearestHidingPlaces),[],0,"NONE"];
		doStop _objMilUnit;
		_ambushGroup setCombatMode "BLUE";
		_ambushGroup setBehaviour "SAFE";
		_objMilUnit setUnitPos selectRandom ["MIDDLE","DOWN"];
		_objMilUnit setDir ([_objMilUnit, _triggerArea] call BIS_fnc_DirTo);	
	};

	_bWaiting = true;
	while {_bWaiting} do {

		//loop _ambushGroup members, if player near then set _bWaiting to false		
		{
			if (floor(damage _x) > 0) then {
				_bWaiting = false; 
			};
		  	_nearUnits = nearestObjects [(getPos _x), ["Man"], 10];
		  	{
		  		if (_x in switchableUnits || _x in playableUnits) then {
		  			_bWaiting = false;
		  		};
		  	} forEach _nearUnits;
		} forEach units _ambushGroup;

		_nearUnits = nearestObjects [_triggerArea, ["Man"], _triggerSize];
	  	{
	  		if (_x in switchableUnits || _x in playableUnits) then {
	  			if ( (floor(random 6)) == 1 ) then {
	  				_bWaiting = false;
	  			};
	  		};
	  	} forEach _nearUnits;
	  	if (_bWaiting) then {
			sleep 2;
		};
	};

	{
		_x setCombatMode "RED";
		_x setBehaviour "COMBAT";
		_x setUnitPos "AUTO";
		_x doMove _triggerArea;	
		_ambushGroup setSpeedMode "FULL";
	} forEach units _ambushGroup;

}
