params["_position","_useAtLocation"]; //_useAtLocation optional, default false
if (isNil "_useAtLocation") then {_useAtLocation = false};

_location = (nearestLocations [ _position, [ "NameVillage", "NameCity","NameCityCapital","NameMarine","Hill"],5000,_position]) select 0; 
_locationName =  text (_location);
_locationPosition = position _location;

_text = "";
if (_position distance2D _locationPosition > 400) then {
	_relDir = _locationPosition getDir _position;
	_text = format ["%1 of %2",[_relDir,true] call TRGM_fnc_directionToText,_locationName];
} else {
	if (_useAtLocation) then {
		_text = format ["at %1",_locationName];
	}	
	else {
		_text = format ["%1",_locationName];
	};
	
};
_text;