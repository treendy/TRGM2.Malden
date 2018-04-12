//Must be set on a road!
_triggerArea = _this select 0;

_triggerSize = 100;

_nearestHidingPlaces = nearestTerrainObjects [_triggerArea, ["HIDE","BUSH"], 200];
_HidingPlacesTooClose = nearestTerrainObjects [_triggerArea, ["HIDE","BUSH"], 75];
_nearestHidingPlaces = _nearestHidingPlaces - _HidingPlacesTooClose;

if (count _nearestHidingPlaces > 5) then {
	_ambushGroup = createGroup east;

	_objMilUnit = _ambushGroup createUnit [selectRandom sCivilian,getPos (selectRandom _nearestHidingPlaces),[],0,"NONE"];
	doStop _objMilUnit;
	_ambushGroup setCombatMode "BLUE";
	_ambushGroup setBehaviour "SAFE";
	_objMilUnit setUnitPos selectRandom ["MIDDLE","DOWN"];
	_objMilUnit setDir ([_objMilUnit, _triggerArea] call BIS_fnc_DirTo);	

	_expl1 = "DemoCharge_Remote_Ammo" createVehicle position _objMilUnit;
	_expl1 attachTo [_objMilUnit, [-0.1, 0.1, 0.15], "Pelvis"];
	_expl1 setVectorDirAndUp [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ];
	_expl2 = "DemoCharge_Remote_Ammo" createVehicle position _objMilUnit;
	_expl2 attachTo [_objMilUnit, [0, 0.15, 0.15], "Pelvis"];
	_expl2 setVectorDirAndUp [ [1, 0, 0], [0, 1, 0] ];
	_expl3 = "DemoCharge_Remote_Ammo" createVehicle position _objMilUnit;
	_expl3 attachTo [_objMilUnit, [0.1, 0.1, 0.15], "Pelvis"];
	_expl3 setVectorDirAndUp [ [0.5, -0.5, 0], [0.5, 0.5, 0] ]; 

	_bWaiting = true;
	while {_bWaiting} do {

		
		if (floor(damage _objMilUnit) > 0) then {
			_bWaiting = false; 
		};
	  	_nearUnits = nearestObjects [(getPos _objMilUnit), ["Man"], 10];
	  	{
	  		if (_x in switchableUnits || _x in playableUnits) then {
	  			_bWaiting = false;
	  		};
	  	} forEach _nearUnits;
		
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

	
	_objMilUnit setBehaviour "CARELESS";
	_objMilUnit doMove _triggerArea;	
	_ambushGroup setSpeedMode "FULL";
	_objMilUnit setUnitPos "UP";

	_BombSet = false;
	while {!_BombSet} do {
		if ((_objMilUnit distance _triggerArea) < 10 || !alive _objMilUnit) then {
			if (!alive _objMilUnit) then {sleep 2.5};
			_BombSet = true;
			_expl1 setDamage 1;
			_expl2 setDamage 1;
			_expl3 setDamage 1;
			sleep 0.1;
			deleteVehicle _objMilUnit;
		};
	};

};
