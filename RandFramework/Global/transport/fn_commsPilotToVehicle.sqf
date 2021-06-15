params ["_vehicle","_text"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

_playersInVehicle = [];
{
    if (isPlayer _x) then {
        _playersInVehicle pushBack _x;
    }
} forEach crew _vehicle;

[_vehicle,_text] remoteExecCall ["vehicleChat",_playersInVehicle ,false];

true;