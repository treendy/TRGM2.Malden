// by ALIAS
// nul = [aaa_object_name] execVM "ALambientbattle\alias_flaks.sqf";

if (!isServer) exitWith {};

_main_air_object = _this select 0;
if (!isNil {_main_air_object getVariable "is_ON"}) exitwith {};
_main_air_object setVariable ["is_ON",true,true];
// make variable below false if you want to stop the loop and remove AAA effect
al_aaa = true;
publicVariable "al_aaa";

[[_main_air_object],"RandFramework\Alias\ALambientbattle\alias_flaks_effect.sqf"] remoteExec ["execVM",0,true];
