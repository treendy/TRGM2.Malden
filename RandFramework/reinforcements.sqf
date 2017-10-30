/* ---------------------------------------------------------------------------------------------------------

File: reinforcements.sqf
Author: Iceman77
    
Description:
A function that will create a fully manned helo which inserts infantry units into an AO. 
    
Parameter(s):
_this select 0 <side> - EAST, WEST, RESISTANCE
_this select 1 <string> - Marker: (spawn position of the helo)
_this select 2 <string> - Marker: (Landing Zone for the helo)
_this select 3 <number> - Skill Setting: (1,2,3,4 >> 1 = Noob AI -- 4 = Deadly Ai)
_this select 4 <bool> - SAD Mode: (True = Seek & destroy mode enabled. False = Patrol Mode Enabled)
_this select 5 <bool> - Body Deletion: (True = delete dead Bodies of the reinforcements, False = let the dead bodies stay on the battlefield)
_this select 6 <bool> - Cycle Mode: (True = ON, False = OFF) 
_this select 7 <bool> - Paradrop: (True = Enabled, False = Disabled)
_this select 8 <bool> - Debug Mode: (True = Enabled, False = Disabled)

Usage:
_nul = [SIDE, "string", "string", number, bool, bool, bool, bool, bool] spawn TAG_fnc_reinforcements; >> 
_nul = [EAST, "spawnMrk", "LZMrk", 2, true, true, true, true, false] spawn TAG_fnc_reinforcements; <<

 ---------------------------------------------------------------------------------------------------------*/
 if (isServer) then {
	 _spawnMrk = [0,0,0];
	 _LZMrk = [0,0,0];

	 //arguments definitions 
	_side = _this select 0;
	_spawnMrk = _this select 1;
	_LZMrk = _this select 2;
	_skill = _this select 3;
	_sadMode = _this select 4;
	_bodyDelete = _this select 5;
	_cycleMode = _this select 6;
	_paraDrop = _this select 7;
	_debugMode = _this select 8;
	_heloCrew = createGroup _side;  

	//set the scope of local variables that are defined in other scope(s), so they can be used over the entire script
	private ["_ranGrp","_helo","_infgrp"];

	//Debug output of the passed arguments
	if (_debugMode) then {
		sleep 1;
		hint format ["Debug mode is enabled %1 (SP ONLY!!). Mapclick teleport, invincibility and marker tracking are enabled.", name player];
		player globalChat format ["Side: %1", _side];
		player globalChat format ["Spawn Position: %1 ", _spawnMrk];
		player globalChat format ["Landing Zone: %1", _LZMrk];
		player globalChat format ["AI Skill: %1", _skill];
		player globalChat format ["SAD Mode: %1", _sadMode];
		player globalChat format ["Body Deletion: %1", _bodyDelete];
		player globalChat format ["Cycle Mode: %1", _cycleMode];
		player globalChat format ["Debug Mode: %1", _debugMode];
	};

	//Side Check to spawn appropriate helicopter & cargo
	switch (_side) do {
		case WEST : {
			_ranGrp = ["BUS_InfSquad","BUS_InfSquad_Weapons"] call BIS_fnc_selectRandom;
			_helo = [_spawnMrk, 45, "B_Heli_Transport_01_F", WEST] call BIS_FNC_spawnVehicle;
			_infgrp = [_spawnMrk, WEST, (configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry" >> _ranGrp)] call BIS_fnc_spawnGroup;
		};
		case EAST : {
				_infgrp = createGroup east;
				sTeamleader createUnit [[0+1, 0], _infgrp];
				sGrenadier createUnit [[0, 0+1], _infgrp];
				sMedic createUnit [[0+1, 0+1], _infgrp];
				sRifleman createUnit [[0-1, 0], _infgrp];
				sRifleman createUnit [[0, 0-1], _infgrp];
				_helo = [_spawnMrk, 45, ReinforceVehicle, EAST] call BIS_FNC_spawnVehicle;
		};
		case RESISTANCE : {
			_ranGrp = ["HAF_InfSquad","HAF_InfSquad_Weapons"] call BIS_fnc_selectRandom;
			_helo = [_spawnMrk, 45, "I_Heli_Transport_02_F", RESISTANCE] call BIS_FNC_spawnVehicle;
			_infgrp = [_spawnMrk, RESISTANCE, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> _ranGrp)] call BIS_fnc_spawnGroup;
		};
	};

	//Debug output of the helo + cargo
	if (_debugMode) then {
		player globalChat format ["Group Selection: %1", _ranGrp];
		player globalChat format ["Helo Array: %1", _Helo];
		player globalChat format ["Cargo Group: %1", _infGrp];
	};

	//Set the infantry groups skill levels
	switch (_skill) do 
	{   case 1 : 
		{
			{
				_x setSkill ["general",1];
				_x setSkill ["aimingAccuracy",0.2];
				_x setSkill ["aimingShake",0.2];
				_x setSkill ["aimingSpeed",0.7];
				_x setSkill ["endurance",0.1];
				_x setSkill ["spotDistance",0.1];
				_x setSkill ["spotTime",0.1];
				_x setSkill ["courage",1];
				_x setSkill ["reloadspeed",0.1];
				_x setSkill ["commanding",0.5];
			} forEach units _infGrp;
	
		};
	
		case 2 : 
		{
			{
				_x setSkill ["general",1];
				_x setSkill ["aimingAccuracy",0.3];
				_x setSkill ["aimingShake",0.3];
				_x setSkill ["aimingSpeed",0.7];
				_x setSkill ["endurance",0.2];
				_x setSkill ["spotDistance",0.2];
				_x setSkill ["spotTime",0.2];
				_x setSkill ["courage",1];
				_x setSkill ["reloadspeed",0.2];
				_x setSkill ["commanding",0.75];
			} forEach units _infGrp;
	
		};
	
		case 3 : 
		{
			{
				_x setSkill ["general",1];
				_x setSkill ["aimingAccuracy",0.3];
				_x setSkill ["aimingShake",0.4];
				_x setSkill ["aimingSpeed",1];
				_x setSkill ["endurance",0.5];
				_x setSkill ["spotDistance",0.3];
				_x setSkill ["spotTime",0.3];
				_x setSkill ["courage",1];
				_x setSkill ["reloadspeed",0.75];
				_x setSkill ["commanding",1];
			} forEach units _infGrp;
	
		};
	
		case 4 : 
		{
			{
				_x setSkill ["general",1];
				_x setSkill ["aimingAccuracy",0.4];
				_x setSkill ["aimingShake",0.5];
				_x setSkill ["aimingSpeed",1];
				_x setSkill ["endurance",0.5];
				_x setSkill ["spotDistance",0.5];
				_x setSkill ["spotTime",0.5];
				_x setSkill ["courage",1];
				_x setSkill ["reloadspeed",1];
				_x setSkill ["commanding",1];
			} forEach units _infGrp;
		};
	};


	//Assign the crew to a group & assign cargo to the helo
	{[_x] joinSilent _heloCrew;} forEach crew (_helo select 0);	
	{_x assignAsCargo (_helo select 0); _x moveInCargo (_helo select 0);} forEach units _infgrp; 

	//Debug output of the total crew count (cargo counts as crew too)
	if (_debugMode) then {player globalChat format ["Helicopter Total Crew Count: %1", count crew (_helo select 0)];};

	//Enable body deletion if the _bodyDelete parameter is passed as true
	if (_bodyDelete) then {
		{_x addMPEventhandler ["MPKilled",{[(_this select 0)] spawn TAG_fnc_deleteTrash}]} forEach crew (_helo select 0) + [(_helo select 0)];
			if (isNil "bodyDeleteInit") then {
 				bodyDeleteInit = 1;
	          
					TAG_fnc_deleteTrash = {
						sleep 60;
						hideBody (_this select 0);
						sleep 5;
						deleteVehicle (_this select 0);
					};
			};
	};

	if (isNil "debugInit") then {
		debugInit = 1;
		if (_debugMode) then {
		   ["Teleport_ID", "onMapSingleClick", "TAG_fnc_teleport"] call BIS_fnc_addStackedEventHandler; 
	   
			TAG_fnc_teleport = {
				player setPos _pos;
				{
					_grpPos = [player, 10 + (random 15), random 360] call BIS_fnc_relPos;
					_x setPosATL _grpPos;
				} forEach units (group player);
				hintSilent format ["Moved to grid %1", mapGridPosition player]; 
			};

		};
	
	};

	//Find a flat position around the LZ marker & create an HPad there.
	_flatPos = [_LZMrk , 0, 600, 20, 0, 0.3, 0] call BIS_fnc_findSafePos;
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
		if (_spawnMrk select 2 == 0) then {
			//_heloWp setWaypointStatements ["true", "hint ""hmmmm""; {this spawn {unAssignVehicle _x; _x action [""eject"", vehicle _x]; sleep 0.5;} forEach crew vehicle _this;"}];
			_heloWp setWaypointStatements ["true", "{unAssignVehicle _x; _x action [""eject"", vehicle _x]; sleep 0.5;} forEach crew vehicle this;"];
			//_heloWp setWaypointStatements ["true", "hint ""hmmmm""; {unAssignVehicle _x; _x action [""eject"", vehicle _x]; sleep 0.5;} forEach crew vehicle this;"];
		}
		else {
			_heloWp setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
		};

	
		//wait until the helicopter is touching the ground before ejecting the cargo	

		if (_spawnMrk select 2 == 0) then {
			//hint format["test3: %1 - %2",currentWaypoint _infgrp,fuel _helo];

			//waitUntil {fuel _helo == 0};
			
			//hint "test2";
		}
		else {
			waitUntil {isTouchingGround (_helo select 0) || {!canMove (_helo select 0)}};
			{unAssignVehicle _x; _x action ["eject", vehicle _x]; sleep 0.5;} forEach units _infgrp; //Eject the cargo
		};
		
		//hint "a";
		//wait Until the infantry group is no longer in the helicopter before assigning a new WP to the helicopter
		waitUntil {{!alive _x || !(_x in (_helo select 0))} count (units _infGrp) == count (units _infGrp)};
			if (_debugMode) then {player globalChat format ["Helo Cargo Count: %1", {alive _x && (_x in (_helo select 0))} count (units _infGrp)];};
				_heloWp = _heloCrew addWaypoint [[0,0,0], 0];
				_heloWp setWaypointType "MOVE";
				_heloWp setWaypointBehaviour "AWARE";
				_heloWp setWaypointCombatMode "RED";
				_heloWp setWaypointSpeed "FULL";
				_heloWp setWaypointStatements ["true", "{deleteVehicle _x;} forEach crew (vehicle this) + [vehicle this];"];

		//hint "b";

	} else {
    
		//disable collision to avoid deaths and setup the paradrop
		{_x disableCollisionWith (_helo Select 0)} forEach units _infGrp; 
		(_helo select 0) flyInHeight 200;
		if (isNil "TAG_fnc_para") then {
				TAG_fnc_para = {
					{
						unAssignVehicle _x; 
						_x action ["eject", vehicle _x]; 
						sleep 1.5;
						_chute = createVehicle ["Steerable_Parachute_F", getPosATL _x, [], 0, "CAN_COLLIDE"];
						_chute attachTo [_x,[0,0,0]];
						detach _chute;
						_x moveIndriver _chute;					
					} forEach assignedCargo (_this select 0);
				};
        	
		};
	
		_heloWp = _heloCrew addWaypoint [_hPad, 0];
		_heloWp setWaypointType "MOVE";
		_heloWp setWaypointBehaviour "CARELESS";
		_heloWp setWaypointCombatMode "BLUE";
		_heloWp setWaypointSpeed "FULL";
		_heloWp setWaypointStatements ["true", "nul = [(vehicle this)] spawn TAG_fnc_para;"];
	
		_heloWp = _heloCrew addWaypoint [[0,0,0], 0];
		_heloWp setWaypointType "MOVE";
		_heloWp setWaypointBehaviour "AWARE";
		_heloWp setWaypointCombatMode "RED";
		_heloWp setWaypointSpeed "FULL";
		_heloWp setWaypointStatements ["true", "{deleteVehicle _x;} forEach crew (vehicle this) + [vehicle this];"];
	};

	//wait until cargo is empty & if _sadMode is passed as true, then add a SAD WP on the nearest enemy.. else, go into patrol mode
	 waitUntil {{!alive _x || !(_x in (_helo select 0))} count (units _infGrp) == count (units _infGrp)};
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
		// IF _cycleMode is passed as true, then re-run the function (this function!), else do nothing.
		if (_cycleMode) then {
			waitUntil {{alive _x} count units _infgrp + [(_helo select 0)] == 0};
			if (_debugMode) then {
				player globalChat "Patrol and helicopter dead";
				{deleteMarker _x;} forEach [_mrkHelo, _mrkinf, _mrkTarget];
			};
			sleep 10;
			 if (_debugMode) then {player globalChat "New Reinforcements created";};
			 [_side, _spawnMrk, _LZMrk, _skill, _sadMode, _bodyDelete, _cycleMode, _debugMode] spawn TAG_fnc_reinforcements;
		};

	// Function End
};


	
	
	
	
	
	
   
