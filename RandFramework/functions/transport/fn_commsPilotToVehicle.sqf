params ["_vehicle","_text"];

_playersInVehicle = [];
{
	if (isPlayer _x) then {
		_playersInVehicle pushBack _x;
	}
} forEach crew _vehicle;

[_vehicle,_text] remoteExecCall ["vehicleChat",_playersInVehicle ,false];
