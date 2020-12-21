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
	_MissionTitle = "Ambush Convoy"; //this is what shows in dialog mission selection
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

	[_markerType, _objectiveMainBuilding, _centralAO_x, _centralAO_y, _roadSearchRange, _bCreateTask, _iTaskIndex, _bIsMainObjective, _args] spawn {
		params ["_thismarkerType","_thisobjectiveMainBuilding","_thiscentralAO_x","_thiscentralAO_y","_thisroadSearchRange", "_thisbCreateTask", "_thisiTaskIndex", "_thisbIsMainObjective", ["_thisargs", []]];

		_poshVehPos = nil;
		_nearestRoad = nil;
		_direction = nil;
		_nearestRoad = [getPos _thisobjectiveMainBuilding, _thisroadSearchRange, []] call BIS_fnc_nearestRoad;
		_roadConnectedTo = roadsConnectedTo _nearestRoad;
		if (count _roadConnectedTo > 0) then {
			_connectedRoad = _roadConnectedTo select 0;
			_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
			_poshVehPos = getPos _nearestRoad;
		}
		else {
			_flatPos = nil;
			_flatPos = [getPos _thisobjectiveMainBuilding, 10, 100, 10, 0, 0.3, 0,[],[getPos _thisobjectiveMainBuilding,getPos _thisobjectiveMainBuilding]] call TREND_fnc_findSafePos;
			_poshVehPos = _flatPos;
		};

		_convoyStartPosition = [0,0,0];
		while {_convoyStartPosition select 0 isEqualTo 0 && _convoyStartPosition select 1 isEqualTo 0} do {
			_convoyStartPosition = [[[getPos _thisobjectiveMainBuilding, 3000]], ["water"], {isOnRoad _this && ((getPos _thisobjectiveMainBuilding) distance _this) > 2000}] call BIS_fnc_randomPos;
		};
		_convoyNearestRoad = [_convoyStartPosition, _thisroadSearchRange, []] call BIS_fnc_nearestRoad;
		_convoyRoadsConnected = roadsConnectedTo _convoyNearestRoad;
		if (count _convoyRoadsConnected > 0) then {
			_convoyConnectedRoad = _convoyRoadsConnected select 0;
			_convoyDirection = [_convoyNearestRoad, _convoyConnectedRoad] call BIS_fnc_DirTo;
			_convoyStartPosition = getPos _convoyNearestRoad;
		}
		else {
			_flatPos = nil;
			_flatPos = [_convoyStartPosition, 10, 100, 10, 0, 0.3, 0,[],[_convoyStartPosition,_convoyStartPosition]] call TREND_fnc_findSafePos;
			_convoyStartPosition = _flatPos;
		};

		_convoyStopPositons = [];
		convoyPath = [];
		(calculatePath ["wheeled_APC","safe",_convoyStartPosition,_poshVehPos]) addEventHandler ["PathCalculated", {
			{
				convoyPath pushBack _x;
			} forEach (_this select 1);
		}];

		waitUntil { count convoyPath > 0; };

		{
			if (_forEachIndex mod 25 isEqualTo 0) then {
				private _stopPosition = _x;
				_convoyStopPositons pushBack _stopPosition;
				private _stopMarker = createMarker [format["ConvoyStop%1_%2",count _convoyStopPositons,_thisiTaskIndex], _stopPosition];
				_stopMarker setMarkerShape "ICON";
				_stopMarker setMarkerType "mil_marker";
				_stopMarker setMarkerText format["Convoy Stop %1", count _convoyStopPositons];
			};
		} forEach convoyPath;

		waitUntil {TREND_bAndSoItBegins && TREND_CustomObjectsSet && TREND_PlayersHaveLeftStartingArea};

		if (!TREND_bDebugMode) then {
			_iWait = 420 + floor(random 300);
			sleep floor(random 120);
			_sMessageOne = format["The convoy is due to depart at %1", (daytime  + (_iWait/3600) call BIS_fnc_timeToString)];
			[[west, "HQ"],_sMessageOne] remoteExec ["sideChat", 0];
			[_sMessageOne] remoteExecCall ["Hint", 0];
		};

		_convoyVehicleClasses = [call sTank1ArmedCar, selectRandom (call UnarmedScoutVehicles), selectRandom (call UnarmedScoutVehicles), selectRandom (call UnarmedScoutVehicles), call sTank1ArmedCar];
		_HVTGuys = InformantClasses + InterogateOfficerClasses + WeaponDealerClasses;
		_mainHVTClass = selectRandom _HVTGuys;
		_HVTGuys = _HVTGuys - [_mainHVTClass];
		_meetingVehs = (HVTCars + HVTVans) select {getNumber(configFile >> "CfgVehicles" >> _x >> "transportSoldier") >= 3};

		_convoyArr = [EAST, _convoyVehicleClasses, _convoyStartPosition, _poshVehPos, _mainHVTClass, selectRandom _meetingVehs, [selectRandom _HVTGuys, selectRandom _HVTGuys], _convoyStopPositons] call TREND_fnc_createConvoy;
		_convoyArr params ["_hvtGroup", "_convoyVehicles", "_hvtVehicle", "_mainHVT", "_finalwp"];

		_sTargetName = format["objInformant%1",_thisiTaskIndex]; //ignore that it is "objInformant", all objectives have this name, do not change this!
		_mainHVT setVariable [_sTargetName, _mainHVT, true];
		missionNamespace setVariable [_sTargetName, _mainHVT];

		_guardUnit3 = selectRandom ((crew vehicle _mainHVT - [_mainHVT, driver vehicle _mainHVT]) select {typeOf(_x) in (InformantClasses + InterogateOfficerClasses + WeaponDealerClasses)});
		_sTargetName2 = format["objInformant2_%1",_thisiTaskIndex];
		_guardUnit3 setVariable [_sTargetName2, _guardUnit3, true];
		missionNamespace setVariable [_sTargetName2, _guardUnit3];

		_mainHVT setVariable ["taskStatus","",true];

		[_mainHVT, ["This is our target!","{hint ""This is our target"" }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
		[_guardUnit3, ["This is our friendly agent!","{hint ""This is our friendly agent!"" }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];

		_mainHVT setCaptive true;
		_guardUnit3 setCaptive true;

		_mrkMeetingHVTMarker = nil;
		_mrkMeetingHVTMarker = createMarker [format["HVT%1",_thisiTaskIndex], getPos _hvtVehicle];
		_mrkMeetingHVTMarker setMarkerShape "ICON";
		_mrkMeetingHVTMarker setMarkerType "o_inf";
		_mrkMeetingHVTMarker setMarkerText format["HVT %1",name(_mainHVT)];
		[_hvtVehicle,_mrkMeetingHVTMarker] spawn {
			_thisHvtVehicle = _this select 0;
			_thisMrkMeetingHVTMarker = _this select 1;
			while {alive _thisHvtVehicle} do {
				_thisMrkMeetingHVTMarker setMarkerPos (getPos _thisHvtVehicle);
				sleep 1;
			};
		};

		_sMessageTwo = format["%1 is in the area and on way to AO (position is tracked and marked on map",name _mainHVT];
		[[west, "HQ"],_sMessageTwo] remoteExec ["sideChat", 0];
		[_sMessageTwo] remoteExecCall ["Hint", 0];

		[_guardUnit3] spawn {
			_thisGuardUnit3 = _this select 0;
			waitUntil { vehicle _thisGuardUnit3 == _thisGuardUnit3; };
			_thisGuardUnit3 switchMove "Acts_JetsCrewaidLCrouch_in";
			_thisGuardUnit3 disableAI "anim";
			sleep 2.2;
			_thisGuardUnit3 switchMove "Acts_JetsCrewaidLCrouch_out";
			_thisGuardUnit3 enableAI "anim";
			sleep 3;
			_thisGuardUnit3 switchMove "";
			_thisGuardUnit3 call BIS_fnc_ambientAnim__terminate;
		};

		_guardUnit3 addEventHandler ["Killed", {(_this select 0) setVariable ["taskStatus","KILLED",true] }];

		[_mainHVT, _thisiTaskIndex, _thisbIsMainObjective] spawn {
			_thisHVT = _this select 0;
			_thisTaskIndex = _this select 1;
			_thisIsMainObjective = _this select 2;
			while {alive _thisHVT} do {
				_thisHVTTrigger = _thisHVT getVariable "TREND_hvtTrigger";
				if (!isNil "_thisHVTTrigger") then {
					deleteVehicle _thisHVTTrigger;
				};
				_thisHVTTrigger = nil;
				_thisHVTTrigger = createTrigger ["EmptyDetector", getPos _thisHVT];
				_thisHVTTrigger setVariable ["DelMeOnNewCampaignDay",true];
				_thisHVTTrigger setTriggerArea [1250, 1250, 0, false];
				_thisHVTTrigger setTriggerActivation [TREND_FriendlySideString, format["%1 D", TREND_EnemySideString], true];
				_thisHVTTrigger setTriggerStatements ["this && {(time - TREND_TimeSinceLastSpottedAction) > (call TREND_GetSpottedDelay)}", format["nul = [%1, %2, %3, thisTrigger, thisList] spawn TREND_fnc_CallNearbyPatrol;",getPos _mainHVT,_thisTaskIndex, _thisIsMainObjective], ""];
				_thisHVT setVariable ["TREND_hvtTrigger", _thisHVTTrigger, true];
				sleep 60;
			};
		};

		if (_thisbIsMainObjective) then { //if mainobjective (i.e. heavy mission or final campaign mission) we will require team to get document from corpse
			[_mainHVT, ["Take document",{(_this select 0) setVariable ["taskStatus","DOCTAKEN",true]},[_thisiTaskIndex,_thisbCreateTask],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
		}
		else { //if single mission or side then we can pass this task as soon as HVT is killed
			_mainHVT addEventHandler ["Killed", {(_this select 0) setVariable ["taskStatus","KILLED",true]; }];
		};

		_customTaskClear = nil;
		_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
		_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];
		_customTaskFailed = nil;
		_customTaskFailed = createTrigger ["EmptyDetector", [0,0]];
		_customTaskFailed setVariable ["DelMeOnNewCampaignDay",true];
		_customTaskEscaped = nil;
		_customTaskEscaped = createTrigger ["EmptyDetector", [0,0]];
		_customTaskEscaped setVariable ["DelMeOnNewCampaignDay",true];

		if (!_thisbCreateTask) then {
			_sAliveCheck = format["%1 getVariable [""taskStatus"",""""] == ""KILLED"" ",_sTargetName];
			_customTaskClear setTriggerStatements [_sAliveCheck, " [1, ""Killed HVT at meeting""] spawn TREND_fnc_AdjustMaxBadPoints; Hint (""HVT Killed, rep increased""); TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant" + str(_thisiTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", ""];

			_sAliveCheck2 = format["%1 getVariable [""taskStatus"",""""] == ""KILLED""",_sTargetName2];
			_customTaskFailed setTriggerStatements [_sAliveCheck2, " [0.8, ""our agent was killed!!!""] spawn TREND_fnc_AdjustBadPoints; Hint (""You killed our agent! Rep lowered""); TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant" + str(_thisiTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", ""];
		} else {
			_sAliveCheck = format["(%1 getVariable [""taskStatus"",""""] == ""KILLED"" || (%1 getVariable [""taskStatus"",""""] == ""DOCTAKEN"")) && !([""InfSide%2""] call FHQ_fnc_ttAreTasksCompleted)",_sTargetName,_thisiTaskIndex];
			_sTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_thisiTaskIndex];
			_customTaskClear setTriggerStatements [_sAliveCheck, _sTaskComplete, ""];
			_sAliveCheck2 = format["(%1 getVariable [""taskStatus"",""""] == ""KILLED"")",_sTargetName2];
			_sTaskFail = format["[""InfSide%1"", ""failed""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_thisiTaskIndex];
			_customTaskFailed setTriggerStatements [_sAliveCheck2, _sTaskFail, ""];

			_sAliveCheck3 = format["%1 getVariable [""taskStatus"",""""] == ""ESCAPED"" ",_sTargetName];
			_sTaskFail2 = format["[""InfSide%1"", ""failed""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_thisiTaskIndex];
			_customTaskEscaped setTriggerStatements [_sAliveCheck3, _sTaskFail2, ""];
		};
	};

	_MissionTitle = "Ambush Convoy";	//you can adjust this here to change what shows as marker and task text
	_sTaskDescription = "Intel has confirmed that our target is on route to the AO marked on the map. The HVT is moving with a convoy into the area! We need this HVT terminated!";
		//adjust this based on veh? and man? if van then if car then?
		//or just random description that will fit all situations??
	if (_bIsMainObjective) then {
		sTaskDescription = _sTaskDescription + "<br /><br />Once killed, search his body for the documents he is carrying!"
	};
	_sTaskDescription = _sTaskDescription + "<br /><br />!NOTE: We have an under cover agent in the vehicle with our HVT, so watch your fire! Our agent will give a signal (tie his shoelace) to confirm his identity.";
	_sTaskDescription = _sTaskDescription + "<br /><br />TIP: Shoot the driver to make the convoy stop and everyone get out of the vehicle.";
};

//TEST ON SERVER!!!!!
//DONE//option for sneaky requirement !!! if they are in combat mode or enemy have spotted any players, they will run to meeting, smoke will be popped too, adn will run to choppper after meeting
//DONE//it doesnt matter who is in front when hvt leaves chopper, the hvt or agent could be either one 50/50

//write desciption for mission!!! include details of signal and hvt talking, be sneaky, etc...

//convoy mission??? (foot patrol or vehicle patrol)
//ADD THE talkinga nimation to the guys walking around at checkpont... and the HVT too
//animate guys at sentry with tent.... sitting, chiling, situps etc... (terminate ani if in combat mode)
