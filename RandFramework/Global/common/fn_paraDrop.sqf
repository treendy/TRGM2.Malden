params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {};

_unit allowDamage false;
unassignVehicle _unit;
moveOut _unit;

_chute = createVehicle ["Steerable_Parachute_F", getPosATL _unit, [], 0, "CAN_COLLIDE"];
_chute attachTo [_unit, [0,0,0]];
detach _chute;
_unit moveInDriver _chute;

waitUntil { sleep 1; vehicle _unit != _unit; }; //This should give just barely enough delay so the unit doesn't get hit by the vehicle it's paradroping from.
_unit allowDamage true;