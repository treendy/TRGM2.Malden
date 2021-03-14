/* ---------------------------------------------------------------------------------------------------------

File: reinforcements.sqf
Author: Iceman77

Description:
A function that will create a fully manned helo which inserts infantry units into an AO.

Parameter(s):
_this select 0 <side> - EAST, WEST, INDEPENDENT
_this select 1 <string> - Marker: (spawn position of the helo)
_this select 2 <string> - Marker: (Landing Zone for the helo)
_this select 3 <number> - Skill Setting: (1,2,3,4 >> 1 = Noob AI -- 4 = Deadly Ai)
_this select 4 <bool> - SAD Mode: (True = Seek & destroy mode enabled. False = Patrol Mode Enabled)
_this select 5 <bool> - Body Deletion: (True = delete dead Bodies of the reinforcements, False = let the dead bodies stay on the battlefield)
_this select 6 <bool> - Cycle Mode: (True = ON, False = OFF)
_this select 7 <bool> - Paradrop: (True = Enabled, False = Disabled)
_this select 8 <bool> - Debug Mode: (True = Enabled, False = Disabled)
_this select 8 <bool> - Use standard reinforcements delay: (True = Use alternate delay, False = Use standard delay)

Usage:
_nul = [SIDE, "string", "string", number, bool, bool, bool, bool, bool, bool] spawn TREND_fnc_reinforcements; >>
_nul = [EAST, "spawnMrk", "LZMrk", 2, true, true, true, true, false, false] spawn TREND_fnc_reinforcements; <<

 ---------------------------------------------------------------------------------------------------------*/
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

FPSMAX=60; //60 FPS max
FPSLIMIT=15; // 15 FPS min
MAXDELAY=5; // 5 sec max delay
_AdditionalUnitCreationDelay = ((abs(FPSMAX - diag_fps) / (FPSMAX - FPSLIMIT))^2) * MAXDELAY;

//arguments definitions
params [
	["_side", EAST],
	["_spawnMrk", [0,0,0]],
	["_LZMrk", [0,0,0]],
	["_skill", 3],
	["_sadMode", true],
	["_bodyDelete", true],
	["_cycleMode", false],
	["_paraDrop", false],
	["_debugMode", false],
	["_useStandardDelay", true]
];

if ((_LZMrk select 0) isEqualTo 0 && (_LZMrk select 1) isEqualTo 0) exitWith {};

if (!isServer) exitWith {};

sleep(_AdditionalUnitCreationDelay);

if (TREND_ReinforcementsCalled > 4) exitWith {};
TREND_ReinforcementsCalled = TREND_ReinforcementsCalled + 1; publicVariable "TREND_ReinforcementsCalled";

if (_useStandardDelay && {(time - TREND_TimeLastReinforcementsCalled) < (call TREND_GetSpottedDelay)}) exitWith {};
if (!_useStandardDelay && {(time - TREND_TimeSinceAdditionalReinforcementsCalled) < (call TREND_GetSpottedDelay * 1.5)}) exitWith {}; //Using 1.5 multiplier for the delay so the main and additional triggers don't fire at the same time.

if (_useStandardDelay) then {
	TREND_TimeLastReinforcementsCalled = time;
	publicVariable "TREND_TimeLastReinforcementsCalled";
} else {
	TREND_TimeSinceAdditionalReinforcementsCalled = time;
	publicVariable "TREND_TimeSinceAdditionalReinforcementsCalled";
};

_heloCrew = createGroup _side;

//set the scope of local variables that are defined in other scope(s), so they can be used over the entire script
private ["_ranGrp","_helo","_infgrp"];

//Debug output of the passed arguments
if (_debugMode) then {
	sleep 1;
	[format ["Debug mode is enabled %1 (SP ONLY!!). Mapclick teleport, invincibility and marker tracking are enabled.", name player]] call TREND_fnc_notify;
	player globalChat format ["Side: %1", _side];
	player globalChat format ["Spawn Position: %1 ", _spawnMrk];
	player globalChat format ["Landing Zone: %1", _LZMrk];
	player globalChat format ["AI Skill: %1", _skill];
	player globalChat format ["SAD Mode: %1", _sadMode];
	player globalChat format ["Body Deletion: %1", _bodyDelete];
	player globalChat format ["Cycle Mode: %1", _cycleMode];
	player globalChat format ["Debug Mode: %1", _debugMode];
	player globalChat format ["Use standard delay: %1", _useStandardDelay];
};

