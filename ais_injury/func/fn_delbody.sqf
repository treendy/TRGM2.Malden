// by psycho
params ["_body","_delay"];

if (_delay > 0) then {
	sleep (_delay + (random 20));
	deleteVehicle _body;
};