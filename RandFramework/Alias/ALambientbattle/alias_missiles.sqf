// by ALIAS
// nul = [missiles_object_name] execVM "ALambientbattle\alias_missiles.sqf";

if (!isServer) exitWith {};

_main_missiles_object = _this select 0;

al_missile = true;
publicVariable "al_missile";

while {(al_missile) and (!isNull _main_missiles_object)} do {
sleep random 3;
[[[_main_missiles_object],"ALambientbattle\alias_missiles_effect.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;
sleep 4;
};