// by ALIAS
// nul = [tracers_object_name,color] execVM "ALambientbattle\alias_tracers.sqf";

if (!isServer) exitWith {};

_main_tracer_object = _this select 0;
_color = _this select 1;

al_tracer = true;
publicVariable "al_tracer";

al_tracers_sunet_play = false;
publicVariable "al_tracers_sunet_play";	

[] spawn {
while {al_tracer} do {
	sleep 36 + random 2;
	al_tracers_sunet_play = false;
	publicVariable "al_tracers_sunet_play";	
	};
};

// color = "red", "green", "white"
[[[_main_tracer_object,_color],"RandFramework\Alias\ALambientbattle\alias_tracers_effect.sqf"],"BIS_fnc_execVM",true,false] spawn BIS_fnc_MP;