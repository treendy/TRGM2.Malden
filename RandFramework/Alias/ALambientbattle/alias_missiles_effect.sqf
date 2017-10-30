// by ALIAS
// nul = [missiles_object_name] execVM "ALambientbattle\alias_missiles_effect.sqf";

if (!hasInterface) exitWith {};
_miss_object_name = _this select 0;

_al_rocket = "Land_Battery_F" createVehicleLocal getPosATL _miss_object_name;

_sunetr =  ["roc_1","roc_2","roc_3","roc_4"] call BIS_fnc_selectRandom;

if ((player distance _miss_object_name)>100) then {

_li = "#lightpoint" createVehiclelocal (getPos _al_rocket);
_li setLightBrightness 100;
_li setLightAttenuation [/*start*/ 5, /*constant*/0, /*linear*/ 100, /*quadratic*/ 2000, /*hardlimitstart*/200,/* hardlimitend*/500]; 
_li setLightUseFlare true;
_li setLightFlareSize 1;
_li setLightFlareMaxDistance 2000;	
_li setLightAmbient[1,0.7,0];
_li setLightColor[1,1,1];
_li lightAttachObject [_al_rocket, [0,0,-3]];
	
_al_rocket say3d _sunetr;

// Smoke
_ps1 = "#particlesource" createVehicleLocal getpos _al_rocket;
_ps1 setParticleCircle [0, [0, 0, 0]];
_ps1 setParticleRandom [2, [0, 0, 0], [0.2, 0.2, 0.5], 0.3, 0.5, [0, 0, 0, 0.5], 0, 0];
_ps1 setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 2+random 1, [0, 0, 0], [0, 0, 1], 3, 0.01, 0.007, 0, [4,1,7,10], [[1, 1, 1, 1], [0.6, 0.3, 0.2, 1], [0, 0, 0, 0.5], [0, 0, 0, 0]], [0.08], 1, 0, "", "", _al_rocket];
_ps1 setDropInterval 0.002;

_al_rocket setVelocity [0,0,200];
	
sleep 5+random 3;
deleteVehicle _ps1;	
deletevehicle _li;
_al_rocket setPosATL getPosATL _miss_object_name;
};