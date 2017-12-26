/* 	Script starting here  */
scopeName "FlyTo";

params [
	"_destinationPosition",
	["_vehicle", objNull]
];

if (!alive _vehicle) then {
	breakOut "FlyTo";
};

// set base LZ for the way back.
if (objNull isEqualTo (_vehicle getVariable ["baseLZ", objNull])) then { 
	// initial setup
	_flyHeight = 20;
	_vehicle flyInHeight _flyHeight;
	_vehicle FlyinheightASL [_flyHeight,_flyHeight,_flyHeight];
	_vehicle enableCopilot true;

	_vehicle setVariable ["baseLZ", position _vehicle, true];
};

//cleanup possible prevoius prevoious
deleteVehicle (_vehicle getVariable ["targetPad", objNull]);
deleteMarker (_vehicle getVariable ["lzMarker",""]);



/** New Tranport Mission starts here **/

// set mission number -> invalidates old instances of this script running.
_thisMissionNr = (_vehicle getVariable ["missionNr",0]) + 1;
_vehicle setVariable ["missionNr", _thisMissionNr, true];

_thisMission = [_vehicle,_thisMissionNr];

_vehicle setVariable ["targetPos",_destinationPosition,true];
_driver = driver _vehicle;

/* Set landing zone map marker */

_markerName = str(cursorObject) + "LZ" + str(_thisMissionNr);

_mrkcustomLZ1 = createMarker [_markerName, _destinationPosition]; 
_mrkcustomLZ1 setMarkerShape "ICON";
_mrkcustomLZ1 setMarkerSize [1,1];
_mrkcustomLZ1 setMarkerColor "colorBLUFOR";
_mrkcustomLZ1 setMarkerType "hd_pickup";
_mrkcustomLZ1 setMarkerText ("LZ " + (groupId group _driver));
_vehicle setVariable ["lzMarker",_mrkcustomLZ1,true];

_heliPad = "Land_HelipadEmpty_F" createVehicle _destinationPosition; // invisible landingpad to specify exact landing position
_vehicle setVariable ["targetPad",_heliPad,true];

{
	deleteWaypoint _x
} foreach waypoints group _driver;
_vehicle setVariable ["landingInProgress",false,true];

/* Set Waypoint,Takeoff */

_flyToLZ = group _driver addWaypoint [_destinationPosition,0,0];
_flyToLZ setWaypointType "MOVE";
_flyToLZ setWaypointSpeed "FULL";
_flyToLZ setWaypointBehaviour "CARELESS";
_flyToLZ setWaypointCombatMode "BLUE";
_flyToLZ setWaypointCompletionRadius 100;
_flyToLZ setWaypointStatements ["true", "(vehicle this) land 'GET IN'; (vehicle this) setVariable [""landingInProgress"",true,true]"];

if (isTouchingGround _vehicle) then {
	_locationText = [position _vehicle,true] call TRGM_fnc_getLocationName;
	_text = format ["%1, you are cleared for takeoff %2.", groupId group _driver,_locationText];
	[_text] call TRGM_fnc_commsHQ;
};

if (isTouchingGround _vehicle) then {
	waitUntil {!isTouchingGround _vehicle || !(_thisMission call TRGM_fnc_checkMissionIdActive)};
	if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
		breakOut "FlyTo";
	};
	sleep 2;

	[_vehicle,"Off we go."] call TRGM_fnc_commsPilotToVehicle;
} else {
	[_vehicle,"Diverting."]call TRGM_fnc_commsPilotToVehicle;
};

/* Landing done **/

waitUntil { ((_vehicle getVariable ["landingInProgress",false]) || !(_thisMission call TRGM_fnc_checkMissionIdActive)); };
if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	_vehicle land "NONE";
	breakOut "FlyTo";
};

waitUntil { (isTouchingGround _vehicle || {!canMove _vehicle} || !(_thisMission call TRGM_fnc_checkMissionIdActive)); };
if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	_vehicle land "NONE";
	breakOut "FlyTo";
};

sleep 2;

/* Post landing,cleanup */
{
	deleteWaypoint _x
} foreach waypoints _driver;

[_vehicle, "We reached our destination. Good Luck out there!"] call TRGM_fnc_commsPilotToVehicle;

sleep 5;

if (!isMultiplayer) then {
	//savegame;
};

/* wait for empty helicopter */

waitUntil { ([_vehicle] call TRGM_fnc_isOnlyBoardCrewOnboard) || !(_thisMission call TRGM_fnc_checkMissionIdActive) }; // helicopter empty except pilot + crew
if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	_vehicle land "NONE";
	breakOut "FlyTo";
};

deleteMarker _mrkcustomLZ1;
if (!isMultiplayer) then {
	//savegame;
};			

sleep 4;


// RADIO :  We're RTB.
_locationText = [position _vehicle,true] call TRGM_fnc_getLocationName;
_text = format ["%1 is entering airspace %2 - We're RTB.", groupId group driver _vehicle, _locationText];
[driver _vehicle,_text] call TRGM_fnc_commsSide;

/* RTB */
[_vehicle,_thisMission] spawn TRGM_fnc_flyToBase;
