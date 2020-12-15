//These are only ever called by the server!

//MISSION 15: Search and Destroy

fnc_CustomRequired = { //used to set any required details for the AO (example, a wide open space or factory nearby)... if this is not found in AO, the engine will scrap the area and loop around again with a different location
//be careful about using this, some maps may not have what you require, so the engine will never satisfy the requirements here (example, if no airports are on a map and that is what you require)
	_objectiveMainBuilding = _this select 0;
	_centralAO_x = _this select 1;
	_centralAO_y = _this select 2;

	_result = true; //always returing true, because we have in custom vars "_RequiresNearbyRoad" which will take care of our checks
	_result; //return value
};

fnc_CustomVars = { //This is called before the mission function is called below, and the variables below can be adjusted for your mission
	_RequiresNearbyRoad = false;
	_roadSearchRange = 100; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_allowFriendlyIns = false;
	_MissionTitle = localize "STR_TRGM2_TargetMissionTitle"; //this is what shows in dialog mission selection
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

	_compactIedTargets = false;
	if (TREND_AdvancedSettings select TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX == 1) then {
		_compactIedTargets = true;
	};
	if (TREND_AdvancedSettings select TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX == 0) then {
		_compactIedTargets = selectRandom[false,true];
	};

	_spacingBetweenTargets = 1500;
	if (_compactIedTargets) then {_spacingBetweenTargets = 150};

	//_MissionTitle = format["Meeting Assassination: %1",name(_mainHVT)];	//you can adjust this here to change what shows as marker and task text
	_sTaskDescription = selectRandom[localize "STR_TRGM2_TargetMissionDescription"]; //adjust this based on veh? and man? if van then if car then?

	_mainObjPos = getPos _objectiveMainBuilding;

	_targetVehs = TargetVehicles;
	_targetCaches = TargetCaches;

	_targetToUse = selectRandom _targetVehs;
	_isCache = selectRandom[true,false];
	if (_isCache) then {
		_targetToUse = selectRandom _targetCaches;
	};
	_target1 = createVehicle [_targetToUse,[0,0,0],[],0,"NONE"];
	_sTargetName1 = format["objInformant%1",_iTaskIndex];
	_target1 setVariable [_sTargetName1, _target1, true];
	missionNamespace setVariable [_sTargetName1, _target1];
	[_mainObjPos,100,true,true,_target1, _isCache] spawn TREND_fnc_setTargetEvent;

	_targetToUse2 = selectRandom _targetVehs;
	_isCache2 = selectRandom[false];
	if (_isCache2) then {
		_targetToUse2 = selectRandom _targetCaches;
	};
	_IED2 = createVehicle [_targetToUse2,[-25,-25,0],[],0,"NONE"];
	_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
	_IED2 setVariable [_sTargetName2, _IED2, true];
	missionNamespace setVariable [_sTargetName2, _IED2];
	[_mainObjPos,_spacingBetweenTargets,true,true,_IED2, _isCache2] spawn TREND_fnc_setTargetEvent;

	_targetToUse3 = selectRandom _targetVehs;
	_isCache3 = selectRandom[true];
	if (_isCache3) then {
		_targetToUse3 = selectRandom _targetCaches;
	};
	_IED3 = createVehicle [_targetToUse3,[-50,-50,0],[],0,"NONE"];
	_sTargetName3 = format["objInformant3_%1",_iTaskIndex];
	_IED3 setVariable [_sTargetName3, _IED3, true];
	missionNamespace setVariable [_sTargetName3, _IED3];
	[_mainObjPos,_spacingBetweenTargets,true,true,_IED3, _isCache3] spawn TREND_fnc_setTargetEvent;



	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];

	_sAliveCheck = format["!alive %1 && !alive %2 && !alive %3 && !([""InfSide%4""] call FHQ_fnc_ttAreTasksCompleted)",_sTargetName1,_sTargetName2,_sTargetName3,_iTaskIndex];

	if (!_bCreateTask) then {
		_customTaskClear setTriggerStatements [_sAliveCheck, " [1, ""Targets Destroyed""] spawn TREND_fnc_AdjustMaxBadPoints; Hint (""Targets Destroyed, Rep increased""); TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";", ""];
	}
	else {
		_sTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_fnc_ttSetTaskState"", 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""TREND_ClearedPositions"";",_iTaskIndex];
		_customTaskClear setTriggerStatements [_sAliveCheck, _sTaskComplete, ""];
	};
};
