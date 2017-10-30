// by ALIAS
// nul = [aaa_object_name] execVM "ALambientbattle\alias_flaks.sqf";

if (!isServer) exitWith {};

_main_air_object = _this select 0;

_aaa_ini_poz = getPosATL _main_air_object;

_aaa_air_object  = "land_helipadempty_f" createVehicle getpos _main_air_object;

// make variable below false if you want to stop the loop
al_aaa = true;
publicVariable "al_aaa";

while {al_aaa} do {
	[[[_main_air_object],"RandFramework\Alias\ALambientbattle\alias_flaks_effect.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;
	sleep 0.1;
};