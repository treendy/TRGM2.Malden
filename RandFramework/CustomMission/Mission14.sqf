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
	_RequiresNearbyRoad = false;
	_roadSearchRange = 100; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_allowFriendlyIns = true;
	_MissionTitle = localize "STR_TRGM2_BombMissionTitle"; //this is what shows in dialog mission selection
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

	_objBomb1 setVariable ["missionBombCODE",_missionBombCODE,true];
	_objBomb1 setVariable ["missionBombWire",_missionBombWire,true];
	_objBomb1 setVariable ["isDefused",false];

	_bombSerialNumber = format["%1%2%3%4%5",selectRandom["AA","BA","ZN"],(round(random 9)), (round(random 9)), (round(random 9)), (round(random 9))];
	_objBomb1 setVariable ["serialNumber",_bombSerialNumber,true];
	
	[[_objBomb1, [localize "STR_TRGM2_BombMissionDefuseAction",{
		_thisPlayer = _this select 1;
		_thisBomb = (_this select 3) select 0;
		_thisPlayer setVariable ["missionBomb",_thisBomb];
		createDialog 'KeypadDefuse';
	},[_objBomb1]]],"addAction",true,true] call BIS_fnc_MP;

	[[_objBomb1, [localize "STR_TRGM2_BombMissionReadSerialAction",{
		_thisPlayer = _this select 1;
		_bombSerialNumber = (_this select 3) select 0;
		hint format[localize "STR_TRGM2_BombSerialNo",_bombSerialNumber];
	},[_bombSerialNumber]]],"addAction",true,true] call BIS_fnc_MP;	

	
	_objInformant = createGroup Civilian createUnit [selectRandom InformantClasses,[-200,-200,0],[],0,"NONE"];
	_buildings = nearestObjects [[_centralAO_x,_centralAO_y], BasicBuildings, 1800];
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
		_flatPosInf = [getPos _infBuilding , 0, 50, 5, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		_objInformant setPos (_flatPosInf);
	};
	
	[[_objInformant, [localize "STR_TRGM2_BombMissionIntelAction",{
		_thisInformant = _this select 0;
		_thisPlayer = _this select 1;
		_bombSerialNumber = (_this select 3) select 0;
		_missionBombWire = (_this select 3) select 1;
		_missionBombCODE = (_this select 3) select 2;
		if (alive _thisInformant) then {
			hint format[localize "STR_TRGM2_BombNiceToMeet",name(_thisPlayer),_bombSerialNumber,_missionBombWire,_missionBombCODE];
		}
		else{
			hint format[localize "STR_TRGM2_BombPsst",name(_thisPlayer)];			
		};		
	},[_bombSerialNumber,_missionBombWire,_missionBombCODE]]],"addAction",true,true] call BIS_fnc_MP;

	_markerstrBombInf = createMarker [format ["BombInfLoc%1",(getPos _objInformant) select 0],getPos _objInformant];
	_markerstrBombInf setMarkerShape "ICON";	
	_markerstrBombInf setMarkerType "hd_dot";
	_markerstrBombInf setMarkerText localize "STR_TRGM2_BombMissionInformantMarker";

	if ((_objInformant distance [_centralAO_x,_centralAO_y]) > 500 && selectRandom [true,false,false,false]) then {
		if (selectRandom [true,false]) then {
			_thisAreaRange = 20;
			_checkPointGuidePos = getPos _objInformant;
			_flatPosSentry = nil;
			_flatPosSentry = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (_flatPosSentry select 0 > 0) then {
				_thisPosAreaOfCheckpoint = _flatPosSentry;
				_thisRoadOnly = false;
				_thisSide = east; 
				_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
				_thisAllowBarakade = false;
				_thisIsDirectionAwayFromAO = true;
				[_checkPointGuidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100] execVM "RandFramework\setCheckpoint.sqf";
			};
		}
		else {
			[getPos _objInformant,200,250] execVM "RandFramework\createWaitingAmbush.sqf";
		};
	};

	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];

	_customTaskFail = nil;
	_customTaskFail = createTrigger ["EmptyDetector", [0,0]];
	_customTaskFail setVariable ["DelMeOnNewCampaignDay",true];
	
	_sAliveCheck = format["%1 getVariable ['isDefused',false] && !([""InfSide%2""] call FHQ_TT_areTasksCompleted)",_sBomb1Name,_iTaskIndex];
	
	if (!_bCreateTask) then {
		_customTaskClear setTriggerStatements [_sAliveCheck, " [1, ""Defused Bomb""] execVM ""RandFramework\AdjustMaxBadPoints.sqf""; Hint (""Defused IEDs, Rep increased""); ClearedPositions pushBack ([ObjectivePossitions, getPos objBomb" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";", ""];			
	}
	else {		
		_sFailCheck = format["!alive %1 && !([""InfSide%2""] call FHQ_TT_areTasksCompleted)",_sBomb1Name,_iTaskIndex];
		_sTaskFail = format["[""InfSide%1"", ""failed""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack ([ObjectivePossitions, getPos objBomb%1] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";",_iTaskIndex];
		_customTaskFail setTriggerStatements [_sFailCheck, _sTaskFail, ""];	

		_sTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack ([ObjectivePossitions, getPos objBomb%1] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";",_iTaskIndex];
		_customTaskClear setTriggerStatements [_sAliveCheck, _sTaskComplete, ""];	
	};
	
};
