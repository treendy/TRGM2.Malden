// by ALIAS
// nul = [tracers_object_name,_color] execVM "ALambientbattle\alias_tracers_effect.sqf";

if (!hasInterface) exitWith {};

private ["_xx","_yy","_zz","_dir"];

_tracer_object_name = _this select 0;
_color_tracer		= _this select 1;

if ((player distance _tracer_object_name)>300) then {

// hint "boi";

_ro = 1;_ve = 1;_bl = 1;

if (_color_tracer=="red") then {_ro = 1;_ve = 0;_bl = 0;};
if (_color_tracer=="green") then {_ro = 0;_ve = 1;_bl = 0;};

_dir=0;
_range_trace= 500;

_li_tracer = "#lightpoint" createVehicleLocal [(getPos _tracer_object_name select 0),getPos _tracer_object_name select 1,(getPos _tracer_object_name select 2)+_range_trace+25];
_li_tracer setLightDayLight true;	
_li_tracer setLightUseFlare true;
_li_tracer setLightFlareSize 0;
_li_tracer setLightFlareMaxDistance 2000;	
_li_tracer setLightAmbient[_ro, _ve, _bl];
_li_tracer setLightColor[_ro, _ve, _bl];

//_dire=0;

while {(al_tracer) and ((player distance _tracer_object_name)>100) and (!isNull _tracer_object_name)} do {
	_li_tracer setLightIntensity 3000+random 500;
	_li_tracer setLightAttenuation [/*start*/ _range_trace, /*constant*/0, /*linear*/ 0, /*quadratic*/ 0, /*hardlimitstart*/_range_trace,_range_trace];  	
	_dir	= [random 180*-1,random 180*1] call BIS_fnc_selectRandom;
	_xx 	= 90+_dir;
	_dir	= [random 180*1,random 180*-1] call BIS_fnc_selectRandom;
	_yy 	= 90+_dir;

	_poc_mic = "#particlesource" createVehicleLocal getpos _tracer_object_name;		
	_poc_mic setParticleCircle [0, [0, 0, 0]];
	_poc_mic setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0,0, 0], 0, 0];
	_poc_mic setParticleParams [["\A3\data_f\cl_exp", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [_xx, _yy, 100], 0, 20, 0, 0, [1,1], [[_ro, _ve,_bl, 1],[_ro, _ve, _bl, 1]], [0.08], 1, 0, "", "",_tracer_object_name];
	_poc_mic setDropInterval 0.05;
	sleep random 1;
	deleteVehicle _poc_mic;
	
	//	sunet
	if (!al_tracers_sunet_play) then {
		_tracer_object_name say3d "ground_air";	
		al_tracers_sunet_play = true;
		publicVariable "al_tracers_sunet_play";
	};
};

};