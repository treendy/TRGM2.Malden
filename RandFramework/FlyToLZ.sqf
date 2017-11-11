_fnc_dirToText = {
	params [
			["_direction",-1,[0]],  // direction 0 to 360
			["_words",false,[false]] // use word style instead of acronyms
		];

	if (_direction < 0 ||_direction > 360) then {
		"";
	};
	
	_val = round(_direction/45);
	if (_words) then {
		switch(_val) do {
			case 8;
			case 0: {"North"};
			case 1: {"North East"};
			case 2: {"East"};
			case 3: {"South East"};
			case 4: {"South"};
			case 5: {"South West"};
			case 6: {"West"};
			case 7: {"North West"};
		};
	} else {
		switch(_val) do {
			case 8;
			case 0: {"N"};
			case 1: {"NE"};
			case 2: {"E"};
			case 3: {"SE"};
			case 4: {"S"};
			case 5: {"SW"};
			case 6: {"W"};
			case 7: {"NW"};
		};
	};
};

_fnc_getLocationName = {
	params["_position"];

	_location = (nearestLocations [ _position, [ "NameVillage", "NameCity","NameCityCapital","NameMarine","Hill"],5000,_position]) select 0; 
	_locationName =  text (_location);
	_locationPosition = position _location;

	_text = "";
	if (_position distance2D _locationPosition > 1000) then {
		_relDir = _locationPosition getDir _position;
		_text = format ["%1 of %2",[_relDir,true] call _fnc_dirToText,_locationName];
	} else {
		_text = format ["at %1",_locationName];
	};
	_text;
};

_fnc_callOutLiftoffAtLZ = {
	params ["_group","_vehicle"];
	_locationText = [position _vehicle] call _fnc_getLocationName;
	_text = format ["%1 is entering airspace %2 - We're RTB.", groupId _group, _locationText];
	[_vehicle,_text] remoteExecCall ["sideChat",driver _vehicle,false];
};

_fnc_callOutTakeoff = {
	params ["_group","_vehicle"];
	_locationText = [position _vehicle] call _fnc_getLocationName;
	_text = format ["%1 you are cleared for takeoff %2.", groupId _group,_locationText];
	[HQMan,_text] remoteExecCall ["sideChat",HQMan,false];
};

_fnc_isMissionCurrent = {
	params ["_vehicle","_checkToMissionNumber"];
	(_checkToMissionNumber == (_vehicle getVariable ["missionNr",-1]));
};

_fnc_isOnlyBoardCrew = {
	params ["_vehicle"];
	_boardCrew = group driver _vehicle;
	{ 
		alive _x && group _x != _boardCrew;
	} count (crew _vehicle) == 0;
};


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
	[group _driver, _vehicle] call _fnc_callOutTakeoff; // use spaw once function is global
};

if (isTouchingGround _vehicle) then {
	waitUntil {!isTouchingGround _vehicle || !(_thisMission call _fnc_isMissionCurrent)};
	if (!(_thisMission call _fnc_isMissionCurrent)) then {
		breakOut "FlyTo";
	};
	sleep 2;

	[_vehicle,"Off we go."] remoteExec ["vehicleChat",driver _vehicle,false];
} else {
	[_vehicle,"Diverting."] remoteExec ["vehicleChat",driver _vehicle,false];
};

/* Landing done **/

waitUntil { ((_vehicle getVariable ["landingInProgress",false]) || !(_thisMission call _fnc_isMissionCurrent)); };
if (!(_thisMission call _fnc_isMissionCurrent)) then {
	_vehicle land "NONE";
	breakOut "FlyTo";
};

waitUntil { (isTouchingGround _vehicle || {!canMove _vehicle} || !(_thisMission call _fnc_isMissionCurrent)); };
if (!(_thisMission call _fnc_isMissionCurrent)) then {
	_vehicle land "NONE";
	breakOut "FlyTo";
};

sleep 2;

/* Post landing,cleanup */
{
	deleteWaypoint _x
} foreach waypoints _driver;

[_vehicle,"We reached our destination. Good Luck out there!"] remoteExecCall ["vehicleChat",driver _vehicle,false];

sleep 5;

if (!isMultiplayer) then {
	savegame;
};

/* wait for empty helicopter */

waitUntil { ([_vehicle] call _fnc_isOnlyBoardCrew) || !(_thisMission call _fnc_isMissionCurrent) }; // helicopter empty except pilot + crew
if (!(_thisMission call _fnc_isMissionCurrent)) then {
	_vehicle land "NONE";
	breakOut "FlyTo";
};

deleteMarker _mrkcustomLZ1;
if (!isMultiplayer) then {
	savegame;
};			

sleep 4;

[group _driver, _vehicle] call _fnc_callOutLiftoffAtLZ; // use spaw once function is global

/* RTB */
[_vehicle,_thisMission,_fnc_isMissionCurrent] execVM "RandFramework\FlyToBase.sqf"
