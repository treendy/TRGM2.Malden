/* 	Script starting here  */
scopeName "FlyTo";

params [
	"_destinationPosition",
	["_vehicle", objNull],
	["_isPickup", false]
];

_radius = 900;
_airEscort = false;
//{
//		if ((_x distance2D _destinationPosition) < _radius) then {
//			_airEscort = true;
//		};
//} forEach ClearedPositions;

_mainAOPos = ObjectivePossitions select 0;
if (! isNil "_mainAOPos") then {
	if (_mainAOPos in ClearedPositions  && (_mainAOPos distance2D _destinationPosition) < _radius) then {
		_airEscort = true;
	};
};


//ObjectivePossitions

if (!alive _vehicle) then {
	breakOut "FlyTo";
};

_vehicle setFuel 1;

//cleanup possible prevoius prevoious
deleteVehicle (_vehicle getVariable ["targetPad", objNull]);
deleteMarker (_vehicle getVariable ["lzMarker",""]);



/** New Tranport Mission starts here **/

// set mission number -> invalidates old instances of this script running.
_thisMissionNr = (_vehicle getVariable ["missionNr",0]) + 1;
_vehicle setVariable ["missionNr", _thisMissionNr, true];

_thisMission = [_vehicle,_thisMissionNr];

_cleanupMission = {
	params ["_mission"];

	_markerName = str(_mission select 0) + "LZ" + str(_mission select 1);
	deleteMarker _markerName;
};

_vehicle setVariable ["targetPos",_destinationPosition,true];
_driver = driver _vehicle;

/* Set landing zone map marker */

_markerName = str(_vehicle) + "LZ" + str(_thisMissionNr);

_mrkcustomLZ1 = createMarker [_markerName, _destinationPosition];
_mrkcustomLZ1 setMarkerShape "ICON";
_mrkcustomLZ1 setMarkerSize [1,1];
_mrkcustomLZ1 setMarkerColor "colorBLUFOR";
_mrkcustomLZ1 setMarkerType "hd_pickup";
_mrkcustomLZ1 setMarkerText (format ["LZ %1", [_vehicle] call TRGM_fnc_getTransportName]);
_vehicle setVariable ["lzMarker",_mrkcustomLZ1,true];

_heliPad = "Land_HelipadEmpty_F" createVehicle _destinationPosition; // invisible landingpad to specify exact landing position
_vehicle setVariable ["targetPad",_heliPad,true];

{
	deleteWaypoint _x
} foreach waypoints group _driver;

_vehicle setVariable ["landingInProgress",false,true];


_waypointIndex = 0;
/* Set Waypoint,Takeoff */
if (!_airEscort) then {
	_iSaftyCount = 500;
	_bHalfWayWaypoint = false;
	_DirAtoB = [getPos _vehicle, _destinationPosition] call BIS_fnc_DirTo;
	_AvoidZonePos = ObjectivePossitions select 0;

	if (! isNil "_AvoidZonePos" ) then {
		_stepPos = getPos _vehicle;
		_stepDistLeft = _vehicle distance _destinationPosition;
		_bEndSteps = false;
		while {!_bEndSteps && _iSaftyCount > 0} do {
			_iSaftyCount = _iSaftyCount - 1;
			_stepPos = _stepPos getPos [100,_DirAtoB];
			_stepDistToAO = _stepPos distance _AvoidZonePos;
			_stepDistLeft = _stepPos distance _destinationPosition;

			if (false) then {
				_markerNameSteps = str(_vehicle) + "Step_" + str(500 - _iSaftyCount);
				_mrkcustomSteps = createMarker [_markerNameSteps, _stepPos];
				_mrkcustomSteps setMarkerShape "ICON";
				_mrkcustomSteps setMarkerSize [1,1];
				_mrkcustomSteps setMarkerType "hd_dot";
				_mrkcustomSteps setMarkerText ("Step " + str(_stepDistLeft));
				sleep 0.1;
				hint str(_iSaftyCount);
			};

			if (_stepDistToAO < 1000) then {
				_bEndSteps = true;
				_divertDirectionA = ([_DirAtoB,80] call TRGM_fnc_AddToDirection);
				_newPosA = _AvoidZonePos getPos [2000,_divertDirectionA];
				_divertDirectionB = ([_DirAtoB,-80] call TRGM_fnc_AddToDirection);
				_newPosB = _AvoidZonePos getPos [2000,_divertDirectionB];
				_totalDistA = (_vehicle distance _newPosA) + (_newPosA distance _destinationPosition);
				_totalDistB = (_vehicle distance _newPosB) + (_newPosB distance _destinationPosition);
				_newPos = nil;
				if (_totalDistA < _totalDistB) then {
					_newPos = _newPosA;
				}
				else {
					_newPos = _newPosB;
				};
				_waypointIndex = _waypointIndex + 1;
				_flyToLZMid = group _driver addWaypoint [_newPos,0,0];
				_flyToLZMid setWaypointType "MOVE";
				_flyToLZMid setWaypointSpeed "FULL";
				_flyToLZMid setWaypointBehaviour "CARELESS";
				_flyToLZMid setWaypointCombatMode "BLUE";
				_flyToLZMid setWaypointCompletionRadius 1000;
			};
			if (_stepDistLeft < 300) then {
				_bEndSteps = true;
			};
		};
	}
};

