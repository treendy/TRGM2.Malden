//if (isServer) then {

_Pos = _this select 0;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_flareposX = 0;
_flareposY = 0;
_flareposZ = 400;
_flareposX = _Pos select 0;
_flareposY = _Pos select 1;
//(mrkFirstLocation) ModelToWorld [0,100,200]

_flare1 = "F_40mm_white" createvehicle [_flareposX,_flareposY, _flareposZ];
_flare1 setVelocity [0,0,-10];
_al_flare_light = "#lightpoint" createVehicle getPosATL _flare1;

TREND_fnc_SetFlareLightStuff = {
	_al_flare_light = _this select 0;
	_flare1 = _this select 1;
	//[str(_al_flare_light)] call TREND_fnc_notify;
	_al_flare_intensity = 3;
	_al_flare_range = 1000;

	_al_color_flare = [1,1,1];
	_flare_brig = _al_flare_intensity;

	sleep 3;

	_al_flare_light setLightAmbient _al_color_flare;
	_al_flare_light setLightColor _al_color_flare;
	_al_flare_light setLightIntensity _al_flare_intensity;
	_al_flare_light setLightUseFlare true;
	_al_flare_light setLightFlareSize 10;
	_al_flare_light setLightFlareMaxDistance 2000;
	_al_flare_light setLightAttenuation [/*start*/ _al_flare_range, /*constant*/1, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/50,/* hardlimitend*/_al_flare_range-10];
	_al_flare_light setLightDayLight true;

	// lumina intermitent 23

	_inter_flare = 0;
	while {_inter_flare<21} do {
		_int_mic = 0.05 + random 0.1;
		sleep _int_mic;
		_flare_brig = _al_flare_intensity+random 1;
		_al_flare_light setLightIntensity _flare_brig;
		_inter_flare = _inter_flare + _int_mic;
		_al_flare_light setpos (getPosATL _flare1);
	};

	_int_mic = 3;

//	["scade"] call TREND_fnc_notify;

	while {_int_mic>0} do {
		_flare_brig = _flare_brig - 10;
		_al_flare_light setLightIntensity _flare_brig;
		_int_mic = _int_mic-0.03;
		sleep 0.01;
	};
//	["DOne"] call TREND_fnc_notify;
	deleteVehicle _al_flare_light;
};
publicVariable "TREND_fnc_SetFlareLightStuff";


//{[_al_flare_light] spawn TREND_fnc_SetFlareLightStuff;} remoteExec ["call", 0];

[_al_flare_light, _flare1] remoteExec ["TREND_fnc_SetFlareLightStuff", 0];

//};

true;