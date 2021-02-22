//These are only ever called by the server!

fnc_CustomRequired = { //used to set any required details for the AO (example, a wide open space or factory nearby)... if this is not found in AO, the engine will scrap the area and loop around again with a different location
//be careful about using this, some maps may not have what you require, so the engine will never satisfy the requirements here (example, if no airports are on a map and that is what you require)
	_objectiveMainBuilding = _this select 0;
	_centralAO_x = _this select 1;
	_centralAO_y = _this select 2;

	_result = false;

	_flatPos = nil;
	_flatPos = [[_centralAO_x,_centralAO_y,0] , 10, 150, 10, 0, 0.3, 0,[],[[_centralAO_x,_centralAO_y],[_centralAO_x,_centralAO_y]]] call TREND_fnc_findSafePos;

	if ((_flatPos select 0) > 0) then {_result = true};
	//flatPosDebug = _flatPos;
	_result; //return value
};

fnc_CustomVars = { //This is called before the mission function is called below, and the variables below can be adjusted for your mission
	_CustomMissionEnabled = true; //set this to true to allow this mission to show in the mission selection dialog
	_RequiresNearbyRoad = true;
	_roadSearchRange = 20; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_allowFriendlyIns = false;
	_MissionTitle = localize "STR_TRGM2_MeetingAssassinationMissionTitle"; //this is what shows in dialog mission selection
};

