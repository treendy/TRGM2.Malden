/*
 * Spawns a patrol group that cycles through 9 waypoints placed at _offsets * _distFromCent around _sidePos.
 * Used by TRGM_fnc_RadiusPatrol and TRGM_fnc_BackForthPatrol.
 * _offsets: 9 x [xMultiplier, yMultiplier]
 * _spawnAtFirstWaypoint: true = units spawn at waypoint 1, false = at _sidePos
 */
params ["_sidePos","_distFromCent","_unitCounts","_IncludTeamLeader","_InsurgentSide","_offsets",["_spawnAtFirstWaypoint",false]];

private _unitCount = selectRandom _unitCounts;
private _group = createGroup _InsurgentSide;
private _wayX = (_sidePos select 0);
private _wayY = (_sidePos select 1);

//Work out waypoints, pulling any that are in water back towards the center (10m at a time)
private _wpPositions = _offsets apply {
	_x params ["_xMul","_yMul"];
	private _dist = _distFromCent;
	private _pos = [_wayX + (_xMul * _dist), _wayY + (_yMul * _dist), 0];
	while {surfaceIsWater _pos && _dist > 0} do {
		_dist = _dist - 10;
		_pos = [_wayX + (_xMul * _dist), _wayY + (_yMul * _dist), 0];
	};
	_pos
};

//Spawn in units
private _spawnPos = [[_wayX,_wayY],(_wpPositions select 0)] select _spawnAtFirstWaypoint;
for "_iCount" from 0 to _unitCount do {
	[_spawnPos select 0,_spawnPos select 1,_group,_iCount,_IncludTeamLeader] call TRGM_fnc_SpawnPatrolUnit;
};

//add the waypoints (will start at a random one so it doesnt always start at the same pos (mainly for if we have more than one patrol), and cycle through them all)
private _wpCount = count _wpPositions;
private _iStartIndex = floor random _wpCount;
for "_i" from 0 to (_wpCount - 1) do {
	private _iWaypointIndex = (_iStartIndex + _i) mod _wpCount;
	private _wpPos = _wpPositions select _iWaypointIndex;
	_group addWaypoint [_wpPos, 0];
	if (bDebugging) then {[format["(%1 - %2)",_iWaypointIndex + 1, str(_wpPos)],_wpPos] spawn TRGM_fnc_debugDotMarker;};
};
[_group, 0] setWaypointSpeed "LIMITED";
[_group, 0] setWaypointBehaviour "SAFE";
[_group, 1] setWaypointSpeed "LIMITED";
[_group, 1] setWaypointBehaviour "SAFE";
[_group, _wpCount - 1] setWaypointType "CYCLE";
_group setBehaviour "SAFE";
