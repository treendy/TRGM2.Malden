params ["_triggerArea",["_nearestAmbush", 50],["_furthestAmbush",150]];


_bAllowAmbush = true;
if (!isNil "AOCampPos") then {
	if (_triggerArea distance AOCampPos < 300) then {
		_bAllowAmbush = false;
	};
};


if (_bAllowAmbush) then {
	_triggerSize = 100;

	_nearestHidingPlaces = nearestTerrainObjects [_triggerArea, ["HIDE","BUSH"], _furthestAmbush];
	_HidingPlacesTooClose = nearestTerrainObjects [_triggerArea, ["HIDE","BUSH"], _nearestAmbush];
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
			_objMilUnit setUnitPos selectRandom ["MIDDLE","DOWN","DOWN","DOWN"];
			_objMilUnit setDir ([_objMilUnit, _triggerArea] call BIS_fnc_DirTo);	
			_objMilUnit setVariable ["ambushUnit", true];
		};

		_bWaiting = true;
		while {_bWaiting} do {

			//loop _ambushGroup members, if one is hurt or a player (on foot) is near then set _bWaiting to false
			{
				if (damage _x > 0) then {
					_bWaiting = false; 
				};
				_ambushUnit = _x;
				if (((switchableUnits + playableUnits) findIf {isNull objectParent _x && {_x distance _ambushUnit < 10}}) > -1) then {
					_bWaiting = false;
				};
			} forEach units _ambushGroup;

			if (((switchableUnits + playableUnits) findIf {isNull objectParent _x && {_x distance _triggerArea < _triggerSize}}) > -1) then {
				_bWaiting = false;
			};
		  	if (_bWaiting) then {
				sleep 2;
			}
			else {
				sleep (30 + (random 120));
			};
		};

		{
			_x setCombatMode "RED";
			_x setBehaviour "AWARE";
			_x setUnitPos "AUTO";
			_x doMove _triggerArea;	
			_ambushGroup setSpeedMode "FULL";
		} forEach units _ambushGroup;

	};
};