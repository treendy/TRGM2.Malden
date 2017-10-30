// by ALIAS
// nul = [artillery_object_name] execVM "ALambientbattle\alias_artillery.sqf";

if (!isServer) exitWith {};

private ["_xx","_yy","_zz","_dire"];
_main_art_object = _this select 0;

_art_object  = "land_helipadempty_f" createVehicle getpos _main_art_object;

// make variable below false if you want to stop the loop
al_art = true;
publicVariable "al_art";

al_art_sunet_play = false;
publicVariable "al_art_sunet_play";	

[] spawn {
while {al_art} do {
	sleep 35 + random 2;
	al_art_sunet_play = false;
	publicVariable "al_art_sunet_play";	
	};
};
_range_art = 300;
while {(al_art) and (!isNull _main_art_object)} do {
	_dire	= [random _range_art*-1,random _range_art*1] call BIS_fnc_selectRandom;
	_xx 	= (getpos _main_art_object select 0)+_dire;
	_dire	= [random _range_art*-1,random _range_art*1] call BIS_fnc_selectRandom;
	_yy 	= (getpos _main_art_object select 1)+_dire;
	_rel_Pos= [_xx, _yy, 0];
	_art_object setPos _rel_Pos;
[[[_art_object],"RandFramework\Alias\ALambientbattle\alias_art_effect.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;
	sleep random 2;
};	