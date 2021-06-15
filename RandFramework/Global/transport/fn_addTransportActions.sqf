params [["_vehicles",[]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;


if (!isServer) exitWith {};
{ [_x] spawn TRGM_GLOBAL_fnc_addTransportActionsVehicle; } forEach _vehicles;
[_vehicles] spawn TRGM_GLOBAL_fnc_addTransportActionsPlayer;

true;