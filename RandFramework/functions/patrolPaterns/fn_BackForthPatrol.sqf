params ["_sidePos","_distFromCent", "_unitCounts","_IncludTeamLeader","_InsurgentSide"];

_unitCount = selectRandom _unitCounts;
_group = Nil;
_wayX = Nil;
_wayY = Nil;

_wp1Pos = Nil;
_wp1bPos = Nil;
_wp2Pos = Nil;
_wp2bPos = Nil;
_wp3Pos = Nil;
_wp3bPos = Nil;
_wp4Pos = Nil;
_wp4bPos = Nil;
_wp5Pos = Nil;

_group = createGroup _InsurgentSide;
_wayX = (_sidePos select 0);
_wayY = (_sidePos select 1);

_wp1Pos = [ _wayX + _distFromCent, _wayY, 0];
_wp1bPos = [ _wayX, _wayY, 0];
_wp2Pos = [ _wayX, _wayY - _distFromCent, 0];
_wp2bPos = [ _wayX, _wayY, 0];
_wp3Pos = [ _wayX - _distFromCent, _wayY, 0];
_wp3bPos = [ _wayX, _wayY, 0];
_wp4Pos = [ _wayX - _distFromCent, _wayY + _distFromCent, 0];
_wp4bPos = [ _wayX, _wayY, 0];
_wp5Pos = [ _wayX + _distFromCent, _wayY + _distFromCent, 0];

//Adjust waypoints so they are not in water
_iToReduce = 10;
while {surfaceIsWater _wp1Pos} do {
	_wp1Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
	_wp5Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp2Pos} do {
	_wp2Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY - (_distFromCent - _iToReduce), 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp3Pos} do {
	_wp3Pos = [ _wayX - (_distFromCent - _iToReduce), _wayY - (_distFromCent - _iToReduce), 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp4Pos} do {
	_wp4Pos = [ _wayX - (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp1bPos} do {
	_wp1bPos = [ _wayX + (_distFromCent - _iToReduce), _wayY, 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp2bPos} do {
	_wp2bPos = [ _wayX, _wayY - (_distFromCent - _iToReduce), 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp3bPos} do {
	_wp3bPos = [ _wayX - (_distFromCent - _iToReduce), _wayY, 0];
	_iToReduce = _iToReduce + 10;
};
_iToReduce = 10;
while {surfaceIsWater _wp4bPos} do {
	_wp4bPos = [ _wayX, _wayY + (_distFromCent - _iToReduce), 0];
	_iToReduce = _iToReduce + 10;
};

//Spawn in units

_iCount = 0; //_unitCount
while {_iCount <= _unitCount} do
{
	[_wp1Pos select 0,_wp1Pos select 1,_group,_iCount,_IncludTeamLeader] call TRGM_fnc_SpawnPatrolUnit;
	_iCount = _iCount + 1;
};

//add the waypoints (will start at a random one so it doesnt always start at the same pos (mainly for if we have more than one patrol), and cycle through them all)
_iWaypointCount = selectRandom[1,2,3,4,5,6,7,8,9];
_bWaypointsAdded = false;
_iWaypointLoopCount = 1;
while {!_bWaypointsAdded} do {
	if (_iWaypointCount == 1) then {
		_wp1 = _group addWaypoint [_wp1Pos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp1Pos)],_wp1Pos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 2) then {
		_wp1b = _group addWaypoint [_wp1bPos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp1bPos)],_wp1bPos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 3) then {
		_wp2 = _group addWaypoint [_wp2Pos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp2Pos)],_wp2Pos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 4) then {
		_wp2b = _group addWaypoint [_wp2bPos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp2bPos)],_wp2bPos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 5) then {
		_wp3 = _group addWaypoint [_wp3Pos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp3Pos)],_wp3Pos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 6) then {
		_wp3b = _group addWaypoint [_wp3bPos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp3bPos)],_wp3bPos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 7) then {
		_wp4 = _group addWaypoint [_wp4Pos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp4Pos)],_wp4Pos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 8) then {
		_wp4b = _group addWaypoint [_wp4bPos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp4bPos)],_wp4bPos] spawn TRGM_fnc_debugDotMarker;};
	};
	if (_iWaypointCount == 9) then {
		_wp5 = _group addWaypoint [_wp5Pos, 0];
		if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp5Pos)],_wp5Pos] spawn TRGM_fnc_debugDotMarker;};
	};
	_iWaypointCount = _iWaypointCount + 1;
	_iWaypointLoopCount = _iWaypointLoopCount + 1;

	if (_iWaypointLoopCount == 10) then {
		_bWaypointsAdded = true;
	};

	if (_iWaypointCount == 10) then {
		_iWaypointCount = 1;
	};

};
[_group, 0] setWaypointSpeed "LIMITED";
[_group, 0] setWaypointBehaviour "SAFE";
[_group, 1] setWaypointSpeed "LIMITED";
[_group, 1] setWaypointBehaviour "SAFE";
[_group, 8] setWaypointType "CYCLE";
_group setBehaviour "SAFE";