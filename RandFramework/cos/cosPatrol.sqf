private ["_waypoints","_findWps"];
_grpArray=(_this select 0);
_grpArrayTwo=(_this select 1);
_waypoints=(_this select 2);

_findWps = 4 +round(random 3);
if (count _waypoints < _findWps) then {_findWps=count _waypoints;};	

		{

_group=_x;
_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";	

	_EHkilledIdx = (leader _group) addEventHandler ["FiredNear", {_this call breakPatrol_FNC;}];
	
_shuffleWaypoints=_waypoints call BIS_fnc_arrayShuffle;	
	for "_i" from 0 to _findWps do {
		_wp=_shuffleWaypoints select _i;
		_wp = _group addWaypoint [_wp, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 10;
		[_group,_i] setWaypointTimeout [0,2,4];
					};
					
	_wp1 = _group addWaypoint [_shuffleWaypoints select 0, 0];
	_wp1 setWaypointType "CYCLE";
	_wp1 setWaypointCompletionRadius 10;

		}foreach _grpArrayTwo+_grpArray;
