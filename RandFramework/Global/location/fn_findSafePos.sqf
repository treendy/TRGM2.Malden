/******************************************************
The purpose of having a wrapper around BIS_fnc_findSafePos
is to increase the likelihood of a successful safe position.
This script does this by attempting two different methods,
the first is by just calling BIS_fnc_findSafePos, if the return
is NOT equal to the default value, the function returns. However,
if the value is the default value, we use findEmptyPosition to try
and find a position, defaulting to a safe position for a quadbike
since it allows for both most vehicles and units to occupy the space,
but any class or object can be passed after the default pos parameter
to use something else.
******************************************************/

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

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

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

for "_i" from 1 to 3 do {
	private _randomOffset = [random (_maxDistance - _maxDistance / 2), random (_maxDistance - _maxDistance / 2), 0];
	_spawnPosition = (_checkPos vectorAdd _randomOffset) findEmptyPosition [_minDistance, _maxDistance, _object];

	if !(_spawnPosition isEqualTo []) exitWith {};
};

if !(_spawnPosition isEqualTo []) then {
	_returnPosition = _spawnPosition;
};

_returnPosition;