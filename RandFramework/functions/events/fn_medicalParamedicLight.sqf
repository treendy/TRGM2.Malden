//attaches a dim white light to a paramedic (remoteExec'd to every machine with JIP)
params ["_downedCivMedic"];
if (!hasInterface || !alive _downedCivMedic) exitWith {};

private _medicLight = "#lightpoint" createVehicleLocal getpos _downedCivMedic; //local, this runs on every client
_medicLight setLightColor [255, 255, 255];
_medicLight setLightBrightness 0.03;
_medicLight setLightAmbient [0.5,0.5,0.8];
_medicLight lightAttachObject [_downedCivMedic, [0, 1, 1]];

//remove the light when the medic dies
[_medicLight, _downedCivMedic] spawn {
	params ["_medicLight", "_downedCivMedic"];
	waitUntil {sleep 2; !alive _downedCivMedic};
	deleteVehicle _medicLight;
};
