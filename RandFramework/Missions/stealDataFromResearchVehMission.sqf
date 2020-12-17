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
	_MissionTitle = localize "STR_TRGM2_startInfMission_MissionTitle2";
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

	//###################################### Steal data from research vehicle ######################################
	["Mission Setup: 8-0-8", true] call TREND_fnc_log;
	_nearestRoad = nil;
	_nearestRoad = [[_centralAO_x,_centralAO_y], _roadSearchRange, []] call BIS_fnc_nearestRoad;
	_roadConnectedTo = nil;
	_roadConnectedTo = roadsConnectedTo _nearestRoad;
	_objVehicle = selectRandom sideResarchTruck createVehicle [0,0,500];
	_objVehicle setPosATL getPosATL _nearestRoad;

	_objVehicle setVariable ["taskIndex", _iTaskIndex, true];
	_objVehicle setVariable ["CreateTask", _bCreateTask, true];

	[_objVehicle, [localize "STR_TRGM2_startInfMission_MissionTitle2_Button",{_this spawn TREND_fnc_downloadResearchData},[]]] remoteExec ["addAction", 0, true];

	missionNamespace setVariable["playersInAO", false, true];
	_playersInAO = nil;
	_playersInAO = createTrigger ["EmptyDetector", getPos _objVehicle];
	_playersInAO   setVariable ["DelMeOnNewCampaignDay",true];
	_playersInAO   setTriggerArea [150, 150, 0, false];
	_playersInAO   setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_playersInAO   setTriggerStatements ["this", "missionNamespace setVariable[""playersInAO"", true, true]; [{missionNamespace getVariable[""playersInAO"", false]}, getPos thistrigger] spawn TREND_fnc_alertNearbyUnits; [TREND_EnemySide, call TREND_GetReinforceStartPos, getPos thistrigger, 3, true, true, true, true, false] spawn TREND_fnc_reinforcements; [TREND_EnemySide, call TREND_GetReinforceStartPos, getPos thistrigger, 3, true, true, true, false, false] spawn TREND_fnc_reinforcements;", "missionNamespace setVariable[""playersInAO"", false, true];"];

	if (count _roadConnectedTo > 0) then {
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
		_objVehicle setDir (_direction);
	};
	_sTaskDescription = selectRandom[localize "STR_TRGM2_startInfMission_MissionTitle2_Desc"];
};