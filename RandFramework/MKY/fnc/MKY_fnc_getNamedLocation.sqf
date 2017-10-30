
/*
	arguments:
	0 = position to use as center (to search from) (and default return if no match found !!)
	1 = array of string(s) to match on (type of "named location") (ie. ["Hill","NameVillage"])
	2 = 0 random, 1 nearest (default), 2 furthest

	return: named location data in array [name, type, position]

	http://www.ofpec.com/forum/index.php?topic=33978.0
	strategic/strongpointarea/flatarea/flatareacity/flatareacitysmall/citycenter/airport/hill/viewpoint
*/
private ["_intNear","_strNamedLocation","_posCenter","_arType","_arConfigWorldNames","_nameClass","_nameType","_arTypeMatches","_posTest","_intD","_intDx","_posReturn"];

// set defaults
_intNear = 1;
_strNamedLocation = "";
_arTypeMatches = [];

// position to search FROM
_posCenter = _this select 0;

// type of location(s) to search FOR
_arType = _this select 1;

// DISTANCE to search at
if (count _this > 2) then {_intNear = _this select 2};

// all "named locations" for the world
_arConfigWorldNames = configFile >> "CfgWorlds" >> worldName >> "Names";

// counter
if (_intNear == 1) then {_intD = 999999999;} else {_intD = 0;};

// filter for type, append to array
for "_i" from 0 to (count _arConfigWorldNames) - 1 do {
	_nameClass = (_arConfigWorldNames select _i);
	_nameType = getText (_nameClass >> "type");
	if (toLower(_nameType) in _arType) then {
		_arTypeMatches pushBack _nameClass;
	};
};

if (_intNear == 0) then {
	// if no distance preferred, choose random
	_strNamedLocation = [_arTypeMatches] call Zen_ArrayGetRandom;
} else {
	{
		_posTest = (getArray((_x) >> "position"));
		// calculate distance from named location to the search center
		_intDx = _posTest distance _posCenter;
		if (_intNear == 1) then {
			// find "nearest location
			if (_intDx < _intD) then {_intD = _intDx; _strNamedLocation = _x;};
		} else {
			// find furthest location
			if (_intDx > _intD) then {_intD = _intDx; _strNamedLocation = _x;};
		};
	} forEach _arTypeMatches;
};

// return the named location, if there is one
if !(isText _strNamedLocation) then {
	// only return the input position
	_posCenter
} else {
	_arReturn = [];
	_arReturn pushBack getText (_strNamedLocation >> "name");
	_arReturn pushBack getText (_strNamedLocation >> "type");
	_pos = (getArray(_strNamedLocation >> "position"));
	_arReturn pushBack ASLToATL ([(_pos select 0),(_pos select 1),getTerrainHeightASL (_pos)]);
	_arReturn
};

