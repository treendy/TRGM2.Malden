//These are only ever called by the server!

//useful variables
//base location
//mission task locations
//friendly AO camp location
//checkpoint locations and sentry postions
//cleared locations (i.e. AOs that had a task completed)

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
	_RequiresNearbyRoad = true;
	_roadSearchRange = 100; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_MissionTitle = _this select 0; // The destroy X vehicle mission takes the mission title as a parameter to allow all the destory X vehicle missions to use the same function
	_allowFriendlyIns = false;
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

	//###################################### Destroy Vehicle(s) ######################################
	["Mission Setup: 8-0-6", true] call TREND_fnc_log;

	sAliveCheck = format["!([""InfSide%1""] call FHQ_fnc_ttAreTasksCompleted)", _iTaskIndex];
	_args params ["_vehicleType", "_repReasonOnComplete", "_hintStrOnComplete", "_missionDescriptions"];

	TREND_fnc_addTruckToDestroy = {
		params ["_taskIndex", "_targetIndex", "_truckType", "_inf1X", "_inf1Y", "_blackListPos"];
		_flatPos = nil;
		_posFound = false;
		for [{private _i = 1}, {_i < 6 && !_posFound}, {_i = _i + 1}] do {
			_flatPos = [[_inf1X,_inf1Y,0], 5, 50 * _i, sizeOf _truckType, 0, 0.5, 0, _blackListPos, [[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]], _truckType] call TREND_fnc_findSafePos;
			if (!isNil "_flatPos" && {!(_flatPos select 0 isEqualTo _inf1X) && {!(_flatPos select 1 isEqualTo _inf1Y)}}) then {
				_posFound = true;
			};
		};
		if (_posFound) exitWith {
			_sTargetName = format["objInformant%1_%2", _targetIndex, _taskIndex];
			_objVehicle = _truckType createVehicle [0,0,500];
			_objVehicle setVariable [_sTargetName, _objVehicle, true];
			createVehicleCrew _objVehicle;
			missionNamespace setVariable [_sTargetName, _objVehicle];
			_objVehicle setPos _flatPos;
			_objVehicle disableAI "MOVE";

			if (_truckType in (call DestroyAAAVeh)) then {
				TREND_fnc_AAARadioLoop1 = {
					_object = _this select 0;
					_bPlay = true;
					while {_bPlay && !isNil(_object)} do {
						if (!alive _object) then {_bPlay = false};
						playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom TREND_EnemyRadioSounds + ".wss", _object, false, getPosASL _object, 0.5, 1, 0];
						sleep selectRandom [10,15,20,30];
					};
				};
				[_objVehicle] spawn TREND_fnc_AAARadioLoop1;
			};

			if (_truckType in (call sArtilleryVeh)) then {
				TREND_fnc_ArtiFireLoop1 = {
					_vehicle = _this select 0;
					_Ammo = getArtilleryAmmo [_vehicle] select 0;
					while {alive(_vehicle)} do {
						_flatPos = [[getMarkerPos "mrkHQ", 2000], [getMarkerPos "mrkHQ", 500]] call BIS_fnc_randomPos;
						[_vehicle, 1] remoteExec ["setVehicleAmmo", 0, true];
						if (!isNil "_vehicle" && !isNil "_flatPos" && !isNil "_Ammo") then {
							[_vehicle, [_flatPos, _Ammo, 1]] remoteExec ["commandArtilleryFire", -2, true];
						};
						sleep selectRandom[10,30,60,120,240];
					};
				};
				[_objVehicle] spawn TREND_fnc_ArtiFireLoop1;
			};

			[_sTargetName, _flatPos];
		};
		[nil, nil];
	};

	_blackListPositions = [];
	for [{private _i = 0}, {_i < selectRandom[2,3,4]}, {_i = _i + 1}] do {
		private _returnArr = [_iTaskIndex, _i, _vehicleType, _centralAO_x, _centralAO_y, _blackListPositions] call TREND_fnc_addTruckToDestroy;
		_returnArr params ["_sTargetName", "_aBlacklistPos"];
		if (!isNil "_sTargetName") then {
			sAliveCheck = sAliveCheck + format[" && !alive(%1)", _sTargetName];
		};
		if (!isNil "_aBlacklistPos" && {!(_aBlacklistPos isEqualTo [])}) then {
			_blackListPositions pushBack [_aBlacklistPos, 50];
		};
	};

	_triggerTruckClear = nil;
	_triggerTruckClear = createTrigger ["EmptyDetector", [0,0]];
	_triggerTruckClear setVariable ["DelMeOnNewCampaignDay",true];
	if (!_bCreateTask) then {
		_triggerTruckComplete = format["[1, %1] spawn TREND_fnc_AdjustMaxBadPoints; [%2] call TREND_fnc_notify; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant0_%3] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", _repReasonOnComplete, _hintStrOnComplete, _iTaskIndex];
		_triggerTruckClear setTriggerStatements [sAliveCheck, _triggerTruckComplete, ""];
	}
	else {
		_triggerTruckComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant0_%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", _iTaskIndex];
		_triggerTruckClear setTriggerStatements [sAliveCheck, _triggerTruckComplete, ""];

	};
	_sTaskDescription = selectRandom _missionDescriptions;
};