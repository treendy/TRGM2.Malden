params [["_vehicles",[]]];


if (!isServer) exitWith {};
{ [_x] spawn TRGM_fnc_addTransportActionsVehicle; } forEach _vehicles;
[_vehicles] spawn TRGM_fnc_addTransportActionsPlayer; 
