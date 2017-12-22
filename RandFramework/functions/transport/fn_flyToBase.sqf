params ["_vehicle","_thisMissionNr"];
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

//hint str(_thisMissionNr);
waitUntil {((_vehicle distance2D _baseLZPos) < 300) || !(_thisMissionNr call TRGM_fnc_checkMissionIdActive)};
if ( !(_thisMissionNr call TRGM_fnc_checkMissionIdActive)) then {
	deleteVehicle _heliPad;
	breakOut "FlyToBase";
};


// Landing Comms
_groupID = groupId group driver _vehicle;
_text = format ["%1 requesting landing.", _groupID];
[driver _vehicle,_text] call TRGM_fnc_commsSide;
sleep 1.5;
_text = format ["%1 you are cleared for landing.", _groupID];
[_text] call TRGM_fnc_commsHQ;

setWind [0,0,true]; // prevent stuck helicopter during duststorm 

waitUntil {isTouchingGround _vehicle || {!canMove _vehicle} || !(_thisMissionNr call TRGM_fnc_checkMissionIdActive)};
if ( !(_thisMissionNr call TRGM_fnc_checkMissionIdActive)) then {
	breakOut "FlyToBase";
};

deleteVehicle _heliPad;

{
	deleteWaypoint _x
} foreach waypoints group driver _vehicle;