//Side Check to spawn appropriate helicopter & cargo
switch (_side) do {
	case WEST : {
		_infgrp = createGroup WEST;

		_infgrp createUnit [(call fTeamleader),    [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call fGrenadier),     [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call fMedic),         [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call fRifleman),      [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call fMachineGunMan), [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_helo = createVehicle [(call ReinforceVehicleFriendly), _spawnMrk, [], 0, "FLY"];
	};
	case EAST : {
		_infgrp = createGroup EAST;

		_infgrp createUnit [(call sTeamleader),    [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sGrenadier),     [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sMedic),         [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sRifleman),      [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sMachineGunMan), [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_helo = createVehicle [(call ReinforceVehicle), _spawnMrk, [], 0, "FLY"];
	};
	case INDEPENDENT : {
		_infgrp = createGroup INDEPENDENT;

		_infgrp createUnit [(call sTeamleaderMilitia),    [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sGrenadierMilitia),     [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sMedicMilitia),         [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sRiflemanMilitia),      [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_infgrp createUnit [(call sMachineGunManMilitia), [0,0], [], 5, "NONE"]; sleep(_AdditionalUnitCreationDelay);
		_helo = createVehicle [(call ReinforceVehicleMilitia), _spawnMrk, [], 0, "FLY"];
	};
};

//Debug output of the helo + cargo
if (_debugMode) then {
	player globalChat format ["Group Selection: %1", _ranGrp];
	player globalChat format ["Helo Array: %1", _Helo];
	player globalChat format ["Cargo Group: %1", _infGrp];
};

//Set the infantry groups skill levels (_skill is a 1 based index, so use _skill - 1 for selecting on a zero based index)
if (_skill > 4) then {_skill = 4;};
if (_skill < 1) then {_skill = 1;};
{
	_x setSkill["general",        [1.0, 1.0, 1.0, 1.0] select (_skill - 1)];
	_x setSkill["aimingAccuracy", [0.2, 0.3, 0.3, 0.4] select (_skill - 1)];
	_x setSkill["aimingShake",    [0.2, 0.3, 0.4, 0.5] select (_skill - 1)];
	_x setSkill["aimingSpeed",    [0.7, 0.7, 1.0, 1.0] select (_skill - 1)];
	_x setSkill["endurance",      [0.1, 0.2, 0.5, 0.5] select (_skill - 1)];
	_x setSkill["spotDistance",   [0.1, 0.2, 0.3, 0.5] select (_skill - 1)];
	_x setSkill["spotTime",       [0.1, 0.2, 0.3, 0.5] select (_skill - 1)];
	_x setSkill["courage",        [1.0, 1.0, 1.0, 1.0] select (_skill - 1)];
	_x setSkill["reloadspeed",    [0.1, 0.2, 0.7, 1.0] select (_skill - 1)];
	_x setSkill["commanding",     [0.5, 0.7, 1.0, 1.0] select (_skill - 1)];
} forEach units _infGrp;

//Assign the crew to a group & assign cargo to the helo
{[_x] joinSilent _heloCrew;} forEach crew (_helo select 0);
{_x assignAsCargo (_helo select 0); _x moveInCargo (_helo select 0);} forEach units _infgrp;
_infgrp deleteGroupWhenEmpty true;
_heloCrew deleteGroupWhenEmpty true;

//Debug output of the total crew count (cargo counts as crew too)
if (_debugMode) then {player globalChat format ["Helicopter Total Crew Count: %1", count crew (_helo select 0)];};

//Enable body deletion if the _bodyDelete parameter is passed as true
if (_bodyDelete) then {
	{_x addMPEventhandler ["MPKilled",{[(_this select 0)] spawn TREND_fnc_deleteTrash}]} forEach crew (_helo select 0) + [(_helo select 0)];
};

//Find a flat position around the LZ marker & create an HPad there.
_flatPos = [_LZMrk , 0, 600, 20, 0, 0.3, 0, [],[_LZMrk,_LZMrk], (_helo select 0)] call TREND_fnc_findSafePos;
_hPad = createVehicle ["Land_HelipadEmpty_F", _flatPos, [], 0, "NONE"];

//Debug output map markers
private ["_mrkPos","_mrkLZ","_mrkHelo","_mrkinf","_mrkTarget"];
if (_debugMode) then {
	_color = [(((side leader _infGrp) call bis_fnc_sideID) call bis_fnc_sideType),true] call bis_fnc_sidecolor;

	_mrkPos = createMarker [format ["%1", random 10000], _flatPos];
	_mrkPos setMarkerShape "ICON";
	_mrkPos setMarkerType "mil_objective";
	_mrkPos setMarkerSize [1,1];
	_mrkPos setMarkerColor _color;
	_mrkPos setMarkerText "Actual LZ";

	_mrkLZ = createMarker [format ["%1", random 10000], _LZMrk];
	_mrkLZ  setMarkerShape "ICON";
	_mrkLZ  setMarkerType "mil_dot";
	_mrkLZ  setMarkerSize [1,1];
	_mrkLZ  setMarkerColor _color;
	_mrkLZ  setMarkerText "LZ Area";

	_mrkHelo = createMarker [format ["%1", random 10000], getPosATL (_helo select 0)];
	_mrkHelo setMarkerShape "ICON";
	_mrkHelo setMarkerType "o_air";
	_mrkHelo setMarkerSize [1,1];
	_mrkHelo setMarkerColor _color;
	_mrkHelo setMarkerText format ["%1", (_helo select 0)];

	_mrkInf = createMarker [format ["%1", random 10000], getPosATL leader _infGrp];
	_mrkInf setMarkerShape "ICON";
	_mrkInf setMarkerType "mil_dot";
	_mrkInf setMarkerSize [1,1];
	_mrkInf setMarkerColor _color;

	[(_helo select 0), _infGrp, _mrkHelo, _mrkInf] spawn {
		while {{alive _x} count units (_this select 1) > 0 || canMove (_this select 0)} do {
			(_this select 2) setMarkerPos getPosATL (_this select 0);
			(_this select 3) setMarkerPos getPosATL leader (_this select 1);
			sleep 1;
		};
	};
};


//Give the helicopter an unload waypoint onto the hpad

if (!_paraDrop) then {
	_heloWp = _heloCrew addWaypoint [_hPad, 0];
	_heloWp setWaypointType "TR UNLOAD";
	_heloWp setWaypointBehaviour "CARELESS";
	_heloWp setWaypointCombatMode "BLUE";
	_heloWp setWaypointSpeed "FULL";
	if (_spawnMrk select 2 isEqualTo 0) then {
		//_heloWp setWaypointStatements ["true", "[""hmmmm""] call TREND_fnc_notify; {this spawn {unAssignVehicle _x; _x action [""eject"", vehicle _x]; sleep 0.5;} forEach crew vehicle _this;"}];
		_heloWp setWaypointStatements ["true", "{unAssignVehicle _x; _x action [""eject"", vehicle _x]; sleep 0.5;} forEach crew vehicle this;"];
		//_heloWp setWaypointStatements ["true", "[""hmmmm""] call TREND_fnc_notify; {unAssignVehicle _x; _x action [""eject"", vehicle _x]; sleep 0.5;} forEach crew vehicle this;"];
	}
	else {
		_heloWp setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
	};


	//wait until the helicopter is touching the ground before ejecting the cargo

	if (_spawnMrk select 2 isEqualTo 0) then {
		//[format["test3: %1 - %2",currentWaypoint _infgrp,fuel _helo]] call TREND_fnc_notify;

		//waitUntil {fuel _helo isEqualTo 0};

		//["test2"] call TREND_fnc_notify;
	}
	else {
		waitUntil {sleep 2; isTouchingGround (_helo select 0) || {!canMove (_helo select 0)}};
		{unAssignVehicle _x; _x action ["eject", vehicle _x]; sleep 0.5;} forEach units _infgrp; //Eject the cargo
	};

	//["a"] call TREND_fnc_notify;
	//wait Until the infantry group is no longer in the helicopter before assigning a new WP to the helicopter
	waitUntil {sleep 2; {!alive _x || !(_x in (_helo select 0))} count (units _infGrp) isEqualTo count (units _infGrp)};
		if (_debugMode) then {player globalChat format ["Helo Cargo Count: %1", {alive _x && (_x in (_helo select 0))} count (units _infGrp)];};
			_heloWp = _heloCrew addWaypoint [[0,0,0], 0];
			_heloWp setWaypointType "MOVE";
			_heloWp setWaypointBehaviour "AWARE";
			_heloWp setWaypointCombatMode "RED";
			_heloWp setWaypointSpeed "FULL";
			_heloWp setWaypointStatements ["true", "{deleteVehicle _x;} forEach crew (vehicle this) + [vehicle this];"];

	//["b"] call TREND_fnc_notify;

} else {

	//disable collision to avoid deaths and setup the paradrop
	{_x disableCollisionWith (_helo Select 0)} forEach units _infGrp;
	(_helo select 0) flyInHeight 200;

	_heloWp = _heloCrew addWaypoint [_hPad, 0];
	_heloWp setWaypointType "MOVE";
	_heloWp setWaypointBehaviour "CARELESS";
	_heloWp setWaypointCombatMode "BLUE";
	_heloWp setWaypointSpeed "FULL";
	_heloWp setWaypointStatements ["true", "nul = [assignedCargo (vehicle this)] spawn TREND_fnc_para;"];

	_heloWp = _heloCrew addWaypoint [[0,0,0], 0];
	_heloWp setWaypointType "MOVE";
	_heloWp setWaypointBehaviour "AWARE";
	_heloWp setWaypointCombatMode "RED";
	_heloWp setWaypointSpeed "FULL";
	_heloWp setWaypointStatements ["true", "{deleteVehicle _x;} forEach crew (vehicle this) + [vehicle this];"];
};

//wait until cargo is empty & if _sadMode is passed as true, then add a SAD WP on the nearest enemy.. else, go into patrol mode
	waitUntil {sleep 2; {!alive _x || !(_x in (_helo select 0))} count (units _infGrp) isEqualTo count (units _infGrp)};
	if (_debugMode) then {
		{deleteMarker _x;} forEach [_mrkLZ, _mrkPos];
	};

if (_sadMode) then {
	if (_debugMode) then {player globalChat "Scanning for targets to enable SAD Mode";};
	private "_nearestEnemies";
	_nearestEnemies = [];
	_nearestMen = nearestObjects [getPosATL leader _infGrp, ["Man"], 1000];
		{
			if ( (side _x getFriend (side leader (_infGrp))) < 0.6 && {side _x != CIVILIAN} ) then {
				_nearestEnemies = _nearestEnemies + [_x];
			};
		} forEach _nearestMen;

		if (count _nearestEnemies > 0) then {
			_enemy = _nearestEnemies call bis_fnc_selectRandom;
			_attkPos = [_enemy, random 100, random 360] call BIS_fnc_relPos;
			_infWp = _infGrp addWaypoint [_attkPos, 0];
			_infWp setWaypointType "SAD";
			_infWp setWaypointBehaviour "AWARE";
			_infWp setWaypointCombatMode "RED";
			_infWp setWaypointSpeed "FULL";

				if (_debugMode) then {
				player globalChat "Target Found. Setting SAD waypoint";
				_colorTarget = [(((side _enemy) call bis_fnc_sideID) call bis_fnc_sideType),true] call bis_fnc_sidecolor;
				_mrkTarget = createMarker [format ["%1", random 10000], _attkPos];
				_mrkTarget setMarkerShape "ICON";
				_mrkTarget setMarkerType "mil_dot";
				_mrkTarget setMarkerSize [1,1];
				_mrkTarget setMarkerColor _colorTarget;
				_mrkTarget setMarkerText "SAD Target Area";
			};

		} else {
			[_infGrp, getPosATL (leader _infGrp), 200] call BIS_fnc_taskPatrol;
			if (_debugMode) then {player globalChat "No targets found. Patrol mode enabled";};

		};

} else {
	[_infGrp, getPosATL (leader _infGrp), 200] call BIS_fnc_taskPatrol;
	if (_debugMode) then {player globalChat "Patrol Mode";};

};

// Cycle mode gets a bit too intense for most situations, commenting out to avoid usage...
// IF _cycleMode is passed as true, then re-run the function (this function!), else do nothing.
// if (_cycleMode) then {
// 	waitUntil {{alive _x} count units _infgrp + [(_helo select 0)] isEqualTo 0};
// 	if (_debugMode) then {
// 		player globalChat "Patrol and helicopter dead";
// 		{deleteMarker _x;} forEach [_mrkHelo, _mrkinf, _mrkTarget];
// 	};
// 	if (_debugMode) then {player globalChat "New Reinforcements created";};
// 	[_side, _spawnMrk, _LZMrk, _skill, _sadMode, _bodyDelete, false, _debugMode, _useStandardDelay] spawn TREND_fnc_reinforcements;
// };

TREND_ReinforcementsCalled = TREND_ReinforcementsCalled - 1; publicVariable "TREND_ReinforcementsCalled";

// Function End
true;