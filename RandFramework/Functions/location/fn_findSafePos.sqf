params [
	["_checkPos",[]],
	["_minDistance",0],
	["_maxDistance",-1],
	["_objectProximity",0],
	["_waterMode",0],
	["_maxGradient",0],
	["_shoreMode",0],
	["_posBlacklist",[]],
	["_defaultPos",[]],
	["_object", "C_Quadbike_01_F", [objNull, ""]]
];

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

switch (typeName _object) do {
    case ("OBJECT") : {_object = typeOf _object};
};

private _returnPosition = [_checkPos, _minDistance, _maxDistance, _objectProximity, _waterMode, _maxGradient, _shoreMode, _posBlacklist, _defaultPos] call BIS_fnc_findSafePos;

_defaultPos = _defaultPos param [_waterMode, []];
if !(_returnPosition isEqualTo _defaultPos) exitWith {
	_returnPosition;
};

_returnPosition = _checkPos;
private _spawnPosition = [];
private _radius = _maxDistance max 25;

for "_i" from 1 to 3 do {
	private _randomOffset = [random (_radius - _radius / 2), random (_radius - _radius / 2), 0];
	_spawnPosition = (_checkPos vectorAdd _randomOffset) findEmptyPosition [0, (_radius / 2), _object];

	if !(_spawnPosition isEqualTo []) exitWith {};
};

if !(_spawnPosition isEqualTo []) then {
	_returnPosition = _spawnPosition;
};

_returnPosition;