//These are only ever called by the server!

//MISSION 14: Bomb Defusal

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
	_allowFriendlyIns = true;
	_MissionTitle = localize "STR_TRGM2_BombMissionTitle"; //this is what shows in dialog mission selection
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

	//DEFUSED = false;
	//ARMED = false;

	_missionBombCODE = [(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))]; //4 digit code can be more or less
	_missionBombWire = ["BLUE", "WHITE", "YELLOW", "GREEN"] call bis_fnc_selectRandom;


	//_MissionTitle = format["Meeting Assassination: %1",name(_mainHVT)];	//you can adjust this here to change what shows as marker and task text
	_sTaskDescription = selectRandom[localize "STR_TRGM2_BombMissionDescription"]; //adjust this based on veh? and man? if van then if car then?

	_mainObjPos = getPos _objectiveMainBuilding;

	_allpositionsBomb1 = _objectiveMainBuilding buildingPos -1;
	_sBomb1Name = format["objBomb%1",_iTaskIndex];
	_objBomb1 = selectRandom BombToDefuse createVehicle [0,0,500];
	_objBomb1 setVariable [_sBomb1Name, _objBomb1, true];
	missionNamespace setVariable [_sBomb1Name, _objBomb1];
	_objBomb1 setPosATL (selectRandom _allpositionsBomb1);

	_objBomb1 setVariable ["ObjectiveParams", [_markerType,_objectiveMainBuilding,_centralAO_x,_centralAO_y,_roadSearchRange,_bCreateTask,_iTaskIndex,_bIsMainObjective,_args]];

	_objBomb1 setVariable ["missionBombCODE",_missionBombCODE,true];
	_objBomb1 setVariable ["missionBombWire",_missionBombWire,true];
	_objBomb1 setVariable ["isDefused",false];

	_bombSerialNumber = format["%1%2%3%4%5",selectRandom["AA","BA","ZN"],(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))];
	_objBomb1 setVariable ["serialNumber",_bombSerialNumber,true];

	[_objBomb1, [localize "STR_TRGM2_BombMissionDefuseAction",{
		_thisPlayer = _this select 1;
		_thisBomb = (_this select 3) select 0;
		_thisPlayer setVariable ["missionBomb",_thisBomb];
		createDialog 'KeypadDefuse';
	},[_objBomb1]]] remoteExec ["addAction", 0, true];

	[_objBomb1, [localize "STR_TRGM2_BombMissionReadSerialAction",{
		_thisPlayer = _this select 1;
		_bombSerialNumber = (_this select 3) select 0;
		[format[localize "STR_TRGM2_BombSerialNo",_bombSerialNumber]] call TREND_fnc_notify;
	},[_bombSerialNumber]]]; remoteExec ["addAction", 0, true];


	_objInformant = createGroup Civilian createUnit [selectRandom InformantClasses,[-200,-200,0],[],0,"NONE"];
	_buildings = nil;
	if (_iTaskIndex == 0 && !isNil "TREND_Mission1SubLoc") then {
		_buildings = nearestObjects [TREND_Mission1SubLoc, TREND_BasicBuildings, 100];
	};
	if (_iTaskIndex == 1 && !isNil "TREND_Mission2SubLoc") then {
		_buildings = nearestObjects [TREND_Mission2SubLoc, TREND_BasicBuildings, 100];
	};
	if (_iTaskIndex == 2 && !isNil "TREND_Mission3SubLoc") then {
		_buildings = nearestObjects [TREND_Mission3SubLoc, TREND_BasicBuildings, 100];
	};
	if (isNil "_buildings") then {
		_buildings = nearestObjects [[_centralAO_x,_centralAO_y], TREND_BasicBuildings, 1800];
	};



	_infBuilding = nil;
	_attemptLimit = 5;
	_bBuildingFound = false;
	while {!_bBuildingFound || _attemptLimit > 0} do {
		_infBuilding = selectRandom _buildings;
		_allBuildingPos = _infBuilding buildingPos -1;
		if (count _allBuildingPos > 2) then {
			_infBuilding setDamage 0;
			_allBuildingPos = _infBuilding buildingPos -1;
			_objInformant setPos (selectRandom _allBuildingPos);
			_bBuildingFound = true;
		};
		_attemptLimit = _attemptLimit - 1;
	};
	if (!_bBuildingFound) then {
		//didnt find a building with enough space... so have the guy outside
		_flatPosInf = [getPos _infBuilding , 0, 50, 5, 0, 0.5, 0,[],[getPos _infBuilding,getPos _infBuilding], _objInformant] call TREND_fnc_findSafePos;
		_objInformant setPos (_flatPosInf);
	};

	[_objInformant, [localize "STR_TRGM2_BombMissionIntelAction",{
		_thisInformant = _this select 0;
		_thisPlayer = _this select 1;
		_bombSerialNumber = (_this select 3) select 0;
		_missionBombWire = (_this select 3) select 1;
		_missionBombCODE = (_this select 3) select 2;
		if (alive _thisInformant) then {
			[format[localize "STR_TRGM2_BombNiceToMeet",name(_thisPlayer),_bombSerialNumber,_missionBombWire,_missionBombCODE]] call TREND_fnc_notify;
		}
		else{
			[format[localize "STR_TRGM2_BombPsst",name(_thisPlayer)]] call TREND_fnc_notify;
		};
	},[_bombSerialNumber,_missionBombWire,_missionBombCODE]]] remoteExec ["addAction", 0, true];

	_markerstrBombInf = createMarker [format ["BombInfLoc%1",(getPos _objInformant) select 0],getPos _objInformant];
	_markerstrBombInf setMarkerShape "ICON";
	_markerstrBombInf setMarkerType "hd_dot";
	_markerstrBombInf setMarkerText localize "STR_TRGM2_BombMissionInformantMarker";

	if ((_objInformant distance [_centralAO_x,_centralAO_y]) > 500 && random 1 < .25) then {
		if (random 1 < .50) then {
			_thisAreaRange = 20;
			_checkPointGuidePos = getPos _objInformant;
			_flatPosSentry = nil;
			_flatPosSentry = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
			if (_flatPosSentry select 0 > 0) then {
				_thisPosAreaOfCheckpoint = _flatPosSentry;
				_thisRoadOnly = false;
				_thisSide = east;
				_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
				_thisAllowBarakade = false;
				_thisIsDirectionAwayFromAO = true;
				[_checkPointGuidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),100] spawn TREND_fnc_setCheckpoint;
			};
		}
		else {
			[getPos _objInformant,200,250] spawn TREND_fnc_createWaitingAmbush;
		};
	};

	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];

	_customTaskFail = nil;
	_customTaskFail = createTrigger ["EmptyDetector", [0,0]];
	_customTaskFail setVariable ["DelMeOnNewCampaignDay",true];

	_sAliveCheck = format["%1 getVariable ['isDefused',false] && !([""InfSide%2""] call FHQ_fnc_ttAreTasksCompleted)",_sBomb1Name,_iTaskIndex];

	if (!_bCreateTask) then {
		_customTaskClear setTriggerStatements [_sAliveCheck, "[_objBomb1] spawn TREND_fnc_updateTask;", ""];
	}
	else {
		_sFailCheck = format["!alive %1 && !([""InfSide%2""] call FHQ_fnc_ttAreTasksCompleted)",_sBomb1Name,_iTaskIndex];
		_customTaskFail setTriggerStatements [_sFailCheck, "[_objBomb1, ""failed""] spawn TREND_fnc_updateTask;", ""];
		_customTaskClear setTriggerStatements [_sAliveCheck, "[_objBomb1] spawn TREND_fnc_updateTask;", ""];
	};

};
