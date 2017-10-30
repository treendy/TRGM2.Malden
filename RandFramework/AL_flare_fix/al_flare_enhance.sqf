// by ALIAS
// Flare Fix DEMO
// Tutorial: https://www.youtube.com/user/aliascartoons
// [[[_al_flare],"AL_flare_fix\al_flare_enhance.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;

private ["_al_shooter","_al_color_flare","_al_flare_light","_flare_brig","_inter_flare","_int_mic","_al_flare","_type_flares"];

if (!hasInterface) exitWith {};

_al_flare = _this select 0;
//_al_color_flare = [0.25,0.5,0.5];

// you need to list in array bellow the class names for flares you want to alter
	_type_flares = ["F_40mm_White","F_40mm_Red","F_40mm_Yellow","F_40mm_Green"];

if ((typeOf _al_flare) in _type_flares) then {
	
switch (typeOf _al_flare) do {
    case "F_40mm_White": {/* hint "White Flare";*/_al_color_flare = [0.7,0.7,0.8]};
    case "F_40mm_Red": { /*hint "Red Flare";*/_al_color_flare = [0.7,0.15,0.1] };
    case "F_40mm_Yellow": {/* hint "Yellow Flare";*/_al_color_flare = [0.7,0.7,0] };
    case "F_40mm_Green": { /*hint "Green Flare";*/_al_color_flare = [0.2,0.7,0.2] };	
};

//	hint str (_al_flare select 1);

	sleep 3;
	
	_al_flare_light = "#lightpoint" createVehicle getPosATL _al_flare;  
	_al_flare_light setLightAmbient _al_color_flare;  
	_al_flare_light setLightColor _al_color_flare;
	_al_flare_light setLightIntensity al_flare_intensity;
	_al_flare_light setLightUseFlare true;
	_al_flare_light setLightFlareSize 10;
	_al_flare_light setLightFlareMaxDistance 2000;
	_al_flare_light setLightAttenuation [/*start*/ al_flare_range, /*constant*/1, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/50,/* hardlimitend*/al_flare_range-10]; 
	_al_flare_light setLightDayLight true;

	// lumina intermitent 23

	_inter_flare = 0;
	while {_inter_flare<21} do {
		_int_mic = 0.05 + random 0.1;
		sleep _int_mic;
		_flare_brig = al_flare_intensity+random 10;
		_al_flare_light setLightIntensity _flare_brig;
		_inter_flare = _inter_flare + _int_mic;
		_al_flare_light setpos (getPosATL _al_flare);
	};

	_int_mic = 3;

//	hint "scade";

	while {_int_mic>0} do {
		_flare_brig = _flare_brig - 10;
		_al_flare_light setLightIntensity _flare_brig;
		_int_mic = _int_mic-0.03;
		sleep 0.01;
	};
//	hint "DOne";
	deleteVehicle _al_flare_light;
};