//attaches a dim white light to a paramedic (remoteExec'd to every machine with JIP)
params ["_downedCivMedic"];
if (!hasInterface) exitWith {};

private _medicLight = "#lightpoint" createVehicleLocal getpos _downedCivMedic; //local, this runs on every client
_medicLight setLightColor [255, 255, 255];
_medicLight setLightBrightness 0.03;
_medicLight setLightAmbient [0.5,0.5,0.8];
_medicLight lightAttachObject [_downedCivMedic, [0, 1, 1]];
