//These are only ever called by the server!

fnc_CustomRequired = { //used to set any required details for the AO (example, a wide open space or factory nearby)... if this is not found in AO, the engine will scrap the area and loop around again with a different location
//be careful about using this, some maps may not have what you require, so the engine will never satisfy the requirements here (example, if no airports are on a map and that is what you require)	
	_objectiveMainBuilding = _this select 0; 
	_centralAO_x = _this select 1; 
	_centralAO_y = _this select 2; 

	_result = true; //always returing true, because we have in custom vars "_RequiresNearbyRoad" which will take care of our checks
	_result; //return value
};

fnc_CustomVars = { //This is called before the mission function is called below, and the variables below can be adjusted for your mission
	_RequiresNearbyRoad = true;
	_roadSearchRange = 100; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_allowFriendlyIns = false;
	_MissionTitle = localize "STR_TRGM2_IEDMissionTitle"; //this is what shows in dialog mission selection
};

fnc_CustomMission = { //This function is the main script for your mission, some if the parameters passed in must not be changed!!!
	_markerType = _this select 0;
	_objectiveMainBuilding = _this select 1; //DO NOT EDIT THIS VALUE (this is the main building location selected within your AO)
	_centralAO_x = _this select 2; //DO NOT EDIT THIS VALUE
	_centralAO_y = _this select 3; //DO NOT EDIT THIS VALUE
	_roadSearchRange = _this select 4; //this is past in from the engine, and is the value you set above (DO NOT INREASE THE VALUE ON THIS LINE!!, you can decrease as it will pick a road within your range above)
	_bCreateTask = _this select 5; //the engine passes this in, it will be set to false for option sides mission, and the action to happen when this mission is complete is set in the lines at the bottom of this file
	_iTaskIndex = _this select 6; // for the engine, so it knows which index it is working on (do not change this value!!)
	_bIsMainObjective = _this select 7;
	if (_markerType != "empty") then { _markerType = "hd_unknown"; }; //You can set the type of marker here, but if the player has selected to hide mission locations, then your marker will not show


	//_MissionTitle = format["Meeting Assassination: %1",name(_mainHVT)];	//you can adjust this here to change what shows as marker and task text 
	_sTaskDescription = selectRandom[localize "STR_TRGM2_IEDMissionDescription"]; //adjust this based on veh? and man? if van then if car then?

	_mainObjPos = getPos _objectiveMainBuilding;

	_IEDType = selectRandom ["CAR","RUBBLE"];
	_ieds = nil;
	If (_IEDType == "CAR") then {_ieds = CivCars;};
	If (_IEDType == "RUBBLE") then {_ieds = IEDFakeClassNames;};

	_IED1 = createVehicle [selectRandom _ieds,[0,0,0],[],0,"NONE"];
	_sTargetName1 = format["objInformant%1",_iTaskIndex];
	_IED1 setVariable [_sTargetName1, _IED1, true];
	missionNamespace setVariable [_sTargetName1, _IED1];
	[_mainObjPos,100,true,true,_IED1,_IEDType] execVM "RandFramework\setIEDEvent.sqf";

	_IED2 = createVehicle [selectRandom _ieds,[-25,-25,0],[],0,"NONE"];
	_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
	_IED2 setVariable [_sTargetName2, _IED2, true];
	missionNamespace setVariable [_sTargetName2, _IED2];
	[_mainObjPos,1500,true,true,_IED2,_IEDType] execVM "RandFramework\setIEDEvent.sqf";

	_IED3 = createVehicle [selectRandom _ieds,[-50,-50,0],[],0,"NONE"];
	_sTargetName3 = format["objInformant3_%1",_iTaskIndex];
	_IED3 setVariable [_sTargetName3, _IED3, true];
	missionNamespace setVariable [_sTargetName3, _IED3];
	[_mainObjPos,1500,true,true,_IED3,_IEDType] execVM "RandFramework\setIEDEvent.sqf";



	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];
	
	_sAliveCheck = format["%1 getVariable ['isDefused',false] && %2 getVariable ['isDefused',false] && %3 getVariable ['isDefused',false] && !([""InfSide%4""] call FHQ_TT_areTasksCompleted)",_sTargetName1,_sTargetName2,_sTargetName3,_iTaskIndex];

	if (!_bCreateTask) then {
		_customTaskClear setTriggerStatements [_sAliveCheck, " [1, ""Defused IEDs""] execVM ""RandFramework\AdjustMaxBadPoints.sqf""; Hint (""Defused IEDs, Rep increased""); ClearedPositions pushBack ([ObjectivePossitions, getPos objInformant" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";", ""];			
	}
	else {		
		_sTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack ([ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";",_iTaskIndex];
		_customTaskClear setTriggerStatements [_sAliveCheck, _sTaskComplete, ""];	
	};
};
