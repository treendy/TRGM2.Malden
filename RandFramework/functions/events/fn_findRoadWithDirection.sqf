//picks a random road within _radius of _pos that has a connected road (up to _attempts tries); returns [_road, _direction] or [] when nothing is found
params ["_pos", ["_radius", 50], ["_attempts", 5]];

private _nearestRoads = _pos nearRoads _radius;
private _result = [];

while {count _result == 0 && _attempts > 0 && count _nearestRoads > 0} do {
	private _road = selectRandom _nearestRoads;
	private _roadConnectedTo = roadsConnectedTo _road;
	if (count _roadConnectedTo > 0) then {
		_result = [_road, [_road, _roadConnectedTo select 0] call BIS_fnc_DirTo];
	}
	else {
		_attempts = _attempts - 1;
	};
};

_result
