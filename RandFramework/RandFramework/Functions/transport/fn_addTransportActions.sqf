params [["_vehicles",[]]];


if (!isServer) exitWith {};
{ [_x] spawn TREND_fnc_addTransportActionsVehicle; } forEach _vehicles;
[_vehicles] spawn TREND_fnc_addTransportActionsPlayer;

true;