params ["_sidePos","_distFromCent", "_unitCounts","_IncludTeamLeader","_InsurgentSide","_buildingCount"];


_unitCount = selectRandom _unitCounts;
_group = Nil;
_wayX = Nil;
_wayY = Nil;
_group = createGroup _InsurgentSide;


_flatPos = nil;
_flatPos = [_sidePos , 100, _distFromCent, 4, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
_wayX = (_flatPos select 0);
_wayY = (_flatPos select 1);

_allBuildings = nil;
_allBuildings = nearestObjects [_sidePos, BasicBuildings, _distFromCent];

//Spawn in units
_iCount = 0; //_unitCount
while {_iCount <= _unitCount} do
{
	[_wayX,_wayY,_group,_iCount,_IncludTeamLeader] call TRGM_fnc_SpawnPatrolUnit;
	_iCount = _iCount + 1;
};

//set waypoints to other buildings
_iCountWaypoints = 0;
while {_iCountWaypoints <= _buildingCount} do
{
	_randBuilding2 = selectRandom _allBuildings; //pick one building from our buildings array
	_allBuildingPos2 = _randBuilding2 buildingPos -1;

	_wpSideBuildingPatrol = nil;
	try {
		_wayPosInit = selectRandom _allBuildingPos2;
		if (!isNil "_wayPosInit") then {
			_wpSideBuildingPatrol = _group addWaypoint [_wayPosInit, 0]; //This line has error "0 eleemnts provided, 3 expected"
		}

	}
	catch {
		hint format ["Script issue: %1",selectRandom _allBuildingPos2];
	};
	//_wp1 = _group addWaypoint [_wp1Pos, 0];

	[_group, _iCountWaypoints] setWaypointSpeed "LIMITED";
	[_group, _iCountWaypoints] setWaypointBehaviour "SAFE";
	if (_iCountWaypoints == _buildingCount) then{[_group, 8] setWaypointType "CYCLE";};
	_iCountWaypoints = _iCountWaypoints + 1;
};
_group setBehaviour "SAFE";