params [
	"_vehicle",
	["_thisMission", nil,[],2]
];
scopeName "FlyToBase";

// if not part of a flying mission create a new one
if (isNil "_thisMission") then {
	_thisMissionNr = (_vehicle getVariable ["missionNr",0]) + 1;
	_vehicle setVariable ["missionNr", _thisMissionNr, true];

	_thisMission = [_vehicle,_thisMissionNr];
};

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;

if ([_vehicle] call TRGM_fnc_helicopterIsFlying) then {
	_locationText = [position _vehicle,true] call TRGM_fnc_getLocationName;
	_text = format [localize "STR_TRGM2_transport_radio_message_RTB",  [_vehicle] call TRGM_fnc_getTransportName];
	[driver _vehicle,_text] call TRGM_fnc_commsSide;
} else {
	_locationText = [position _vehicle,true] call TRGM_fnc_getLocationName;
	_text = format [localize "STR_TRGM2_transport_fnflyToLz_EnterAirspace",  [_vehicle] call TRGM_fnc_getTransportName, _locationText];
	[driver _vehicle,_text] call TRGM_fnc_commsSide;
};


_baseLZPos = _vehicle getVariable "baseLZ";

_heliPad = "Land_HelipadEmpty_F" createVehicle _baseLZPos;

_flyToWaypoint = (group driver _vehicle) addWaypoint [_baseLZPos,0,0];
_flyToWaypoint setWaypointType "MOVE";
_flyToWaypoint setWaypointSpeed "FULL";
_flyToWaypoint setWaypointBehaviour "CARELESS";
_flyToWaypoint setWaypointCombatMode "BLUE";
_flyToWaypoint setWaypointCompletionRadius 100;
_flyToWaypoint setWaypointStatements ["true", "(vehicle this) land 'LAND';"];

if (!isTouchingGround chopper2) then {
	_escortPilot = driver chopper2;
	{
		deleteWaypoint _x
	} foreach waypoints group _escortPilot;
	_escortFlyToWaypoint = (group driver chopper2) addWaypoint [getPos airSupportHeliPad,0,0];
	_escortFlyToWaypoint setWaypointType "MOVE";
	_escortFlyToWaypoint setWaypointSpeed "FULL";
	_escortFlyToWaypoint setWaypointBehaviour "CARELESS";
	_escortFlyToWaypoint setWaypointCombatMode "RED";
	_escortFlyToWaypoint setWaypointCompletionRadius 100;
	_escortFlyToWaypoint setWaypointStatements ["true", "(vehicle this) land 'LAND';"];
};

//hint str(_thisMission);
waitUntil {((_vehicle distance2D _baseLZPos) < 300) || !(_thisMission call TRGM_fnc_checkMissionIdActive)};
if ( !(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	deleteVehicle _heliPad;
	breakOut "FlyToBase";
};


// Landing Comms
if ([_vehicle] call TRGM_fnc_helicopterIsFlying) then  {
	_transportName = [_vehicle] call TRGM_fnc_getTransportName;
	_text = format [localize "STR_TRGM2_transport_fnflyToBase_RequestingLanding", _transportName];
	[driver _vehicle,_text] call TRGM_fnc_commsSide;
	sleep 1.5;
	_text = format [localize "STR_TRGM2_transport_fnflyToBase_ClearLand", _transportName];
	[_text] call TRGM_fnc_commsHQ;
};

setWind [0,0,true]; // prevent stuck helicopter during duststorm

waitUntil {(!([_vehicle] call TRGM_fnc_helicopterIsFlying)) || {!canMove _vehicle} || !(_thisMission call TRGM_fnc_checkMissionIdActive)};
if ( !(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	breakOut "FlyToBase";
};

[_vehicle,localize "STR_TRGM2_transport_fnflyToBase_BackHome"] call TRGM_fnc_commsPilotToVehicle;


deleteVehicle _heliPad;

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;
