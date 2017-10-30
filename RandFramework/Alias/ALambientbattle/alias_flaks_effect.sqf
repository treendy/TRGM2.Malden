// by ALIAS
// nul = [_object_name,_zz] execVM "ALambientbattle\alias_flaks.sqf";

if (!hasInterface) exitWith {};

_object_name 	= _this select 0;
//_alt_obj	 	= _this select 1;

_flak_sound = ["bariera_1","bariera_2","bariera_3","bariera_4", "bariera_5"] call BIS_fnc_selectRandom;

_li_aaa = "#lightpoint" createVehicleLocal getPosATL _object_name;
// _li_aaa lightAttachObject [_object_name, [0,0,0.1]];
_li_aaa setLightIntensity 0;
_li_aaa setLightDayLight true;	
_li_aaa setLightUseFlare true;
_li_aaa setLightFlareSize 0;
_li_aaa setLightFlareMaxDistance 2000;	
_li_aaa setLightAmbient[0.9, 0.9, 0.9];
_li_aaa setLightColor[0.9, 0.9, 0.9];

_range_aaa = 600;

_direx	= [(50+random _range_aaa)*-1,(50+random _range_aaa)*1] call BIS_fnc_selectRandom;
_xx 	= (getPosATL _object_name select 0)+_direx;
_direx	= [(50+random _range_aaa)*-1,(50+random _range_aaa)*1] call BIS_fnc_selectRandom;
_yy 	= (getPosATL _object_name select 1)+_direx;
_zz 	= (getPosATL _object_name select 2)+ 700+random 500;
_rel_poz = [_xx, _yy, _zz];
_li_aaa setPosATL _rel_poz;

// _object_name setPosATL _aaa_ini_poz;
	
_fum = "#particlesource" createVehicleLocal getPosATL _li_aaa;
_fum setParticleCircle [0, [0, 0, 0]];
_fum setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
_fum setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, 0], [0, 0, 1], 30, 0.01, 0.007, 0, [5,20,30,40], [[0.6, 0.3, 0.2, 0.5], [0, 0, 0, 0.5], [0, 0, 0, 1], [0, 0, 0, 0]], [0.08], 1, 0, "", "", _li_aaa];
_fum setDropInterval 0.9;

if (_zz<750) then { 
	enableCamShake true;
	addCamShake [0.5, 7, 35];
//	hint str _zz;
};

if (_zz<800) then {
	_li_aaa setLightAttenuation [/*start*/ 1000, /*constant*/100, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/5,/* hardlimitend*/1000];  
	_li_aaa setLightFlareSize 10+random 100;
	_li_aaa setLightIntensity 500+random 500;
};

sleep 0.1+random 0.2;
deleteVehicle _li_aaa;

if (_zz>1000) then {
	_aaa_air_sound  = "land_helipadempty_f" createVehicleLocal _rel_poz;
	_aaa_air_sound say3D _flak_sound;
	sleep 4;
	deleteVehicle _aaa_air_sound;
};
//	enableCamShake false;