_flyToLZ = group _driver addWaypoint [_destinationPosition,0,_waypointIndex];
_flyToLZ setWaypointType "MOVE";
_flyToLZ setWaypointSpeed "FULL";
_flyToLZ setWaypointBehaviour "CARELESS";
_flyToLZ setWaypointCombatMode "BLUE";
_flyToLZ setWaypointCompletionRadius 100;
_flyToLZ setWaypointStatements ["true", "(vehicle this) land 'GET IN'; (vehicle this) setVariable [""landingInProgress"",true,true]"];

if (_airEscort) then {
	_escortPilot = driver chopper2;
	{
		deleteWaypoint _x
	} foreach waypoints group _escortPilot;
	_escortFlyToLZ = group _escortPilot addWaypoint [_destinationPosition,0,0];
	_escortFlyToLZ setWaypointBehaviour "AWARE";
	_escortFlyToLZ setWaypointCombatMode "RED";
	_escortFlyToLZ setWaypointType "LOITER";
	_escortFlyToLZ setWaypointLoiterType "CIRCLE";
	_escortFlyToLZ setWaypointSpeed "FULL";
};


if (!([_vehicle] call TRGM_fnc_helicopterIsFlying)) then {
	_locationText = [position _vehicle,true] call TRGM_fnc_getLocationName;
	_text = format [localize "STR_TRGM2_transport_fnflyToLz_ClearTakeoff", [_vehicle] call TRGM_fnc_getTransportName,_locationText];
	[_text] call TRGM_fnc_commsHQ;
};

if (!([_vehicle] call TRGM_fnc_helicopterIsFlying)) then {
	waitUntil {(!([_vehicle] call TRGM_fnc_helicopterIsFlying)) || !(_thisMission call TRGM_fnc_checkMissionIdActive)};
	if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
		[_thisMission] call _cleanupMission;
		breakOut "FlyTo";
	};
	sleep 2;

	[_vehicle,localize "STR_TRGM2_transport_fnflyToLz_OffWeGo"] call TRGM_fnc_commsPilotToVehicle;
} else {
	[_vehicle,localize "STR_TRGM2_transport_fnflyToLz_Diverting"]call TRGM_fnc_commsPilotToVehicle;
};

/* Landing done **/

waitUntil { ((_vehicle getVariable ["landingInProgress",false]) || !(_thisMission call TRGM_fnc_checkMissionIdActive)); };
if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	_vehicle land "NONE";
	[_thisMission] call _cleanupMission;
	breakOut "FlyTo";
};

waitUntil { ((!([_vehicle] call TRGM_fnc_helicopterIsFlying)) || {!canMove _vehicle} || !(_thisMission call TRGM_fnc_checkMissionIdActive)); };
if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
	_vehicle land "NONE";
	[_thisMission] call _cleanupMission;
	breakOut "FlyTo";
;
};

sleep 2;

/* Post landing,cleanup */
{
	deleteWaypoint _x
} foreach waypoints _driver;

if (!_isPickup) then {
	[_vehicle, localize "STR_TRGM2_transport_fnflyToLz_ReachLZ_Out"] call TRGM_fnc_commsPilotToVehicle;
}
else {
	[driver _vehicle,localize "STR_TRGM2_transport_fnflyToLz_ReachLZ_In"] call TRGM_fnc_commsSide;
};


sleep 5;

/* wait for empty helicopter */

if (!_isPickup) then {
	waitUntil { ([_vehicle] call TRGM_fnc_isOnlyBoardCrewOnboard) || !(_thisMission call TRGM_fnc_checkMissionIdActive) }; // helicopter empty except pilot + crew

	if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
		_vehicle land "NONE";
		[_thisMission] call _cleanupMission;
		breakOut "FlyTo";
	};
	/* RTB */
	[_vehicle,_thisMission] spawn TRGM_fnc_flyToBase;
}
else {
	waitUntil { !([_vehicle] call TRGM_fnc_isOnlyBoardCrewOnboard) || !(_thisMission call TRGM_fnc_checkMissionIdActive) }; // helicopter has passengers (not just pilot + crew)
	if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
		_vehicle land "NONE";
		[_thisMission] call _cleanupMission;
		breakOut "FlyTo";
	};
	if (!(_thisMission call TRGM_fnc_checkMissionIdActive)) then {
		/* RTB */
		[_vehicle,_thisMission] spawn TRGM_fnc_flyToBase;
	}
	else {
		[_vehicle, localize "STR_TRGM2_transport_fnflyToLz_WelcomeAboard"] call TRGM_fnc_commsPilotToVehicle;
	};
};

sleep 4;

[_thisMission] call _cleanupMission;