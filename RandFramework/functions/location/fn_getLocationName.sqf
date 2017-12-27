params[
	"_position",
	["_useAtLocation",false],
	["_distanceConsideredInArea",400]

];

_location = (nearestLocations [ _position, [ "NameVillage", "NameCity","NameCityCapital","NameMarine","Hill"],5000,_position]) select 0; 
_locationName =  text (_location);
_locationPosition = position _location;

_text = "";
if (_position distance2D _locationPosition > _distanceConsideredInArea) then {
	_relDir = _locationPosition getDir _position;
	_text = format ["%1 of %2",[_relDir,true] call TRGM_fnc_directionToText,_locationName];
} else {
	_format =  ["%1","at %1"] select _useAtLocation;
	_text = format [_format,_locationName];
};
_text;