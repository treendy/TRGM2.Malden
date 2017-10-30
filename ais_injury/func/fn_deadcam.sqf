// by psycho
private ["_pos","_deadcam"];
if (!isDedicated && {!hasInterface}) exitWith {};
params ["_victim","_killer"];

_pos = [(getPosATL _victim select 0)-(vectorDir _victim select 0)*3,(getPosATL _victim select 1)-(vectorDir _victim select 1)*3,(getPosATL _victim select 2)+1];
titleCut ["","BLACK IN",1];

_deadcam = "Camera" camCreate (position _victim);
_deadcam cameraEffect ["internal","back"];
showCinemaBorder true;
_deadcam camPrepareTarget _victim;
_deadcam camPreparePos _pos;
_deadcam camPrepareFOV 0.7;
_deadcam camCommitPrepared 0;

_quote = tcb_ais_killcam_quotes select (floor (random (count tcb_ais_killcam_quotes)));
_handle = [_quote select 0, _quote select 1, ((missionNameSpace getVariable "tcb_ais_respawndelay") - 1)] spawn tcb_fnc_quote;
waitUntil {camCommitted _deadcam};

if ((_killer == player) or (!alive _killer) or (isNull _killer)) then {
	_deadcam camPrepareTarget _victim;
	_deadcam camsetrelpos [-3, 20, 10];
	_deadcam camPrepareFOV 0.474;
	_deadcam camCommitPrepared 20;
	waitUntil {alive player};
	player cameraEffect ["terminate","back"];
	camDestroy _deadcam;
} else {
	sleep 1;
	_deadcam camCommand "inertia on";
	_deadcam camPrepareTarget (vehicle _killer);
	_deadcam camsetrelpos [-3, 20, 10];
	_deadcam camPrepareFOV 1;
	_deadcam camCommitPrepared 10;
	waitUntil {alive player};
	showCinemaBorder false;
	player cameraEffect ["terminate","back"];
	camDestroy _deadcam;
};