//flashing red/blue light on a vehicle, runs locally on each client (remoteExec with JIP)
params ["_mainVeh"];
if (!hasInterface) exitWith {};
[_mainVeh] spawn {
	params ["_mainVeh"];
	private _lightleft = "#lightpoint" createVehicleLocal getpos _mainVeh;
	_lightleft setLightColor [255, 0, 0]; //red
	_lightleft setLightBrightness 0.03;
	_lightleft setLightAmbient [0.5,0.5,0.8];
	_lightleft lightAttachObject [_mainVeh, [0, 1, 1]];
	private _leftRed = true;
	while {alive _mainVeh} do {
		_leftRed = !_leftRed;
		_lightleft setLightColor ([[0, 0, 255],[255, 0, 0]] select _leftRed);
		sleep 0.1;
	};
	deleteVehicle _lightleft;
};
