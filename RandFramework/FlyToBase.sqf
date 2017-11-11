_fnc_requestLanding = {
	params ["_group","_vehicle"];
	_text = format ["%1 requesting landing.", groupId _group];
	[_vehicle,_text] remoteExecCall ["sideChat",driver _vehicle,false];
};

_fnc_landingConfirm = {
	params ["_group","_vehicle"];
	_text = format ["%1 you are cleared for landing.", groupId _group];
	[HQMan,_text] remoteExecCall ["sideChat",HQMan,false];
};
params ["_vehicle","_thisMissionNr","_fnc_isMissionCurrent"];
scopeName "FlyToBase";


//hint (format ["triger thisList: %1", count thisList]);

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;

_baseLZPos = _vehicle getVariable "baseLZ";

_heliPad = "Land_HelipadEmpty_F" createVehicle _baseLZPos;

_flyToWaypoint = (group driver _vehicle) addWaypoint [_baseLZPos,0,0];
_flyToWaypoint setWaypointType "MOVE";
_flyToWaypoint setWaypointSpeed "FULL";
_flyToWaypoint setWaypointBehaviour "CARELESS";
_flyToWaypoint setWaypointCombatMode "BLUE";
_flyToWaypoint setWaypointCompletionRadius 100;
_flyToWaypoint setWaypointStatements ["true", "(vehicle this) land 'LAND';"];

hint str(_thisMissionNr);
waitUntil {((_vehicle distance2D _baseLZPos) < 300) || !(_thisMissionNr call _fnc_isMissionCurrent)};
if ( !(_thisMissionNr call _fnc_isMissionCurrent)) then {
	deleteVehicle _heliPad;
	breakOut "FlyToBase";
};

[group driver _vehicle, _vehicle] call _fnc_requestLanding;
sleep 1.5;
[group driver _vehicle, _vehicle] call _fnc_landingConfirm;
setWind [0,0,true]; // prevent stuck helicopter during duststorm 

waitUntil {isTouchingGround _vehicle || {!canMove _vehicle} || !(_thisMissionNr call _fnc_isMissionCurrent)};
if ( !(_thisMissionNr call _fnc_isMissionCurrent)) then {
	breakOut "FlyToBase";
};

deleteVehicle _heliPad;

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;
