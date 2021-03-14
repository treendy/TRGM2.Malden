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
	 * _bIsMainObjective 		: DO NOT EDIT THIS VALUE (this is determined by the engine, and is the boolean if the mission is a Heavy or Standard mission!)
	 * _args 					: These are additional arguments that might be required for the mission, for an example, see the Destroy Vehicles Mission.
	 * --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	*/
	params ["_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];
	if (_markerType != "empty") then { _markerType = "hd_unknown"; }; // Set marker type here...

	private _hasInformant = random 1 < .50;

	[_hasInformant, _markerType, _objectiveMainBuilding, _centralAO_x, _centralAO_y, _roadSearchRange, _bCreateTask, _iTaskIndex, _bIsMainObjective, _args] spawn {
		params ["_hasInformant", "_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];

		_poshVehPos = nil;
		_nearestRoad = nil;
		_direction = nil;
		_nearestRoad = [getPos _objectiveMainBuilding, _roadSearchRange, []] call BIS_fnc_nearestRoad;
		_roadConnectedTo = roadsConnectedTo _nearestRoad;
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

		_convoyStartPosition = [0,0,0];
		while {_convoyStartPosition select 0 isEqualTo 0 && _convoyStartPosition select 1 isEqualTo 0} do {
			_convoyStartPosition = [[[getPos _objectiveMainBuilding, 3000]], ["water"], {isOnRoad _this && ((getPos _objectiveMainBuilding) distance _this) > 2000}] call BIS_fnc_randomPos;
		};
		_convoyNearestRoad = [_convoyStartPosition, _roadSearchRange, []] call BIS_fnc_nearestRoad;
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

		waitUntil { sleep 2; count convoyPath > 0; };

		{
			if (_forEachIndex mod 25 isEqualTo 0) then {
				private _stopPosition = _x;
				_convoyStopPositons pushBack _stopPosition;
				private _stopMarker = createMarker [format["ConvoyStop%1_%2",count _convoyStopPositons,_iTaskIndex], _stopPosition];
				_stopMarker setMarkerShape "ICON";
				_stopMarker setMarkerType "mil_marker";
				_stopMarker setMarkerText format["Convoy Stop %1", count _convoyStopPositons];
			};
		} forEach convoyPath;

		convoyPath = nil;

		_convoyVehicleClasses = [call sTank1ArmedCar, selectRandom (call UnarmedScoutVehicles), selectRandom (call UnarmedScoutVehicles), selectRandom (call UnarmedScoutVehicles), call sTank1ArmedCar];
		_HVTGuys = InformantClasses + InterogateOfficerClasses + WeaponDealerClasses;
		_mainHVTClass = selectRandom _HVTGuys;
		_HVTGuys = _HVTGuys - [_mainHVTClass];
		_meetingVehs = (HVTCars + HVTVans) select {getNumber(configFile >> "CfgVehicles" >> _x >> "transportSoldier") >= 3};
		_convoySpeed = 40;
		_convoySeperation = 25;
		_pushThrough = true;

		_convoyArr = [
			EAST, // Side of created convoy group
			_convoyVehicleClasses, // Classnames of vehicles to create for convoy (size of this array is also the number of vehicles created)
			_convoyStartPosition, // Spawn position of convoy
			_poshVehPos, // Final destination of convoy
			_mainHVTClass, // Classname of HVT unit
			selectRandom _meetingVehs, // Classname of HVT car
			[selectRandom _HVTGuys, selectRandom _HVTGuys], // Classnames of HVT guards (size of this array is also the number of guards created for HVT, NOTE: Driver is not a "guard" so a safe number of guards is two because we're using vehicles that can hold at least 3 passengers. In this case, two guards and the hvt!)
			_convoyStopPositons, // Additional positions the convoy should move through (using the calculatePath function above allows these to be "natural" points the convoy would drive through)
			_convoySpeed, // Top speed of the convoy
			_convoySeperation, // Distance between convoy vehicles
			_pushThrough // Whether the convoy should stop driving if they encounter contact
		] call TREND_fnc_createConvoy;
		_convoyArr params ["_hvtGroup", "_convoyVehicles", "_hvtVehicle", "_mainHVT", "_finalwp"];

		_sTargetName = format["objInformant%1",_iTaskIndex]; //ignore that it is "objInformant", all objectives have this name, do not change this!
		_mainHVT setVariable [_sTargetName, _mainHVT, true];
		missionNamespace setVariable [_sTargetName, _mainHVT];
		[_mainHVT, ["This is our target!","{[""This is our target""] call TREND_fnc_notify; }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
		_mainHVT setCaptive true;
		removeAllWeapons _mainHVT;

		_guardUnit3 = selectRandom ((crew vehicle _mainHVT - [_mainHVT, driver vehicle _mainHVT]) select {typeOf(_x) in (InformantClasses + InterogateOfficerClasses + WeaponDealerClasses)});
		if (!isNil "_guardUnit3") then {
			_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
			_guardUnit3 setVariable [_sTargetName2, _guardUnit3, true];
			missionNamespace setVariable [_sTargetName2, _guardUnit3];
			if (_hasInformant) then {
				[_guardUnit3, ["This is our friendly agent!","{[""This is our friendly agent!""] call TREND_fnc_notify; }",[],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
				_guardUnit3 setCaptive true;
				removeAllWeapons _guardUnit3;
			};
		};

		{
			[_x, false] remoteExec ["enableSimulationGlobal", 2];
			[_x, true] remoteExec ["hideObjectGlobal", 2];
			_x setDamage 0;
			_x allowDamage false;
		} forEach units _hvtGroup;
		{
			[_x, false] remoteExec ["enableSimulationGlobal", 2];
			[_x, true] remoteExec ["hideObjectGlobal", 2];
			_x setDamage 0;
			_x allowDamage false;
		} forEach _convoyVehicles;

		waitUntil {sleep 2; TREND_bAndSoItBegins && TREND_CustomObjectsSet && TREND_PlayersHaveLeftStartingArea};

		if (!TREND_bDebugMode) then {
			_iWait = (420 * (_iTaskIndex + 1)) + floor(random 300);
			sleep floor(random 120);
			_sMessageOne = format["The convoy is due to depart at %1", (daytime  + (_iWait/3600) call BIS_fnc_timeToString)];
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
					_content = parseText format ["<t size='0.90'>Time Until Convoy Departs: <t color='%1'>--- %2 ---</t></t>", _color, [(_timeLeft/3600),"HH:MM:SS"] call BIS_fnc_timeToString];
					[[_content, _duration + 1, _taskIndex, _taskIndex], {_this spawn TREND_fnc_handleNotification}] remoteExec ["call"]; // After the first run, this will only update the text for the notification with index = _taskIndex
				};
			};

			sleep _iWait;
		};

		{
			[_x, true] remoteExec ["enableSimulationGlobal", 2];
			[_x, false] remoteExec ["hideObjectGlobal", 2];
			_x setDamage 0;
			_x allowDamage true;
		} forEach _convoyVehicles;
		{
			[_x, true] remoteExec ["enableSimulationGlobal", 2];
			[_x, false] remoteExec ["hideObjectGlobal", 2];
			_x setDamage 0;
			_x allowDamage true;
		} forEach units _hvtGroup;

		_sMessageTwo = format["%1 is in the area and on way to AO (position is tracked and marked on map",name _mainHVT];
		[[west, "HQ"],_sMessageTwo] remoteExec ["sideChat", 0];
		[_sMessageTwo] call TREND_fnc_notifyGlobal;

		_mrkMeetingHVTMarker = nil;
		_mrkMeetingHVTMarker = createMarker [format["HVT%1",_iTaskIndex], getPos _hvtVehicle];
		_mrkMeetingHVTMarker setMarkerShape "ICON";
		_mrkMeetingHVTMarker setMarkerType "o_inf";
		_mrkMeetingHVTMarker setMarkerText format["HVT %1",name(_mainHVT)];
		[_mainHVT, _hvtVehicle,_mrkMeetingHVTMarker] spawn {
			_mainHVT = _this select 0;
			_hvtVehicle = _this select 1;
			_mrkMeetingHVTMarker = _this select 2;
			while {alive _hvtVehicle && alive _mainHVT} do {
				_mrkMeetingHVTMarker setMarkerPos (getPos _hvtVehicle);
				sleep 5;
			};
		};

		if (_hasInformant && !isNil "_guardUnit3") then {
			[_guardUnit3] spawn {
				_guardUnit3 = _this select 0;
				waitUntil { sleep 2; vehicle _guardUnit3 isEqualTo _guardUnit3; };
				_guardUnit3 switchMove "Acts_JetsCrewaidLCrouch_in";
				_guardUnit3 disableAI "anim";
				sleep 2.2;
				_guardUnit3 switchMove "Acts_JetsCrewaidLCrouch_out";
				_guardUnit3 enableAI "anim";
				sleep 3;
				_guardUnit3 switchMove "";
				_guardUnit3 call BIS_fnc_ambientAnim__terminate;
			};
			_guardUnit3 setVariable ["MainObjective", _mainHVT, true];
			_guardUnit3 addEventHandler ["Killed", {[((_this select 0) getVariable "MainObjective"), "failed", "Our agent was killed!!!", "You killed our agent! Rep lowered", 0.8] spawn TREND_fnc_updateTask; }];
		};

		_mainHVT setVariable ["ObjectiveParams", [_markerType,_objectiveMainBuilding,_centralAO_x,_centralAO_y,_roadSearchRange,_bCreateTask,_iTaskIndex,_bIsMainObjective,_args]];
		missionNamespace setVariable [format ["missionObjectiveParams%1", _iTaskIndex], [_markerType,_objectiveMainBuilding,_centralAO_x,_centralAO_y,_roadSearchRange,_bCreateTask,_iTaskIndex,_bIsMainObjective,_args]];
		[_mainHVT, _iTaskIndex, _bIsMainObjective] spawn {
			_mainHVT = _this select 0;
			_iTaskIndex = _this select 1;
			_bIsMainObjective = _this select 2;
			while {alive _mainHVT} do {
				_mainHVTTrigger = _mainHVT getVariable "TREND_hvtTrigger";
				if (!isNil "_mainHVTTrigger") then {
					deleteVehicle _mainHVTTrigger;
				};
				_mainHVTTrigger = nil;
				_mainHVTTrigger = createTrigger ["EmptyDetector", getPos _mainHVT];
				_mainHVTTrigger setVariable ["DelMeOnNewCampaignDay",true];
				_mainHVTTrigger setTriggerArea [1250, 1250, 0, false];
				_mainHVTTrigger setTriggerActivation [TREND_FriendlySideString, format["%1 D", TREND_EnemySideString], true];
				_mainHVTTrigger setTriggerStatements ["this && {(time - TREND_TimeSinceLastSpottedAction) > (call TREND_GetSpottedDelay)}", format["nul = [%1, %2, %3, thisTrigger, thisList] spawn TREND_fnc_CallNearbyPatrol;",getPos _mainHVT,_iTaskIndex, _bIsMainObjective], ""];
				_mainHVT setVariable ["TREND_hvtTrigger", _mainHVTTrigger, true];
				sleep 30;
			};
			_mainHVTTrigger = _mainHVT getVariable "TREND_hvtTrigger";
			if (!isNil "_mainHVTTrigger") then {
				deleteVehicle _mainHVTTrigger;
			};
		};

		if (_bIsMainObjective) then { //if mainobjective (i.e. heavy mission or final campaign mission) we will require team to get document from corpse
			[_mainHVT, ["Take document",{(_this select 0) spawn TREND_fnc_updateTask;},[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
		}
		else { //if single mission or side then we can pass this task as soon as HVT is killed
			_mainHVT addEventHandler ["Killed", {(_this select 0) spawn TREND_fnc_updateTask;}];
		};
	};

	_MissionTitle = "Ambush Convoy";	//you can adjust this here to change what shows as marker and task text
	_sTaskDescription = "Intel has confirmed that our target is on route to the AO marked on the map. The HVT is moving with a convoy into the area! We need this HVT terminated!";
		//adjust this based on veh? and man? if van then if car then?
		//or just random description that will fit all situations??
	if (_bIsMainObjective) then {
		sTaskDescription = _sTaskDescription + "<br /><br />Once killed, search his body for the documents he is carrying!"
	};
	if (_hasInformant) then {
		_sTaskDescription = _sTaskDescription + "<br /><br />!NOTE: We have an under cover agent in the vehicle with our HVT, so watch your fire! Our agent will give a signal (tie his shoelace) to confirm his identity.";
	};
	_sTaskDescription = _sTaskDescription + "<br /><br />TIP: Shoot the driver to make the convoy stop and everyone get out of the vehicle.";
};
