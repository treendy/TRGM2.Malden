params [["_vehicles",[]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;


if (!isServer) exitWith {};
{ [_x] spawn TREND_fnc_addTransportActionsVehicle; } forEach _vehicles;
[_vehicles] spawn TREND_fnc_addTransportActionsPlayer;

true;