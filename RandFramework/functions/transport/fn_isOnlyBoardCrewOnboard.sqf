params ["_vehicle"];
_boardCrew = group driver _vehicle;
{ 
	alive _x && group _x != _boardCrew;
} count (crew _vehicle) == 0;