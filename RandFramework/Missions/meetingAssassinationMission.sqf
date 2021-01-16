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

	_firstGuardClass = selectRandom _HVTGuys;
	//_HVTGuys = _HVTGuys - InterogateOfficerClasses;
	_HVTGuys = _HVTGuys - [_firstGuardClass];
	_mainHVTClass = selectRandom _HVTGuys;
	_HVTGuys = _HVTGuys - [_mainHVTClass];
	_mainHVTGuardClass = selectRandom _HVTGuys;

	//TESTTEST = format ["TEST_ %1 - %2",_poshVehPos,getPosATL _objectiveMainBuilding];
	if ((_poshVehPos distance _objectiveMainBuilding) < 100) then {
		_objVehicle = selectRandom _meetingVehs createVehicle _poshVehPos;
		//_objVehicle setPos _poshVehPos;
		if (!isNil "_direction") then {
			_objVehicle setDir (_direction);
		};
		_guardUnit1 = (createGroup east) createUnit [_firstGuardClass,_poshVehPos,[],0,"NONE"];
	}
	else {
		_flatPos = nil;
		_flatPos = [getPos _objectiveMainBuilding, 10, 50, 5, 0, 0.5, 0,[],[getPos _objectiveMainBuilding,getPos _objectiveMainBuilding]] call TREND_fnc_findSafePos;
		if ((_flatPos select 0) > 0) then {
			_guardUnit1 = (createGroup east) createUnit [_firstGuardClass,_flatPos,[],0,"NONE"];
		}
		else {
			_guardUnit1 = (createGroup east) createUnit [_firstGuardClass,getPos _objectiveMainBuilding,[],20,"NONE"];
		};
	};
 	(group _guardUnit1) setBehaviour 'CARELESS';
 	_guardUnit1 setCaptive true;

 	_HVTGuys = _HVTGuys - InterogateOfficerClasses;
	_HVTGuys = _HVTGuys - [_firstGuardClass];

	//AidlPercMstpSnonWnonDnon_G03

	//hvtLzPosDebut = _hvtLzPos;
	//HVTChopperDebugLandedTest = (createGroup east) createUnit [selectRandom HVTChoppers,_hvtLzPos,[],5,"NONE"];
	//HVTChopperDebugLandedTest = selectRandom HVTChoppers createVehicle _hvtLzPos;
	//if airfield nearby, then will have HVT fly in plane (70% chance of it being a plane)
	//HVTChopperDebugLandedTest = createVehicle [selectRandom HVTChoppers, _hvtLzPos, [], 50, "NONE"];

	_mainHVT = nil;
	_guardUnit3 = nil;
	_hvtGroup = createGroup east;
	_hvtGuardGroup = createGroup east;
	//if (random 1 < .50) then { //so 50/50 who is leader, so we will have no idea which of these guys is our agent and which is the target!
	//	_mainHVT = _hvtGroup createUnit [_mainHVTClass,[-500,-500,0],[],20,"NONE"];
	//	sleep 0.1;
	//	_guardUnit3 = _hvtGuardGroup createUnit [_mainHVTGuardClass,[-500,-500,0],[],20,"NONE"];
	//}
	//else {
	//	_guardUnit3 = _hvtGuardGroup createUnit [_mainHVTGuardClass,[-500,-500,0],[],20,"NONE"];
	//	sleep 0.1;
	//	_mainHVT = _hvtGroup createUnit [_mainHVTClass,[-500,-500,0],[],20,"NONE"];
	//};

	_mainHVT = _hvtGroup createUnit [_mainHVTClass,[-500,-500,0],[],20,"NONE"];
	sleep 0.1;
	_guardUnit3 = _hvtGuardGroup createUnit [_mainHVTGuardClass,[-500,-500,0],[],20,"NONE"];

	_mainHVT allowDamage false;
	_guardUnit3 allowDamage false;

	_sTargetName = format["objInformant%1",_iTaskIndex]; //ignore that it is "objInformant", all objectives have this name, do not change this!
	_mainHVT setVariable [_sTargetName, _mainHVT, true];
	missionNamespace setVariable [_sTargetName, _mainHVT];

	_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
	_guardUnit3 setVariable [_sTargetName2, _guardUnit3, true];
	missionNamespace setVariable [_sTargetName2, _guardUnit3];

	_mainHVT setVariable ["taskStatus","",true];

	[_mainHVT, ["This is our target!","{[""This is our target""] call TREND_fnc_notify; }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
	[_guardUnit3, ["This is our friendly agent!","{[""This is our target""] call TREND_fnc_notify; }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];


	sleep 1;
	[_hvtLzPos, getPos _guardUnit1,_guardUnit1,_mainHVT,_guardUnit3,_hvtGroup,_hvtGuardGroup,_iTaskIndex] spawn { //spawn script so we can have timer that will action our mission movements without pausing the main initialisation process
		_thisHvtLzPos = _this select 0;
		_thisMeetingPos = _this select 1;
		_thisGuardUnit1 = _this select 2;
		_thisMainHVT = _this select 3;
		_thisGuardUnit3 = _this select 4;
		_hvtGroup = _this select 5;
		_hvtGuardGroup = _this select 6;
		_iTaskIndex = _this select 7;

		waitUntil {sleep 2; TREND_bAndSoItBegins && TREND_CustomObjectsSet && TREND_PlayersHaveLeftStartingArea};
		//["debug: wait started"] remoteExecCall ["Hint", 0];

		waitUntil { sleep 10; _playersInAO = false; { if (_thisMeetingPos distance _x < 2000) exitWith { _playersInAO = true; }; } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits}); _playersInAO; };

		_iWait = (420 * (_iTaskIndex + 1)) + floor(random 300);
		sleep floor(random 120);
		_sMessageOne = format["%1 is due to arrive in the area at %2",name _thisMainHVT, (daytime  + (_iWait/3600) call BIS_fnc_timeToString)];
		[[west, "HQ"],_sMessageOne] remoteExec ["sideChat", 0];
		[_sMessageOne] remoteExecCall ["Hint", 0];

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

		_sMessageTwo = format["%1 is in the area and on way to AO (position is tracked and marked on map",name _thisMainHVT];
		[[west, "HQ"],_sMessageTwo] remoteExec ["sideChat", 0];
		[_sMessageTwo] remoteExecCall ["Hint", 0];

		_hvtChopperStartPos = [-400,-400,200] getPos [400 * sqrt random 1, random 360];
		_hvtChopperStartPos = [_hvtChopperStartPos select 0,_hvtChopperStartPos select 1, selectRandom[150,160,170,180,190,200]];
		_hvtChopper = createVehicle [selectRandom HVTChoppers, _hvtChopperStartPos, [], 50, "FLY"];

		_sTargetNameHeli = format["objHVTChopper%1",_iTaskIndex]; //ignore that it is "objInformant", all objectives have this name, do not change this!
		_hvtChopper setVariable [_sTargetNameHeli, _hvtChopper, true];
		missionNamespace setVariable [_sTargetNameHeli, _hvtChopper];

		//_hvtChopper allowDamage false;



		_thisMainHVT assignAsDriver _hvtChopper;
		_thisMainHVT moveInDriver _hvtChopper;

		_thisGuardUnit3 moveInAny _hvtChopper;
		//_thisGuardUnit3 moveInCargo _hvtChopper;
		//_thisGuardUnit3 assignAsCargo _hvtChopper;

		_thisGuardUnit3 disableAI "MOVE"; //for some reason, sometimes this guy will just stay in the water???
     	_thisGuardUnit3 disableAI "FSM";

		_hvtChopper setPos _hvtChopperStartPos;
		sleep 1;
		_unitsAreInChopper = false;
		while {_unitsAreInChopper} do {
			if (vehicle _thisMainHVT != _thisMainHVT && vehicle _thisGuardUnit3 != _thisGuardUnit3) then {
				_unitsAreInChopper = true;
			}
			else {
				_thisMainHVT assignAsDriver _hvtChopper;
				_thisMainHVT moveInDriver _hvtChopper;
				sleep 1;
				_thisGuardUnit3 moveInAny _hvtChopper;
				//_thisGuardUnit3 moveInCargo _hvtChopper;
				//_thisGuardUnit3 assignAsCargo _hvtChopper;
				sleep 2;
			};
		};
		//["debug: should all be in"] remoteExecCall ["Hint", 0];

		_thisMainHVT allowDamage true;
		_thisGuardUnit3 allowDamage true;

		_mrkMeetingHVTMarker = nil;
		_mrkMeetingHVTMarker = createMarker [format["HVT%1",_iTaskIndex], getPos _hvtChopper];
		_mrkMeetingHVTMarker setMarkerShape "ICON";
		_mrkMeetingHVTMarker setMarkerType "o_inf";
		_mrkMeetingHVTMarker setMarkerText format["HVT %1",name(_thisMainHVT)];
		[_hvtChopper,_mrkMeetingHVTMarker] spawn {
			_thisHvtChopper = _this select 0;
			_thisMrkMeetingHVTMarker = _this select 1;
			while {alive _thisHvtChopper} do {
				_thisMrkMeetingHVTMarker setMarkerPos (getPos _thisHvtChopper);
				sleep 1;
			};
		};

		sleep 2;
		["HVT is on route to AO now!"] remoteExecCall ["Hint", 0];

		_thisMainHVT setCaptive true;
		_thisGuardUnit3 setCaptive true;

		_hvtGroup setSpeedMode "FULL";
		_hvtGroup setBehaviour "CARELESS";
		_hvtGuardGroup setSpeedMode "FULL";
		_hvtGuardGroup setBehaviour "CARELESS";

		_wpHvtMeet1 = _hvtGroup addWaypoint [getPos _thisMainHVT, 0];
		_wpHvtMeet2 = _hvtGroup addWaypoint [_thisHvtLzPos, 1];
		_wpHvtMeet3 = _hvtGroup addWaypoint [_thisHvtLzPos, 2];
		_wpHvtMeet4 = _hvtGroup addWaypoint [_thisHvtLzPos, 3];
		_wpHvtMeet5 = _hvtGroup addWaypoint [_thisHvtLzPos, 4];
		_wpHvtMeet5 setWaypointType "TR UNLOAD";
		_wpHvtMeet5 setWaypointType "GETOUT";
		_wpHvtMeet5 synchronizeWaypoint [_wpHvtMeet3];
		_wpHvtMeet6 = _hvtGroup addWaypoint [_thisMeetingPos, 5];
		_wpHvtMeet7 = _hvtGroup addWaypoint [_thisMeetingPos, 6];
		[_hvtGroup, 1] setWaypointSpeed "LIMITED";

		[_thisGuardUnit3,_thisMeetingPos] spawn {
       		_thisGuardUnit3 = _this select 0;
       		_thisMeetingPos = _this select 1;
       		_moveToPos = (_thisMeetingPos) getPos [3,selectRandom[1, 95, 180, 270]];
       		_hvtGuardGroup = group _thisGuardUnit3;
       		waitUntil {sleep 2; !alive(_thisGuardUnit3) || isTouchingGround (vehicle _thisGuardUnit3)};
       		_thisGuardUnit3 enableAI "MOVE"; //for some reason, sometimes this guy will just stay in the water???
     		_thisGuardUnit3 enableAI "FSM";
       		unassignVehicle _thisGuardUnit3;
       		doGetOut _thisGuardUnit3;
       		_wpHvtGuardMeet1 = _hvtGuardGroup addWaypoint [_moveToPos, 0];
       		[_hvtGuardGroup, 1] setWaypointSpeed "LIMITED";
   		};

		waitUntil {sleep 1; (currentWaypoint group _thisMainHVT) >= 6 };
		//sleep 5;
      	_hvtGroup setSpeedMode "LIMITED";
      	_hvtGroup setBehaviour "CARELESS";
		_hvtGuardGroup setSpeedMode "LIMITED";
      	_hvtGuardGroup setBehaviour "CARELESS";




		sleep 9;
		if (true)  then {
			[_thisGuardUnit3] spawn {
				_thisGuardUnit3 = _this select 0;
				_thisGuardUnit3 switchMove "Acts_JetsCrewaidLCrouch_in";
				_thisGuardUnit3 disableAI "anim";
				sleep 2.2;
				_thisGuardUnit3 switchMove "Acts_JetsCrewaidLCrouch_out";
				_thisGuardUnit3 enableAI "anim";
				sleep 3;
				_thisGuardUnit3 switchMove "";
				_thisGuardUnit3 call BIS_fnc_ambientAnim__terminate;
			};
		};


		//["waypoint wait"] call TREND_fnc_notify;
		_bWalkEnded = false;
		while {!_bWalkEnded} do {
			_distanceFromMeeting = (_thisMainHVT distance _thisGuardUnit1);
			if (_distanceFromMeeting < 10) then {
				sleep 5; //give him some time to get as close to the meeting guy as possible
				_bWalkEnded = true;
			};
			if (speed _thisMainHVT == 0) then {
				sleep 2;
				if (speed _thisMainHVT == 0) then {
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
       	[_thisMainHVT,_thisGuardUnit1] spawn {
       		_thisGuardUnit1 = _this select 1;
       		_doLoop = true;
       		while {_doLoop} do {
       			if (behaviour (_this select 0) == "combat" || !alive(_this select 0) || (TREND_TimeSinceLastSpottedAction > (call TREND_GetSpottedDelay))) then { //TREND_TimeSinceLastSpottedAction : is set to current time when it is called, cooldown is choosen in adv mission settings
	       			(_this select 0) call BIS_fnc_ambientAnim__terminate;
					(_this select 0) enableAI "anim";
					group (_this select 0) setSpeedMode "FULL";
					group (_this select 0) setBehaviour "CARELESS";
					_smoker = "SmokeShellRed" createVehicle (getpos _thisGuardUnit1);
					_smoker setDamage 1;
					sleep 20;
       			};
       			if (!alive(_this select 0)) then {_doLoop = false};
       		}

		};
		[_thisGuardUnit3,_thisGuardUnit1] spawn {
			_thisGuardUnit1 = _this select 1;
       		_doLoop = true;
       		while {_doLoop} do {
       			if (behaviour (_this select 0) == "combat" || !alive(_this select 0) || (TREND_TimeSinceLastSpottedAction > (call TREND_GetSpottedDelay))) then {
	       			(_this select 0) call BIS_fnc_ambientAnim__terminate;
					(_this select 0) enableAI "anim";
					group (_this select 0) setSpeedMode "FULL";
					group (_this select 0) setBehaviour "CARELESS";
					_smoker = "SmokeShellRed" createVehicle (getpos _thisGuardUnit1);
					_smoker setDamage 1;
					sleep 20;
       			};
       			if (!alive(_this select 0)) then {_doLoop = false};
       		}
		};

		_distanceFromMeeting = (_thisMainHVT distance _thisGuardUnit1);
		if (_distanceFromMeeting < 10) then {
			//talk to guy for 20 seconds, then head back to chopper
			_azimuth = _thisMainHVT getDir _thisGuardUnit1;
			_thisMainHVT setDir _azimuth;
			_azimuth2 = _thisGuardUnit1 getDir _thisMainHVT;
			_thisGuardUnit1 setDir _azimuth2;

			_thisMainHVT call BIS_fnc_ambientAnim__terminate;
			_thisMainHVT playMoveNow "Acts_CivilTalking_2";
			_thisMainHVT disableAI "anim";

			_thisGuardUnit1 call BIS_fnc_ambientAnim__terminate;
			_thisGuardUnit1 playMoveNow "Acts_CivilListening_2";
			_thisGuardUnit1 disableAI "anim";

			sleep 120;
			_thisMainHVT call BIS_fnc_ambientAnim__terminate;
			_thisMainHVT enableAI "anim";
			_thisGuardUnit1 call BIS_fnc_ambientAnim__terminate;
			_thisGuardUnit1 enableAI "anim";

		}
		else {
			//talk on radio, then head back to chopper
			_thisMainHVT call BIS_fnc_ambientAnim__terminate;
			_thisMainHVT playMoveNow "Acts_listeningToRadio_loop";
			_thisMainHVT disableAI "anim";
			sleep 10;
			_thisMainHVT enableAI "anim";
			_thisMainHVT playMoveNow "Acts_listeningToRadio_out";
		};
		while {(count (waypoints _hvtGroup)) > 0} do {
			deleteWaypoint ((waypoints _hvtGroup) select 0);
		};

		[_thisGuardUnit3] joinSilent (_hvtGroup);

		_wpHvtLeaveMeet1 = _hvtGroup addWaypoint [getPos _hvtChopper, 0];
		_wpHvtLeaveMeet2 = _hvtGroup addWaypoint [getPos _hvtChopper, 0];
		[_hvtGroup, 1] setWaypointType "GETIN";
		_wpHvtLeaveMeet2 = _hvtGroup addWaypoint [[0,0,100], 0];
		_hvtGroup setBehaviour "CARELESS";
		waitUntil {sleep 2; !isTouchingGround _hvtChopper};

		sleep 120;
		if (alive(_thisMainHVT)) then {
			["He got away!"] call TREND_fnc_notify;
			_thisMainHVT setVariable ["taskStatus","ESCAPED",true];
		};
		sleep 5;

		if (alive(_thisMainHVT)) then {deletevehicle _thisMainHVT};
		if (alive(_thisGuardUnit3)) then {deletevehicle _thisGuardUnit3};
		deleteMarker _mrkMeetingHVTMarker;
		if (!isTouchingGround _hvtChopper) then {deletevehicle _hvtChopper;};
	};

//[0.2,format["Paramedic Killed by %1", name _killer]] spawn TREND_fnc_AdjustBadPoints;
//TREND_fnc_AdjustMaxBadPoints << increase max bad poins which increases our rep

	_guardUnit3 addEventHandler ["Killed", {(_this select 0) setVariable ["taskStatus","KILLED",true] }];

	if (_bIsMainObjective) then { //if mainobjective (i.e. heavy mission or final campaign mission) we will require team to get document from corpse
		[_mainHVT, ["Take document",{(_this select 0) setVariable ["taskStatus","DOCTAKEN",true]},[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
	}
	else { //if single mission or side then we can pass this task as soon as HVT is killed
		_mainHVT addEventHandler ["Killed", {(_this select 0) setVariable ["taskStatus","KILLED",true]; }];
	};

	//waitUntil {sleep 2; ((_mainHVT getVariable ["taskStatus",false]) != "" || !alive(_mainHVT))};

	//sleep 1; //give enough time for variable to be set against mainHVT if he was killed (i check if he is alive too, as if for some reason this unit is deleted and no variable set against him, i will need to make sure these waituntil loops are not just hanging around the entire mission)

	//_taskState = _thisMainHVT getVariable ["taskStatus",""];

	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];
	_customTaskFailed = nil;
	_customTaskFailed = createTrigger ["EmptyDetector", [0,0]];
	_customTaskFailed setVariable ["DelMeOnNewCampaignDay",true];
	_customTaskEscaped = nil;
	_customTaskEscaped = createTrigger ["EmptyDetector", [0,0]];
	_customTaskEscaped setVariable ["DelMeOnNewCampaignDay",true];

	if (!_bCreateTask) then {
		_sAliveCheck = format["%1 getVariable [""taskStatus"",""""] == ""KILLED"" ",_sTargetName];
		_customTaskClear setTriggerStatements [_sAliveCheck, " [1, ""Killed HVT at meeting""] spawn TREND_fnc_AdjustMaxBadPoints; [(""HVT Killed, rep increased"")] call TREND_fnc_notify; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", ""];

		_sAliveCheck2 = format["%1 getVariable [""taskStatus"",""""] == ""KILLED""",_sTargetName2];
		_customTaskFailed setTriggerStatements [_sAliveCheck2, " [0.8, ""our agent was killed!!!""] spawn TREND_fnc_AdjustBadPoints; [(""You killed our agent! Rep lowered"")] call TREND_fnc_notify; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", ""];

		//decided not to adjust rep if he escapes when no task cretaed, as this is means it's an optional task
		//_sAliveCheck3 = format["""%1"" == ""ESCAPED"" ",_taskState];
		//_customTaskEscaped setTriggerStatements [_sAliveCheck3, " [0.8, ""He got away!!!""] spawn TREND_fnc_AdjustBadPoints; [(""HVT Escaped"")] call TREND_fnc_notify; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", ""];
	}
	else {
		_sAliveCheck = format["(%1 getVariable [""taskStatus"",""""] == ""KILLED"" || (%1 getVariable [""taskStatus"",""""] == ""DOCTAKEN"")) && !([""InfSide%2""] call FHQ_fnc_ttAreTasksCompleted)",_sTargetName,_iTaskIndex];
		//TESTTEST = _sAliveCheck;
		//"objInformant0 getVariable [""taskStatus"",""""] == ""KILLED"" && !([""InfSide0""] call FHQ_fnc_ttAreTasksCompleted)"
		_sTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_iTaskIndex];
		_customTaskClear setTriggerStatements [_sAliveCheck, _sTaskComplete, ""];
		_sAliveCheck2 = format["(%1 getVariable [""taskStatus"",""""] == ""KILLED"")",_sTargetName2];
		_sTaskFail = format["[""InfSide%1"", ""failed""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_iTaskIndex];
		_customTaskFailed setTriggerStatements [_sAliveCheck2, _sTaskFail, ""];

		_sAliveCheck3 = format["%1 getVariable [""taskStatus"",""""] == ""ESCAPED"" ",_sTargetName];
		_sTaskFail2 = format["[""InfSide%1"", ""failed""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_iTaskIndex];
		_customTaskEscaped setTriggerStatements [_sAliveCheck3, _sTaskFail2, ""];
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