fnc_CustomMission = { //This function is the main script for your mission, some if the parameters passed in must not be changed!!!
	/*
	 * Parameter Descriptions
	 * --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 * _markerType 				: The marker type to be used, you can set the type of marker below, but if the player has selected to hide mission locations, then your marker will not show.
	 * _objectiveMainBuilding 	: DO NOT EDIT THIS VALUE (this is the main building location selected within your AO)
	 * _centralAO_x 			: DO NOT EDIT THIS VALUE (this is the X coord of the AO)
	 * _centralAO_y 			: DO NOT EDIT THIS VALUE (this is the Y coord of the AO)
	 * _roadSearchRange 		: DO NOT EDIT THIS VALUE (this is the search range for a valid road, set previously in fnc_CustomVars)
	 * _bCreateTask 			: DO NOT EDIT THIS VALUE (this is determined by the player, if the player selected to play a hidden mission, the task is not created!)
	 * _iTaskIndex 				: DO NOT EDIT THIS VALUE (this is determined by the engine, and is the index of the task used to determine mission/task completion!)
	 * _bIsMainObjective 		: DO NOT EDIT THIS VALUE (this is determined by the engine, and is the boolean if the mission is a Heavy or Standard mission!)
	 * _args 					: These are additional arguments that might be required for the mission, for an example, see the Destroy Vehicles Mission.
	 * --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	*/
	params ["_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];
	if (_markerType != "empty") then { _markerType = "hd_unknown"; }; // Set marker type here...

	_hvtLzPos = nil;
	_hvtLzPos = [[_centralAO_x,_centralAO_y,0] , 10, 150, 10, 0, 0.3, 0,[],[[_centralAO_x,_centralAO_y],[_centralAO_x,_centralAO_y]]] call TREND_fnc_findSafePos;
	if ((_hvtLzPos select 0) > 0) then {
		_hPad = createVehicle ["Land_HelipadEmpty_F", _hvtLzPos, [], 0, "NONE"];
	}
	else {
		_hvtLzPos = getPos _objectiveMainBuilding
	};


	_poshVehPos = nil;
	_nearestRoad = nil;
	_direction = nil;
	_guardUnit1 = nil;
	_nearestRoad = [getPos _objectiveMainBuilding, _roadSearchRange, []] call BIS_fnc_nearestRoad;
	_roadConnectedTo = nil;
	_roadConnectedTo = roadsConnectedTo _nearestRoad;
	_meetingVehs = HVTCars + HVTVans;
	_HVTGuys = InformantClasses + InterogateOfficerClasses + WeaponDealerClasses;
	if (count _roadConnectedTo > 0) then {
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
		_poshVehPos = getPos _nearestRoad;
	}
	else {
		_flatPos = nil;
		_flatPos = [getPos _objectiveMainBuilding, 10, 100, 10, 0, 0.3, 0,[],[getPos _objectiveMainBuilding,getPos _objectiveMainBuilding]] call TREND_fnc_findSafePos;
		_poshVehPos = _flatPos;
	};

	_mainHVTClass = selectRandom _HVTGuys;
	_HVTGuys = _HVTGuys - [_mainHVTClass];

	//TESTTEST = format ["TEST_ %1 - %2",_poshVehPos,getPosATL _objectiveMainBuilding];
	if ((_poshVehPos distance _objectiveMainBuilding) < 100) then {
		_objVehicle = selectRandom _meetingVehs createVehicle _poshVehPos;
		//_objVehicle setPos _poshVehPos;
		if (!isNil "_direction") then {
			_objVehicle setDir (_direction);
		};
		_guardUnit1 = (createGroup east) createUnit [selectRandom _HVTGuys,_poshVehPos,[],0,"NONE"];
	}
	else {
		_flatPos = nil;
		_flatPos = [getPos _objectiveMainBuilding, 10, 50, 5, 0, 0.5, 0,[],[getPos _objectiveMainBuilding,getPos _objectiveMainBuilding]] call TREND_fnc_findSafePos;
		if ((_flatPos select 0) > 0) then {
			_guardUnit1 = (createGroup east) createUnit [selectRandom _HVTGuys,_flatPos,[],0,"NONE"];
		}
		else {
			_guardUnit1 = (createGroup east) createUnit [selectRandom _HVTGuys,getPos _objectiveMainBuilding,[],20,"NONE"];
		};
	};
 	(group _guardUnit1) setBehaviour 'CARELESS';
 	_guardUnit1 setCaptive true;

	_hvtGroup = createGroup east;
	_hvtGuardGroup = createGroup east;

	_mainHVT = _hvtGroup createUnit [_mainHVTClass,[-500,-500,0],[],20,"NONE"];
	sleep 0.1;
	_guardUnit3 = _hvtGuardGroup createUnit [selectRandom _HVTGuys,[-500,-500,0],[],20,"NONE"];

	_mainHVT allowDamage false;
	_sTargetName = format["objInformant%1",_iTaskIndex]; //ignore that it is "objInformant", all objectives have this name, do not change this!
	_mainHVT setVariable [_sTargetName, _mainHVT, true];
	missionNamespace setVariable [_sTargetName, _mainHVT];
	_mainHVT setVariable ["ObjectiveParams", [_markerType,_objectiveMainBuilding,_centralAO_x,_centralAO_y,_roadSearchRange,_bCreateTask,_iTaskIndex,_bIsMainObjective,_args]];

	[_mainHVT, ["This is our target!","{[""This is our target""] call TREND_fnc_notify; }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];

	_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
	_guardUnit3 allowDamage false;
	_guardUnit3 setVariable [_sTargetName2, _guardUnit3, true];
	missionNamespace setVariable [_sTargetName2, _guardUnit3];
	[_guardUnit3, ["This is our friendly agent!","{[""This is our target""] call TREND_fnc_notify; }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];

	sleep 1;
	[_hvtLzPos, getPos _guardUnit1,_guardUnit1,_mainHVT,_guardUnit3,_hvtGroup,_hvtGuardGroup,_iTaskIndex] spawn { //spawn script so we can have timer that will action our mission movements without pausing the main initialisation process
		params ["_hvtLzPos", "_meetingPos", "_guardUnit1", "_mainHVT", "_guardUnit3", "_hvtGroup", "_hvtGuardGroup", "_iTaskIndex"];

		waitUntil {sleep 2; TREND_bAndSoItBegins && TREND_CustomObjectsSet && TREND_PlayersHaveLeftStartingArea};

		waitUntil { sleep 10; _playersInAO = false; { if (_meetingPos distance _x < 2000) exitWith { _playersInAO = true; }; } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits}); _playersInAO; };

		if !(TREND_bDebugMode) then {
			_iWait = (420 * (_iTaskIndex + 1)) + floor(random 300);
			sleep floor(random 120);
			_sMessageOne = format["%1 is due to arrive in the area at %2",name _mainHVT, (daytime  + (_iWait/3600) call BIS_fnc_timeToString)];
			[[west, "HQ"],_sMessageOne] remoteExec ["sideChat", 0];
			[_sMessageOne] call TREND_fnc_notifyGlobal;

			[_iWait, _iTaskIndex] spawn {
				params ["_duration", "_taskIndex"];
				_endTime = _duration + time;
				while {_endTime - time >= 0} do {
					_color = "#45f442";//green
					_timeLeft = _endTime - time;
					if (_timeLeft < 16) then {_color = "#eef441";};//yellow
					if (_timeLeft < 6) then {_color = "#ff0000";};//red
					if (_timeLeft < 0) exitWith {};
					_content = parseText format ["Time Until HVT is in AO: <t color='%1'>--- %2 ---</t>", _color, [(_timeLeft/3600),"HH:MM:SS"] call BIS_fnc_timeToString];
					[[_content, _duration + 1, _taskIndex, _taskIndex], {_this spawn TREND_fnc_handleNotification}] remoteExec ["call"]; // After the first run, this will only update the text for the notification with index = _taskIndex
				};
			};

			sleep _iWait;
		};

		_sMessageTwo = format["%1 is in the area and on way to AO (position is tracked and marked on map",name _mainHVT];
		[[west, "HQ"],_sMessageTwo] remoteExec ["sideChat", 0];
		[_sMessageTwo] call TREND_fnc_notifyGlobal;

		_hvtChopperStartPos = [-400,-400,200] getPos [400 * sqrt random 1, random 360];
		_hvtChopperStartPos = [_hvtChopperStartPos select 0,_hvtChopperStartPos select 1, selectRandom[150,160,170,180,190,200]];
		_hvtChopper = createVehicle [selectRandom HVTChoppers, _hvtChopperStartPos, [], 50, "FLY"];

		_sTargetNameHeli = format["objHVTChopper%1",_iTaskIndex]; //ignore that it is "objInformant", all objectives have this name, do not change this!
		_hvtChopper setVariable [_sTargetNameHeli, _hvtChopper, true];
		missionNamespace setVariable [_sTargetNameHeli, _hvtChopper];

		//_hvtChopper allowDamage false;



		_mainHVT assignAsDriver _hvtChopper;
		_mainHVT moveInDriver _hvtChopper;

		_guardUnit3 moveInAny _hvtChopper;
		_guardUnit3 disableAI "MOVE"; //for some reason, sometimes this guy will just stay in the water???
     	_guardUnit3 disableAI "FSM";

		_hvtChopper setPos _hvtChopperStartPos;
		sleep 1;
		_unitsAreInChopper = false;
		while {_unitsAreInChopper} do {
			if (vehicle _mainHVT != _mainHVT && vehicle _guardUnit3 != _guardUnit3) then {
				_unitsAreInChopper = true;
			}
			else {
				_mainHVT assignAsDriver _hvtChopper;
				_mainHVT moveInDriver _hvtChopper;
				sleep 1;
				_guardUnit3 moveInAny _hvtChopper;
				sleep 2;
			};
		};

		_mainHVT allowDamage true;
		_guardUnit3 allowDamage true;

		_mrkMeetingHVTMarker = nil;
		_mrkMeetingHVTMarker = createMarker [format["HVT%1",_iTaskIndex], getPos _hvtChopper];
		_mrkMeetingHVTMarker setMarkerShape "ICON";
		_mrkMeetingHVTMarker setMarkerType "o_inf";
		_mrkMeetingHVTMarker setMarkerText format["HVT %1",name(_mainHVT)];
		[_hvtChopper,_mrkMeetingHVTMarker] spawn {
			_hvtChopper = _this select 0;
			_mrkMeetingHVTMarker = _this select 1;
			while {alive _hvtChopper} do {
				_mrkMeetingHVTMarker setMarkerPos (getPos _hvtChopper);
				sleep 1;
			};
		};

		sleep 2;
		["HVT is on route to AO now!"] call TREND_fnc_notifyGlobal;

		_mainHVT setCaptive true;
		_guardUnit3 setCaptive true;

		_hvtGroup setSpeedMode "FULL";
		_hvtGroup setBehaviour "CARELESS";
		_hvtGuardGroup setSpeedMode "FULL";
		_hvtGuardGroup setBehaviour "CARELESS";

		_wpHvtMeet1 = _hvtGroup addWaypoint [getPos _mainHVT, 0];
		_wpHvtMeet2 = _hvtGroup addWaypoint [_hvtLzPos, 1];
		_wpHvtMeet3 = _hvtGroup addWaypoint [_hvtLzPos, 2];
		_wpHvtMeet4 = _hvtGroup addWaypoint [_hvtLzPos, 3];
		_wpHvtMeet5 = _hvtGroup addWaypoint [_hvtLzPos, 4];
		_wpHvtMeet5 setWaypointType "TR UNLOAD";
		_wpHvtMeet5 setWaypointType "GETOUT";
		_wpHvtMeet5 synchronizeWaypoint [_wpHvtMeet3];
		_wpHvtMeet6 = _hvtGroup addWaypoint [_meetingPos, 5];
		_wpHvtMeet7 = _hvtGroup addWaypoint [_meetingPos, 6];
		[_hvtGroup, 1] setWaypointSpeed "LIMITED";

		[_guardUnit3,_meetingPos] spawn {
       		_guardUnit3 = _this select 0;
       		_meetingPos = _this select 1;
       		_moveToPos = (_meetingPos) getPos [3,selectRandom[1, 95, 180, 270]];
       		_hvtGuardGroup = group _guardUnit3;
       		waitUntil {sleep 2; !alive(_guardUnit3) || isTouchingGround (vehicle _guardUnit3)};
       		_guardUnit3 enableAI "MOVE"; //for some reason, sometimes this guy will just stay in the water???
     		_guardUnit3 enableAI "FSM";
       		unassignVehicle _guardUnit3;
       		doGetOut _guardUnit3;
       		_wpHvtGuardMeet1 = _hvtGuardGroup addWaypoint [_moveToPos, 0];
       		[_hvtGuardGroup, 1] setWaypointSpeed "LIMITED";
   		};

		waitUntil {sleep 1; (currentWaypoint group _mainHVT) >= 6 };
		//sleep 5;
      	_hvtGroup setSpeedMode "LIMITED";
      	_hvtGroup setBehaviour "CARELESS";
		_hvtGuardGroup setSpeedMode "LIMITED";
      	_hvtGuardGroup setBehaviour "CARELESS";




		sleep 9;
		if (true)  then {
			[_guardUnit3] spawn {
				_guardUnit3 = _this select 0;
				_guardUnit3 switchMove "Acts_JetsCrewaidLCrouch_in";
				_guardUnit3 disableAI "anim";
				sleep 2.2;
				_guardUnit3 switchMove "Acts_JetsCrewaidLCrouch_out";
				_guardUnit3 enableAI "anim";
				sleep 3;
				_guardUnit3 switchMove "";
				_guardUnit3 call BIS_fnc_ambientAnim__terminate;
			};
		};


		//["waypoint wait"] call TREND_fnc_notify;
		_bWalkEnded = false;
		while {!_bWalkEnded} do {
			_distanceFromMeeting = (_mainHVT distance _guardUnit1);
			if (_distanceFromMeeting < 10) then {
				sleep 5; //give him some time to get as close to the meeting guy as possible
				_bWalkEnded = true;
			};
			if (speed _mainHVT == 0) then {
				sleep 2;
				if (speed _mainHVT == 0) then {
					_bWalkEnded = true; //if he has stopped walking, wait a second and see if he is still not walking
				};
			};
			sleep 0.5;
		};
		//["waypoint wait ended"] call TREND_fnc_notify;

       //waitUntil {sleep 1; (currentWaypoint group _mainHVT) == 9 };
       //waitUntil {sleep 1; speed _objMan == 0};

		_hvtGroup setBehaviour "SAFE";
		_hvtGuardGroup setBehaviour "SAFE";
       	[_mainHVT,_guardUnit1] spawn {
       		_guardUnit1 = _this select 1;
       		_doLoop = true;
       		while {_doLoop} do {
       			if (behaviour (_this select 0) == "combat" || !alive(_this select 0) || (TREND_TimeSinceLastSpottedAction > (call TREND_GetSpottedDelay))) then { //TREND_TimeSinceLastSpottedAction : is set to current time when it is called, cooldown is choosen in adv mission settings
	       			(_this select 0) call BIS_fnc_ambientAnim__terminate;
					(_this select 0) enableAI "anim";
					group (_this select 0) setSpeedMode "FULL";
					group (_this select 0) setBehaviour "CARELESS";
					_smoker = "SmokeShellRed" createVehicle (getpos _guardUnit1);
					_smoker setDamage 1;
					sleep 20;
       			};
       			if (!alive(_this select 0)) then {_doLoop = false};
       		}

		};
		[_guardUnit3,_guardUnit1] spawn {
			_guardUnit1 = _this select 1;
       		_doLoop = true;
       		while {_doLoop} do {
       			if (behaviour (_this select 0) == "combat" || !alive(_this select 0) || (TREND_TimeSinceLastSpottedAction > (call TREND_GetSpottedDelay))) then {
	       			(_this select 0) call BIS_fnc_ambientAnim__terminate;
					(_this select 0) enableAI "anim";
					group (_this select 0) setSpeedMode "FULL";
					group (_this select 0) setBehaviour "CARELESS";
					_smoker = "SmokeShellRed" createVehicle (getpos _guardUnit1);
					_smoker setDamage 1;
					sleep 20;
       			};
       			if (!alive(_this select 0)) then {_doLoop = false};
       		}
		};

		_distanceFromMeeting = (_mainHVT distance _guardUnit1);
		if (_distanceFromMeeting < 10) then {
			//talk to guy for 20 seconds, then head back to chopper
			_azimuth = _mainHVT getDir _guardUnit1;
			_mainHVT setDir _azimuth;
			_azimuth2 = _guardUnit1 getDir _mainHVT;
			_guardUnit1 setDir _azimuth2;

			_mainHVT call BIS_fnc_ambientAnim__terminate;
			_mainHVT playMoveNow "Acts_CivilTalking_2";
			_mainHVT disableAI "anim";

			_guardUnit1 call BIS_fnc_ambientAnim__terminate;
			_guardUnit1 playMoveNow "Acts_CivilListening_2";
			_guardUnit1 disableAI "anim";

			sleep 120;
			_mainHVT call BIS_fnc_ambientAnim__terminate;
			_mainHVT enableAI "anim";
			_guardUnit1 call BIS_fnc_ambientAnim__terminate;
			_guardUnit1 enableAI "anim";

		}
		else {
			//talk on radio, then head back to chopper
			_mainHVT call BIS_fnc_ambientAnim__terminate;
			_mainHVT playMoveNow "Acts_listeningToRadio_loop";
			_mainHVT disableAI "anim";
			sleep 10;
			_mainHVT enableAI "anim";
			_mainHVT playMoveNow "Acts_listeningToRadio_out";
		};
		while {(count (waypoints _hvtGroup)) > 0} do {
			deleteWaypoint ((waypoints _hvtGroup) select 0);
		};

		[_guardUnit3] joinSilent (_hvtGroup);

		_wpHvtLeaveMeet1 = _hvtGroup addWaypoint [getPos _hvtChopper, 0];
		_wpHvtLeaveMeet2 = _hvtGroup addWaypoint [getPos _hvtChopper, 0];
		[_hvtGroup, 1] setWaypointType "GETIN";
		_wpHvtLeaveMeet2 = _hvtGroup addWaypoint [[0,0,100], 0];
		_hvtGroup setBehaviour "CARELESS";
		waitUntil {sleep 2; !isTouchingGround _hvtChopper};

		sleep 120;
		if (alive(_mainHVT)) then {
			["He got away!"] call TREND_fnc_notify;
			[_mainHVT, "failed", "HVT Escaped", "HVT Escaped, rep lowered", 1] spawn TREND_fnc_updateTask;
		};
		sleep 5;

		if (alive(_mainHVT)) then {deletevehicle _mainHVT};
		if (alive(_guardUnit3)) then {deletevehicle _guardUnit3};
		deleteMarker _mrkMeetingHVTMarker;
		if (!isTouchingGround _hvtChopper) then {deletevehicle _hvtChopper;};
	};

	_guardUnit3 setVariable ["MainObjective", _mainHVT, true];
	_guardUnit3 addEventHandler ["Killed", {[(_guardUnit3 getVariable "MainObjective"), "failed", "Our agent was killed!!!", "You killed our agent! Rep lowered", 0.8] spawn TREND_fnc_updateTask; }];

	if (_bIsMainObjective) then { //if mainobjective (i.e. heavy mission or final campaign mission) we will require team to get document from corpse
		[_mainHVT, ["Take document",{(_this select 0) spawn TREND_fnc_updateTask;},[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
	}
	else { //if single mission or side then we can pass this task as soon as HVT is killed
		_mainHVT addEventHandler ["Killed", {(_this select 0) spawn TREND_fnc_updateTask;}];
	};

	_MissionTitle = format["Meeting Assassination: %1",name(_mainHVT)];	//you can adjust this here to change what shows as marker and task text
	_sTaskDescription = format[localize "STR_TRGM2_MeetingAssassinationMissionDescription",name(_mainHVT)]; //adjust this based on veh? and man? if van then if car then?
		//or just random description that will fit all situations??
	if (_bIsMainObjective) then {
		sTaskDescription = _sTaskDescription + "<br /><br />Once killed, search his body for the documents he is carrying!"
	};
	_sTaskDescription = _sTaskDescription + "<br /><br />!NOTE: we have an under cover agent flying in with our HVT, so watch your fire! Our agent will give a signal (tie his shoelace) to confirm his identity, but if you fail to see that, then you can confirm who the HVT is by who meets up and talks to they guy waiting at the AO.<br />Try not to get spotted before you take out the target, getting spotted will cause the HVT to run to the meeting and will have a smoke shield in place!";
};

//TEST ON SERVER!!!!!
//DONE//option for sneaky requirement !!! if they are in combat mode or enemy have spotted any players, they will run to meeting, smoke will be popped too, adn will run to choppper after meeting
//DONE//it doesnt matter who is in front when hvt leaves chopper, the hvt or agent could be either one 50/50

//write desciption for mission!!! include details of signal and hvt talking, be sneaky, etc...

//convoy mission??? (foot patrol or vehicle patrol)
//ADD THE talkinga nimation to the guys walking around at checkpont... and the HVT too
//animate guys at sentry with tent.... sitting, chiling, situps etc... (terminate ani if in combat mode)
