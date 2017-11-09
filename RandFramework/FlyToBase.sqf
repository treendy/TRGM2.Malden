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


params ["_vehicle"];

//hint (format ["triger thisList: %1", count thisList]);

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;

_baseLZPos = _vehicle getVariable "baseLZ";

_flyToLZ2 = (group driver _vehicle) addWaypoint [_baseLZPos,0,0];
_flyToLZ2 setWaypointType "MOVE";
_flyToLZ2 setWaypointSpeed "FULL";
_flyToLZ2 setWaypointBehaviour "CARELESS";
_flyToLZ2 setWaypointCombatMode "BLUE";
_flyToLZ2 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];

//hint "Returning to base";
waitUntil {_vehicle distance2D heliPad1 < 300;};

[group driver _vehicle, _vehicle] call _fnc_requestLanding;
sleep 1.5;
[group driver _vehicle, _vehicle] call _fnc_landingConfirm;

setWind [0,0,true]; // prevent stuck helicopter during duststorm 

waitUntil {isTouchingGround _vehicle || {!canMove _vehicle}};

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;
