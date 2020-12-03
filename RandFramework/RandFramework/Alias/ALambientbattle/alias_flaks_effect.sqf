// by ALIAS
// [[_main_air_object],"ALambientbattle\alias_flaks_effect.sqf"] remoteExec ["BIS_fnc_execVM"];

if (!hasInterface) exitWith {};

_object_name = _this select 0;

//if (!isNil {player getVariable "flaks_on"}) exitwith {};
//player setVariable ["flaks_on",true,true];

_range_aaa = 600;

_li_aaa = "#lightpoint" createVehicleLocal getPosATL _object_name;
_li_aaa setLightIntensity 0;
_li_aaa setLightDayLight true;	
_li_aaa setLightUseFlare true;
_li_aaa setLightFlareSize 0;
//_li_aaa setLightAttenuation [1000,100,100,0,5,2000];
_li_aaa setLightAttenuation [1000,0,100,0,1,50];
_li_aaa setLightFlareMaxDistance 5000;	
_li_aaa setLightAmbient[0.9, 0.9, 0.9];
_li_aaa setLightColor[0.9, 0.9, 0.9];

/*
_fum = "#particlesource" createVehicleLocal getPosATL _li_aaa;
_fum setParticleCircle [0,[0,0,0]];
_fum setParticleRandom [0.1,[random _range_aaa,random _range_aaa,random 50],[0,0,0],0,0.1,[0,0,0,0],0,0];
_fum setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,2,48,0],"", "Billboard",1,1,[0,0,0],[0,0,-1],0,0.01,0.007,0,[1,20],[[1,1,1,1],[1,1,1,1]],[0.8],0,0, "", "", _li_aaa];
_fum setDropInterval 0.05;
*/
_fum_lung = "#particlesource" createVehicleLocal getPosATL _li_aaa;
_fum_lung setParticleCircle [0, [0, 0, 0]];
_fum_lung setParticleRandom [0.1,[0,0,random 10],[0,0,0],0,0.1,[0,0,0,0],0,0];
_fum_lung setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1, 5, [0,0,0],[0,0,-1], 30, 0.01, 0.007, 0, [5,20,30,40], [[0.6, 0.3, 0.2, 0.5], [0, 0, 0, 0.5], [0, 0, 0, 1], [0, 0, 0, 0]], [0.08], 1, 0, "", "", _li_aaa];
_fum_lung setDropInterval 0.1;

while {al_aaa} do 
{
	_rel_poz= [getPos _object_name,random _range_aaa, random 360] call BIS_fnc_relPos;
	_zz = 150 + random 950;
	_li_aaa setPosATL [_rel_poz select 0, _rel_poz select 1, _zz];
	
	if (_zz<500) then {
		_li_aaa setLightFlareSize random 10;
		_li_aaa setLightIntensity 200+random 100;
	};
	if (_zz>800) then 
	{
		//hint str _zz;
		[_li_aaa] spawn 
		{
			_li_aaa = _this select 0;
			_flak_sound = ["bariera_1","bariera_2","bariera_3","bariera_4", "bariera_5"] call BIS_fnc_selectRandom;
			_li_aaa say3d [_flak_sound,2500];
		};
	};
	sleep 0.1+random 0.2;
	_li_aaa setLightIntensity 0;	
};
deleteVehicle _li_aaa;
deleteVehicle _fum;
deleteVehicle _fum_lung;

