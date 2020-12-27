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
	_MissionTitle = localize "STR_TRGM2_startInfMission_MissionTitle1";
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

	//###################################### Hack Data ######################################
	["Mission Setup: 8-0-9", true] call TREND_fnc_log;
	_allpositionsLaptop1 = _objectiveMainBuilding buildingPos -1;
	_sLaptop1Name = format["objLaptop%1",_iTaskIndex];
	_objLaptop1 = "Land_SatellitePhone_F" createVehicle [0,0,500];
	_objLaptop1 setVariable [_sLaptop1Name, _objLaptop1, true];
	missionNamespace setVariable [_sLaptop1Name, _objLaptop1];
	_laptopPos = (selectRandom _allpositionsLaptop1);
	_objLaptop1 setPosATL _laptopPos;

	if (random 1 < .50) then {
		_sIED1Name = format["objIED%1",_iTaskIndex];
		_objIED1 = selectRandom TREND_IEDClassNames createVehicle [0,0,500];
		_objIED1 setVariable [_sIED1Name, _objIED1, true];
		missionNamespace setVariable [_sIED1Name, _objIED1];
		_fallbackPos = [_laptopPos, 5, 25, 10, 0, 0.3, 0,[],[_laptopPos vectorAdd [random 10, random 10, 0],_laptopPos vectorAdd [random 10, random 10, 0]], _objIED1] call TREND_fnc_findSafePos;
		_objIED1 setPosATL ([_fallbackPos, selectRandom(_allpositionsLaptop1 - [_laptopPos])] select (count _allpositionsLaptop1 >= 2));
	};

	_objLaptop1 setVariable ["taskIndex", _iTaskIndex, true];
	_objLaptop1 setVariable ["CreateTask", _bCreateTask, true];

	[_objLaptop1, [localize "STR_TRGM2_startInfMission_MissionTitle1", {_this spawn TREND_fnc_downloadData;}, [localize "STR_TRGM2_downloadData_title", true, "TREND_fnc_hackIntel1", [_iTaskIndex, _bCreateTask]], 0, true, true, "", "_this == player"]] remoteExec ["addAction", 0, true];

	_sTaskDescription = selectRandom[localize "STR_TRGM2_startInfMission_MissionTitle1_Desc1", localize "STR_TRGM2_startInfMission_MissionTitle1_Desc2"];
};