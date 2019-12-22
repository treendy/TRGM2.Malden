/*
	File: fn_findOverwatch.sqf
	Author: Dean "Rocket" Hall

	Description:
	Function which selects a position that provides overwatch
	onto another position.

	Parameter(s):
	_this select 0: the target position (position)
	_this select 1: maximum distance from target in meters (optional)
	_this select 2: minimum distance from target in meters (optional)
	_this select 3: minimum height in relation to target in meters (optional)
	_this select 4: position to start looking from, if different from target pos (optional)
*/
private["_setHeight","_targetPos","_refObj","_maxrange","_minrange","_minheight","_centerPos","_selectedPositions","_result","_attempts","_scan","_checkPos","_height","_dis","_terrainBlocked"];

//Initialize
_setHeight = 	1;
_targetPos = 	_this param [0, objNull];
_targetPos = 	[_targetPos select 0,_targetPos select 1, ((_targetPos select 2) + _setHeight)];
_refObj = 		nearestObject [_targetPos, "All"];
_maxrange = 	_this param [1, 500];
_minrange = 	_this param [2, 100];
_minheight = 	_this param [3, 50];
_centerPos = 	_this param [4, _targetPos];	
_selectedPositions = [];
_result = 		[];
_attempts = 	0;
_scan = 		true;
_result = _targetPos;


while {_scan} do {
	_checkPos = [_centerPos,0,_maxrange,3,0,50,0,[],[]] call BIS_Fnc_findSafePos;
	_height = (_refObj worldtomodel _checkPos) select 2;
	_dis = _checkPos distance _targetPos;
	if ((_height > _minheight) and (_dis > _minrange)) then {
		_terrainBlocked = terrainIntersect [_targetPos,_checkPos];
		if (!_terrainBlocked) then {
			/*
			//Make Marker
			NumR = NumR + 1;
			_markerstr = createMarker[format["markername%1",NumR],_checkPos];
			_markerstr setMarkerShape "ICON";
			_markerstr setMarkerType "DOT";
			_markerstr setMarkerColor "ColorGreen";
			_markerstr setMarkerText format["%1m",round(_height)];
			*/
			_selectedPositions set [count _selectedPositions,_checkPos];
		};
	};
	
	if (_attempts > 300) then {_scan = false};
	if (count _selectedPositions >= 5) then {_scan = false};
	_attempts = _attempts + 1;
};


if (count _selectedPositions > 0) then {
	//Found position(s)
	_result = _selectedPositions select 0;
	_maximum = (_refObj worldtomodel _result) select 2;
	{
		_height = (_refObj worldtomodel _x) select 2;
		if (_height > _maximum) then {
			_result = _x;
			_maximum = _height;
		};
	} forEach _selectedPositions;
};

_result