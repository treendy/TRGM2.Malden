//These are only ever called by the server!

//useful variables
//base location
//mission task locations
//friendly AO camp location
//checkpoint locations and sentry postions
//cleared locations (i.e. AOs that had a task completed)


fnc_CustomVars = { //This is called before the mission function is called below, and the variables below can be adjusted for your mission
	_CustomMissionEnabled = true; //set this to true to allow this mission to show in the mission selection dialog
	_RequiresNearbyRoad = true;
	_roadSearchRange = 250; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_MissionTitle = "Meeting Assassination";	
	_allowFriendlyIns = false;
};

fnc_CustomMission = { //This function is the main script for your mission, some if the parameters passed in must not be changed!!!
	_markerType = _this select 0;
	_objectiveMainBuilding = _this select 1; //DO NOT EDIT THIS VALUE (this is the main building location selected within your AO)
	_centralAO_x = _this select 2; //DO NOT EDIT THIS VALUE
	_centralAO_y = _this select 3; //DO NOT EDIT THIS VALUE
	_roadSearchRange = _this select 4; //this is past in from the engine, and is the value you set above (DO NOT INREASE THE VALUE ON THIS LINE!!, you can decrease as it will pick a road within your range above)

	
	if (_markerType != "empty") then { _markerType = "hd_unknown"; }; //You can set the type of marker here, but if the player has selected to hide mission locations, then your marker will not show
	_nearestRoad = nil;
	_nearestRoad = [[_centralAO_x,_centralAO_y], _roadSearchRange, []] call BIS_fnc_nearestRoad;
	_roadConnectedTo = nil;
	_roadConnectedTo = roadsConnectedTo _nearestRoad;
	_objVehicle = selectRandom sideResarchTruck createVehicle [0,0,500];
	_objVehicle setPosATL getPosATL _nearestRoad;
	[[_objVehicle, [localize "STR_TRGM2_startInfMission_MissionTitle2_Button","RandFramework\downloadResearchData.sqf",[_iTaskIndex,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
	//hint format["TEST: %1 - %2 - %3", _centralAO_x,_centralAO_y,_roadSearchRange]; sleep 5;
	if (count _roadConnectedTo > 0) then {
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
		_objVehicle setDir (_direction);
	};
	_sTaskDescription = selectRandom["steal research data from bob","John has data, steal it!"];

};