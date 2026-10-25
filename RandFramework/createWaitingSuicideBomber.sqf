//Must be set on a road!
_triggerArea = _this select 0;

_triggerSize = 100;

//returns the player unit (on foot) within _radius of _center that is furthest away, or objNull
_fnc_furthestPlayerWithin = {
	params ["_center","_radius"];
	private _furthest = objNull;
	private _furthestDist = -1;
	{
		private _dist = _x distance _center;
		if (isNull objectParent _x && {_dist < _radius && _dist > _furthestDist}) then {
			_furthest = _x;
			_furthestDist = _dist;
		};
	} forEach (switchableUnits + playableUnits);
	_furthest
};

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
	_direction = ([_objMilUnit, _triggerArea] call BIS_fnc_DirTo);
	_objMilUnit setDir _direction;	
	_objMilUnit setFormDir _direction;

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
	_unitPos = _triggerArea;
	while {_bWaiting} do {

		
		if (damage _objMilUnit > 0) then {
			_bWaiting = false; 
		};
		_nearPlayer = [_objMilUnit, 10] call _fnc_furthestPlayerWithin;
		if (!isNull _nearPlayer) then {
			_bWaiting = false;
			_unitPos = getPos _nearPlayer;
		};
		_nearPlayer = [_triggerArea, _triggerSize] call _fnc_furthestPlayerWithin;
		if (!isNull _nearPlayer) then {
			_bWaiting = false;
			_unitPos = getPos _nearPlayer;
		};
	  	if (_bWaiting) then {
			sleep 2;
		}
		else {
			sleep (30 + (random 120));
		};
	};

	//after the wait, get the units pos again and move to it
	_nearPlayer = [_objMilUnit, 10] call _fnc_furthestPlayerWithin;
	if (!isNull _nearPlayer) then {_unitPos = getPos _nearPlayer;};
	_nearPlayer = [_triggerArea, _triggerSize] call _fnc_furthestPlayerWithin;
	if (!isNull _nearPlayer) then {_unitPos = getPos _nearPlayer;};
		
	_objMilUnit setBehaviour "CARELESS";
	_objMilUnit doMove _unitPos;	
	_ambushGroup setSpeedMode "FULL";
	_objMilUnit setUnitPos "UP";

	_BombSet = false;
	_timeOut = time + 180; //give up if he can't reach the target
	while {!_BombSet && time < _timeOut} do {
		if ((_objMilUnit distance _unitPos) < 10 || !alive _objMilUnit) then {
			if (!alive _objMilUnit) then {sleep 2.5};
			_BombSet = true;
			_expl1 setDamage 1;
			_expl2 setDamage 1;
			_expl3 setDamage 1;
			sleep 0.1;
			deleteVehicle _objMilUnit;
		};
		sleep 0.25;
	};

};
