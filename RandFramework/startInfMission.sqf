#include "..\setUnitGlobalVars.sqf";
#include "..\RandFramework\RandScript\trendFunctions.sqf";

//This is only ever called on server!!!!

TRGM_Logic setVariable ["DeathRunning", false, true];
TRGM_Logic setVariable ["PointsUpdating", false, true];


//debugMessages = "";
//publicVariable "debugMessages";


_ThisTaskTypes = nil;
_IsMainObjs = nil;
_MarkerTypes = nil;
_CreateTasks = nil;
_bIsCampaign = false;
_bIsCampaignFinalMission = false;
_bSideMissionsCivOnly = false;

_MainMissionTasksToUse = MainMissionTasks;
_SideMissionTasksToUse = SideMissionTasks;
if (iMissionParamObjective > 0) then {
	_MainMissionTasksToUse = [iMissionParamObjective];
	_SideMissionTasksToUse = [iMissionParamObjective];
};

iMissionSetup = iMissionParamType;
if (iMissionSetup == 0) then {
	_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom SideMissionTasks,selectRandom SideMissionTasks];
	_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
	_CreateTasks = [true,false,false];
	MaxBadPoints = 3;
};
if (iMissionSetup == 1) then {
	_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom SideMissionTasks,selectRandom SideMissionTasks];
	_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["empty","hd_dot","hd_dot"];
	_CreateTasks = [true,false,false];
	MaxBadPoints = 4;
};
if (iMissionSetup == 2) then {
	_ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
	_IsMainObjs = [true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective"];
	_CreateTasks = [true];
	MaxBadPoints = 3;
};
if (iMissionSetup == 3) then {
	if (selectRandom [true,false,false]) then {
		_ThisTaskTypes = [selectRandom _SideMissionTasksToUse,4];
		_IsMainObjs = [false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","hd_dot"];
		_CreateTasks = [true,false];
		MaxBadPoints = 2;
		_bSideMissionsCivOnly = true;
	}
	else {
		_ThisTaskTypes = [selectRandom _SideMissionTasksToUse];
		_IsMainObjs = [false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective"];
		_CreateTasks = [true];
		MaxBadPoints = 2;
	};
};
if (iMissionSetup == 4) then {
	_ThisTaskTypes = [selectRandom _SideMissionTasksToUse,selectRandom _SideMissionTasksToUse,selectRandom _SideMissionTasksToUse];
	_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
	_CreateTasks = [true,true,true];
	MaxBadPoints = 4;
};
if (iMissionSetup == 5) then {
	if (MaxBadPoints >= 10) then {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom MissionsThatHaveIntel,selectRandom MissionsThatHaveIntel];
		_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
		_CreateTasks = [true,false,false];
		_bIsCampaignFinalMission = true;
	}
	else {
		if (selectRandom [true,false,false]) then {
			_ThisTaskTypes = [selectRandom _SideMissionTasksToUse,4];
			_IsMainObjs = [false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot"];
			_CreateTasks = [true,false];
			_bSideMissionsCivOnly = true;
		}
		else {
			_ThisTaskTypes = [selectRandom _SideMissionTasksToUse];
			_IsMainObjs = [false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective"];
			_CreateTasks = [true];
		};
	};
	_bIsCampaign = true;
};


publicVariable "MaxBadPoints";




while {(InfTaskCount < count _ThisTaskTypes)} do {
	_iTaskIndex = 0;
	if (_bIsCampaign) then {
		_iTaskIndex = (iCampaignDay-1) + InfTaskCount;
	}
	else {
		_iTaskIndex = InfTaskCount;
	};

	_iThisTaskType = nil;
	if (_bIsCampaign) then {
		_iThisTaskType = _ThisTaskTypes select InfTaskCount;
	}
	else {
		_iThisTaskType = _ThisTaskTypes select InfTaskCount;
	};
	
	
	_bIsMainObjective = _IsMainObjs select InfTaskCount;  //more chance of bad things, and set middle area stuff around (comms, base etc...)
	_MarkerType = _MarkerTypes select InfTaskCount; //"Empty" or other
	_bCreateTask = _CreateTasks select InfTaskCount;
	_allowFriendlyIns = true;
	


	//hint "c";


	//if (!InfTaskStarted) then {
	if (true) then {
		InfTaskStarted = true;
		publicVariable "InfTaskStarted";

		//InfTaskCount = InfTaskCount + 1;
		//publicVariable "InfTaskCount";
		
			//InformantStuff	
			SideCompleted = [];
			publicVariable "SideCompleted";
			
				SideCompleted pushBack False;
				publicVariable "SideCompleted";
				_bInfor1Found = false;

				_MissionTitle = "";
				if (_iThisTaskType == 1) then {_MissionTitle = "Hack Data"};
				if (_iThisTaskType == 2) then {_MissionTitle = "Steal data from research vehicle"};
				if (_iThisTaskType == 3) then {_MissionTitle = "Destroy Ammo Trucks"};
				if (_iThisTaskType == 4) then {_MissionTitle = "Speak with informant"};
				if (_iThisTaskType == 5) then {_MissionTitle = "interrogate officer"};
				if (_iThisTaskType == 6) then {_MissionTitle = "Transmit Enemy Comms to HQ"};
				if (_iThisTaskType == 7) then {_MissionTitle = "Eliminate Officer"}; //gain 1 point if side, if main, need to id him before complete
				if (_iThisTaskType == 8) then {_MissionTitle = "Assasinate weapon dealer"}; //gain 1 point if side, no intel from him... if main need to id him before complete
				if (_iThisTaskType == 9) then {_MissionTitle = "Destroy AAA vehicles"}; //gain 1 point if side, no intel from him... if main need to id him before complete
				if (_iThisTaskType == 10) then {_MissionTitle = "Destroy Artillery vehicles"}; //gain one point if side (player can call arti strikes on them, cost 0.3 points but gains one if complete)


				//kill leader (he will run away in car to AO)    ::   save stranded guys    ::      
				while {!_bInfor1Found} do {
					_markerInformant1 = nil;
					
					_randInfor1X = 0 + (floor random 25000);
					_randInfor1Y = 0 + (floor random 25000);
					_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], BasicBuildings, 200];

					if ((getMarkerPos "mrkHQ" distance [_randInfor1X, _randInfor1Y]) > SideMissionMinDistFromBase && (count _buildings) > 0) then {


						_bInfor1Found = true;
						_infBuilding = selectRandom _buildings;
						_allBuildingPos = _infBuilding buildingPos -1;
						_inf1X = position _infBuilding select 0;
						_inf1Y = position _infBuilding select 1;
						if (count _allBuildingPos > 2) then { 

							_roadSearchRange = 20;
							if (_iThisTaskType == 3) then {_roadSearchRange = 100;};
							_nearestRoads = [_inf1X,_inf1Y] nearRoads _roadSearchRange;
							
							
							if (_iThisTaskType == 2 || _iThisTaskType == 3) then { //2 = retrive tank << so we need a nearby road									
								if (count _nearestRoads == 0) then {
									_bInfor1Found = false;
								}
								else {
							
									
									
								};
							};
							if (_bInfor1Found) then {
								ObjectivePossitions pushBack [_inf1X,_inf1Y]; 
								publicVariable "ObjectivePossitions";	

								_sTaskDescription = "";
								//###################################### Hack Data ###################
								if (_iThisTaskType == 1) then { 
									_allpositionsLaptop1 = _infBuilding buildingPos -1;
									_sLaptop1Name = format["objLaptop%1",_iTaskIndex];
									_objLaptop1 = "Land_Laptop_device_F" createVehicle [0,0,500];
									_objLaptop1 setVariable [_sLaptop1Name, _objLaptop1, true];
									missionNamespace setVariable [_sLaptop1Name, _objLaptop1];
									_objLaptop1 setPosATL (selectRandom _allpositionsLaptop1);

									if (selectRandom[true,false]) then {
										_sIED1Name = format["objIED%1",_iTaskIndex];
										_objIED1 = selectRandom IEDClassNames createVehicle [0,0,500];
										_objIED1 setVariable [_sIED1Name, _objIED1, true];
										missionNamespace setVariable [_sIED1Name, _objIED1];
										_objIED1 setPosATL (selectRandom _allpositionsLaptop1);
									};
									[[_objLaptop1, ["Hack intel","RandFramework\hackIntel1.sqf",[_iTaskIndex,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
									_sTaskDescription = selectRandom[
										"Somewhere in the building marked is a laptop, it contains details of the latest enemy attack jet. We need you to hack the data and send the details back to us.",
										"We have discovered the location of an enemy laptop which we know contains a vast amount of data on enemy plans and movement, locate it and hack it! this could be a major step towards our victory"];
								};
								//###################################### Steal data from research vehicle ###################
								if (_iThisTaskType == 2) then { 
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									_nearestRoad = nil;
									_nearestRoad = [[_inf1X,_inf1Y], _roadSearchRange, []] call BIS_fnc_nearestRoad;
									_roadConnectedTo = nil;
									_roadConnectedTo = roadsConnectedTo _nearestRoad;
									_objVehicle = selectRandom sideResarchTruck createVehicle [0,0,500];
									_objVehicle setPosATL getPosATL _nearestRoad;
									[[_objVehicle, ["Download research data","RandFramework\downloadResearchData.sqf",[_iTaskIndex,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
									if (count _roadConnectedTo > 0) then {
										_connectedRoad = _roadConnectedTo select 0;
										_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
										_objVehicle setDir (_direction);
									};
									_sTaskDescription = selectRandom[
										"We have seen the enemy have parked a research vehicle near the position marked.  We know they have been working on a new weapon, and belive the details of this research is located in this vehicle! locate and get the intel from it!"];
								};
								//###################################### Destroy Ammo Trucks ###################
								if (_iThisTaskType == 3) then { 
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									_nearestRoad = nil;
									_nearestRoad = selectRandom _nearestRoads;
									_roadConnectedTo = nil;
									_roadConnectedTo = roadsConnectedTo _nearestRoad;
									_sTargetName = format["objInformant%1",_iTaskIndex];
									_sTargetName2 = format["objInformant2_%1",_iTaskIndex];

									_objVehicle = nil;
									_truckType = selectRandom sideAmmoTruck ;
									_objVehicle = _truckType createVehicle [0,0,500];
									_objVehicle setVariable [_sTargetName, _objVehicle, true];
									missionNamespace setVariable [_sTargetName, _objVehicle];
									_objVehicle setPosATL getPosATL _nearestRoad;
									if (count _roadConnectedTo > 0) then {
										_connectedRoad = _roadConnectedTo select 0;
										_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
										_objVehicle setDir (_direction);
									};

									_roadsTooCloseToRoad2 = getPosATL _nearestRoad nearRoads 20; 
									_nearestRoad2 = [getPosATL _nearestRoad, _roadSearchRange, _roadsTooCloseToRoad2] call BIS_fnc_nearestRoad;
									_objVehicle2 = nil;
									_objVehicle2 = _truckType createVehicle [20,20,500];
									_objVehicle2 setVariable [_sTargetName2, _objVehicle2, true];
									missionNamespace setVariable [_sTargetName2, _objVehicle2];
									if (isNil "_nearestRoad2") then {
										_flatPos = nil;
										_flatPos = [[_inf1X,_inf1Y,0] , 10, 40, 7, 0, 0.5, 0,[],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
										_objVehicle2 setPos _flatPos;
									}
									else {
										_objVehicle2 setPosATL getPosATL _nearestRoad2;
										_roadConnectedTo2 = roadsConnectedTo _nearestRoad2;
										//hint format ["roadsConnected: %1",str(_roadConnectedTo2)];
										if (count _roadConnectedTo2 > 0) then {
											_connectedRoad2 = _roadConnectedTo2 select 0;
											_direction = [_nearestRoad2, _connectedRoad2] call BIS_fnc_DirTo;
											_objVehicle2 setDir (_direction);
										};
									};
									_triggerAmmoTruckClear = nil;
									_triggerAmmoTruckClear = createTrigger ["EmptyDetector", [0,0]];
									_triggerAmmoTruckClear setVariable ["DelMeOnNewCampaignDay",true];
									if (!_bCreateTask) then {
										_triggerAmmoTruckClear setTriggerStatements [format["!alive(%1) && !alive(%2)",_sTargetName,_sTargetName2], " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""You have destroyed enemy ammo trucks, reputation increased""; ClearedPositions pushBack (ObjectivePossitions select " + str(_iTaskIndex) + ");", ""];			
									}
									else {
										//!([InfSide%3] call FHQ_TT_areTasksCompleted)
										_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack (ObjectivePossitions select %1);",_iTaskIndex];
										_triggerAmmoTruckClear setTriggerStatements [format["!alive(%1) && !alive(%2) && !([""InfSide%3""] call FHQ_TT_areTasksCompleted)",_sTargetName,_sTargetName2,_iTaskIndex], _sKillOfficerTaskComplete, ""];	
									};
									_sTaskDescription = selectRandom[
										"Two ammo truck have been located, they are getting ready to convoy these to reinforce an area in preperation of an attack.  Locate and destroy these vehicles."];
								};
								
								//###################################### Destroy AAA ###################
								if (_iThisTaskType == 9) then { 
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									
									_sTargetName = format["objInformant%1",_iTaskIndex];
									_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
									_sTargetName3 = format["objInformant3_%1",_iTaskIndex];
									_truckType = selectRandom DestroyAAAVeh;
									sAliveCheck = format["!alive(%1) && !alive(%2) && !([""InfSide%3""] call FHQ_TT_areTasksCompleted)",_sTargetName,_sTargetName2,_iTaskIndex];

									_flatPos = nil;
									_flatPos = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos) == "[0,0,0]") then {_flatPos = [[_inf1X,_inf1Y,0] , 15, 250, 7, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;};
									_objVehicle = nil;
									_objVehicle = _truckType createVehicle [0,0,500];
									_objVehicle setVariable [_sTargetName, _objVehicle, true];
									createVehicleCrew _objVehicle;
									missionNamespace setVariable [_sTargetName, _objVehicle];
									_objVehicle setPos _flatPos;
									_objVehicle disableAI "MOVE";
									TREND_fnc_AAARadioLoop1 = {		
										_radioName = _this select 0;
										_bPlay = true;
										while {_bPlay && !isnil(_radioName)} do {
											if (!alive(call compile _radioName)) then {_bPlay = false};
											playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom EnemyRadioSounds + ".wss",call compile _radioName,false,getPosASL call compile _radioName,0.5,1,0];
											sleep selectRandom [10,15,20,30];
										};
									};
									[_sTargetName] spawn TREND_fnc_AAARadioLoop1;

									_flatPos2 = nil;
									_flatPos2 = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[[_flatPos,100]],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos2) == "[0,0,0]") then {
										sAliveCheck = format["!alive(%1) && !([""InfSide%2""] call FHQ_TT_areTasksCompleted)",_sTargetName,_iTaskIndex];
									}
									else {
										_objVehicle2 = nil;
										_objVehicle2 = _truckType createVehicle [20,20,500];
										_objVehicle2 setVariable [_sTargetName2, _objVehicle2, true];
										createVehicleCrew _objVehicle2;
										missionNamespace setVariable [_sTargetName2, _objVehicle2];
										_objVehicle2 setPos _flatPos2;
										_objVehicle2 disableAI "MOVE";
										TREND_fnc_AAARadioLoop2 = {		
											_radioName = _this select 0;
											_bPlay = true;
											while {_bPlay && !isnil(_radioName)} do {
												if (!alive(call compile _radioName)) then {_bPlay = false};
												//hint format["radio: %1",_radioName];
												playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom EnemyRadioSounds + ".wss",call compile _radioName,false,getPosASL call compile _radioName,0.5,1,0];
											sleep selectRandom [10,15,20,30];
											};
										};
										[_sTargetName2] spawn TREND_fnc_AAARadioLoop2;
									};
									
									_triggerAmmoTruckClear = nil;
									_triggerAmmoTruckClear = createTrigger ["EmptyDetector", [0,0]];
									_triggerAmmoTruckClear setVariable ["DelMeOnNewCampaignDay",true];
									if (!_bCreateTask) then {
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""You have destroyed enemy ammo trucks, reputation increased""; ClearedPositions pushBack (ObjectivePossitions select " + str(_iTaskIndex) + ");", ""];			
									}
									else {
										_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack (ObjectivePossitions select %1);",_iTaskIndex];
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, _sKillOfficerTaskComplete, ""];	
									};
									_sTaskDescription = selectRandom[
										"Two Anti Air vehicles have been causing havoc near the position marked.  Locate and destroy these ASAP!"];

								};
								//###################################### Destroy Arti ###################
								if (_iThisTaskType == 10) then { 
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									
									_sTargetName = format["objInformant%1",_iTaskIndex];
									_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
									_truckType = sArtilleryVeh ;
									sAliveCheck = format["!alive(%1) && !alive(%2) && !([""InfSide%3""] call FHQ_TT_areTasksCompleted)",_sTargetName,_sTargetName2,_iTaskIndex];

									_flatPos = nil;
									_flatPos = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos) == "[0,0,0]") then {_flatPos = [[_inf1X,_inf1Y,0] , 15, 250, 7, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;};
									_objVehicle = nil;
									_objVehicle = _truckType createVehicle [0,0,500];
									_objVehicle setVariable [_sTargetName, _objVehicle, true];
									createVehicleCrew _objVehicle;
									missionNamespace setVariable [_sTargetName, _objVehicle];
									_objVehicle setPos _flatPos;
									_objVehicle disableAI "MOVE";
									TREND_fnc_ArtiFireLoop1 = {		
											_radioName = _this select 0;
											_Ammo = getArtilleryAmmo [_radioName] select 0;
											while {true} do {
												_flatPos = nil;
												_flatPos = [getMarkerPos "mrkHQ", 1000, 1200, 20, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
												[[_radioName, 1],"setVehicleAmmo",true,false] call BIS_fnc_MP;
												[[_radioName, [_flatPos, _Ammo, 1]],"commandArtilleryFire",false,false] call BIS_fnc_MP;
												sleep selectRandom[10,30,60,120,240];
											};
										};
										[_objVehicle] spawn TREND_fnc_ArtiFireLoop1;

									_flatPos2 = nil;
									_flatPos2 = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[[_flatPos,100]],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos2) == "[0,0,0]") then {
										sAliveCheck = format["!alive(%1) && !([""InfSide%2""] call FHQ_TT_areTasksCompleted)",_sTargetName,_iTaskIndex];
									}
									else {
										_objVehicle2 = nil;
										_objVehicle2 = _truckType createVehicle [20,20,500];
										_objVehicle2 setVariable [_sTargetName2, _objVehicle2, true];
										createVehicleCrew _objVehicle2;
										missionNamespace setVariable [_sTargetName2, _objVehicle2];
										_objVehicle2 setPos _flatPos2;
										_objVehicle2 disableAI "MOVE";
										TREND_fnc_ArtiFireLoop2 = {		
											_radioName = _this select 0;
											_Ammo = getArtilleryAmmo [_radioName] select 0;
											while {true} do {
												_flatPos = nil;
												_flatPos = [getMarkerPos "mrkHQ", 1000, 1200, 20, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
												[[_radioName, 1],"setVehicleAmmo",true,false] call BIS_fnc_MP;
												[[_radioName, [_flatPos, _Ammo, 1]],"commandArtilleryFire",false,false] call BIS_fnc_MP;
												sleep selectRandom[10,30,60,120,240];
											};
										};
										[_objVehicle2] spawn TREND_fnc_ArtiFireLoop2;
									};
									
									_triggerAmmoTruckClear = nil;
									_triggerAmmoTruckClear = createTrigger ["EmptyDetector", [0,0]];
									_triggerAmmoTruckClear setVariable ["DelMeOnNewCampaignDay",true];
									if (!_bCreateTask) then {
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""You have destroyed enemy ammo trucks, reputation increased""; ClearedPositions pushBack (ObjectivePossitions select " + str(_iTaskIndex) + ");", ""];			
									}
									else {
										_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack (ObjectivePossitions select %1);",_iTaskIndex];
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, _sKillOfficerTaskComplete, ""];	
									};

									//ATTACH RADIO COMMS SOUND! (but quite)... but will need to stop sound when destroyied
									_sTaskDescription = selectRandom[
										"Two artillery vehicles have been firing rounds at and around our HQ, we need them destroyed as soon as possible!"];
								};
								 //###################################### informant,intorigate officer, weapon dealer or kill officer #########################################
								if (_iThisTaskType == 4 || _iThisTaskType == 5 || _iThisTaskType == 7 || _iThisTaskType == 8) then { //if informant,intorigate officer, weapon dealer or kill officer
									_allpositionsLaptop1 = _infBuilding buildingPos -1;
									if (InfTaskCount == 0) then {
										AllowUAVLocateHelp = true;
										publicVariable "AllowUAVLocateHelp";	
									};								
									
									_sInformant1Name = format["objInformant%1",_iTaskIndex];
									_infClassToUse = "";
									_sideToUse = EnemySide;

									if (_iThisTaskType == 4) then { //if informant
										_infClassToUse = selectRandom InformantClasses;
										_sideToUse = Civilian;
									};
									if (_iThisTaskType == 8) then { //if weapon dealer
										_infClassToUse = selectRandom WeaponDealerClasses;
										_sideToUse = Civilian;
									};
									if (_iThisTaskType == 5 || _iThisTaskType == 7) then { //if interogate officer or eleminate officer 
										_infClassToUse = selectRandom InterogateOfficerClasses;
										_sideToUse = EnemySide;
									};
	
									_objInformant = createGroup _sideToUse createUnit [_infClassToUse,[0,0,500],[],0,"NONE"];
									_objInformant setVariable [_sInformant1Name, _objInformant, true];
									missionNamespace setVariable [_sInformant1Name, _objInformant];
									_initPos = selectRandom _allpositionsLaptop1;
									_flatPosInform = nil;
									_flatPosInform = [_initPos , 10, 75, 7, 0, 0.5, 0,[],[_initPos,_initPos]] call BIS_fnc_findSafePos;	
									if (count _flatPosInform == 3) then {
										//if pos is [x,x] instead of [x,x,x] then dont setPosATL!
										_objInformant setPosATL (_flatPosInform);
									}
									else {
										_objInformant setPos (_flatPosInform);
									};
									//_objInformant setPos (getPos player);

									//_objInformant setPosATL (_initPos);
									_objInformant allowDamage false;
									_objInformant setVariable ["TaskType",_iThisTaskType,true];

									[[_objInformant, ["HitPart",
										{
											_thisInformant = ((_this select 0) select 0);
											_thisShooter =((_this select 0) select 1);
											//_hitLocation = str(((_this select 0) select 5) select 0);
											_hitLocation = ((_this select 0) select 5) select 0;
											if (bDebugMode) then {hint format["ARHH2:%1",_hitLocation];};
											if (side (_thisShooter) == West && alive(_thisInformant)) then {
												_thisInformant allowDamage true;
												_bDone = false;
												group _thisInformant setBehaviour "ALERT";
												_thisInformant switchMove "";
												_ThisTaskType = _thisInformant getVariable ["TaskType",0];
												if (!isPlayer _thisShooter && _ThisTaskType == 5) then {
													_thisInformant disableAI "anim";
													_thisInformant switchMove "Acts_CivilInjuredLegs_1"; 
													_thisInformant disableAI "anim";
													_thisInformant setHit ['legs',1];
													_thisInformant setCaptive true;
												}
												else {
													if (_hitLocation == "head" || _hitLocation == "neck" || _hitLocation == "spine1" || _hitLocation == "spine2" || _hitLocation == "spine3" || _hitLocation == "body" ) then {
														_thisInformant setDamage 1;
														_bDone = true;
													};
													if (_hitLocation == "leftleg" || _hitLocation == "rightleg" || _hitLocation == "rightupleg" || _hitLocation == "leftupleg") then {
														_ThisTaskType = _thisInformant getVariable ["TaskType",0];
														//debugMessages = debugMessages + "\nhit leg 4 - " + str(_ThisTaskType);
														if (_ThisTaskType == 5) then {
															//debugMessages = debugMessages + "\nhit leg 5 - " + _hitLocation;
															_thisInformant disableAI "anim";
															_thisInformant switchMove "Acts_CivilInjuredLegs_1"; 
															_thisInformant disableAI "anim";
															_thisInformant setHit ['legs',1];
															_thisInformant setVariable ["StopWalkScript", true, true];
															_thisInformant setCaptive true;
														}
														else {
															//debugMessages = debugMessages + "\nhit leg 6 - " + _hitLocation;
															_thisInformant setHit ['legs',1];
															//hint "hmmm2";
															//debugMessages = debugMessages + "\nOfficerShotInLeg 2";
														};			
														//debugMessages = debugMessages + "\nhit leg 7 - " + _hitLocation;											
														_bDone = true;
													};
													
													//debugMessages = debugMessages + "\nOfficerShot 3 - " + str(_hitLocation);

													if (!_bDone) then {
														_thisInformant setDamage 0.8;
													};
												};
											};

										}
									]],"addEventHandler",true,true] call BIS_fnc_MP;

									if (_bIsMainObjective && (_iThisTaskType == 5 || _iThisTaskType == 8 || _iThisTaskType == 7)) then {
										//if interrogate officer or kill weapon dealer or eleminate officer and main objective, then complete task when searched
										//its only the main objectie that we require the player to get to the body... otherwise, can kill him from a distance
										[[_objInformant, ["Search for ID","RandFramework\IdentifyHVT.sqf",[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;
									}
									else {
										if (!(_iThisTaskType == 5)) then {
											//pass in false so we know to just hint if this was our guy or not (just in case player wants to be sure before moving to next objective)
											//only need to search if its a kill objective... if for example its "interogate officer", there will already be an action to get intel
											[[_objInformant, ["Search for ID","RandFramework\IdentifyHVT.sqf",[_iTaskIndex,false],10,true,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;	
										};
									};


									if (_iThisTaskType == 5 || _iThisTaskType == 8 || _iThisTaskType == 7) then { //if interrogate officer or kill weapon dealer or eleminate officer
										if (_iThisTaskType == 5 || _iThisTaskType == 7) then {  //only give weapon if officer (not weapon dealer)
											_grpName = createGroup EnemySide;
											[_objInformant] joinSilent _grpName;
											_objInformant addMagazine "30Rnd_9x21_Mag_SMG_02";
											_objInformant addMagazine "30Rnd_9x21_Mag_SMG_02";
											_objInformant addWeapon "SMG_02_F";
										};
										if (_iThisTaskType == 5) then {
											[[_objInformant, ["Get Intel","RandFramework\interrogateOfficer.sqf",[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;
										};
										if (_iThisTaskType == 5 || _iThisTaskType == 8 || _iThisTaskType == 7) then {
											
											TREND_fnc_WalkingGuyLoop = {		
												_objManName = _this select 0;
												_thisInitPos = _this select 1;
												_objMan = missionNamespace getVariable _objManName;
												
												group _objMan setSpeedMode "LIMITED";
												group _objMan setBehaviour "SAFE";
												sleep 5; //allow five seconds for any scripts to be run on officer before he moves e.g. if set as hostage when friendly rebels)

												while {true && alive(_objMan)} do {
													_bIsShot = _objMan getVariable ["StopWalkScript", false];
													if (behaviour _objMan != "COMBAT" && !_bIsShot) then {
														[_objManName,_thisInitPos,_objMan,75] execVM "RandFramework\HVTWalkAround.sqf";
														sleep 2;
														waitUntil {sleep 1; speed _objMan < 0.5};
														sleep 10;
													};
												};
											};
											[_sInformant1Name,_initPos] spawn TREND_fnc_WalkingGuyLoop;

											if (_bIsMainObjective) then {
												//[[_objInformant, ["Search for ID","RandFramework\IdentifyHVT.sqf",[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;
											}
											else {
												if (_iThisTaskType != 5) then {
													_trgKillOfficer = nil;
													_trgKillOfficer = createTrigger ["EmptyDetector", [0,0]];
													_trgKillOfficer setTriggerArea [0, 0, 0, false];
													_trgKillOfficer setVariable ["DelMeOnNewCampaignDay",true];
													//_trgKillOfficer setTriggerStatements [format["!alive(%1)",_sInformant1Name], " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""A HVT has been eliminated, reputation increased""; ", ""];			
													if (!_bCreateTask) then {
														_trgKillOfficer setTriggerStatements [format["!alive(%1)",_sInformant1Name], " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""A HVT has been eliminated, reputation increased""; ClearedPositions pushBack (ObjectivePossitions select " + str(_iTaskIndex) + "); ", ""];			
													}
													else {
														_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack (ObjectivePossitions select %1);",_iTaskIndex];
														//sleep 2;
														//hint _sKillOfficerTaskComplete;
														//sleep 2;
														_trgKillOfficer setTriggerStatements [format["!alive(%1) && !([""InfSide%2""] call FHQ_TT_areTasksCompleted)",_sInformant1Name,_iTaskIndex], _sKillOfficerTaskComplete, ""];	
													};
												};
											};
											
										};
									}
									else {
										[[_objInformant, ["Get Intel","RandFramework\SpeakInformant.sqf",[_iTaskIndex,_bCreateTask],1,false,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;
									};
									//4=Speak with informant || 5=interrogate officer || 7=Eliminate Officer || 8=Assasinate weapon dealer

									_bodyIDRequiredText = "";
									if (_bIsMainObjective && (_iThisTaskType == 7 || _iThisTaskType == 8)) then {_bodyIDRequiredText = "<br /><br />You must search the body to identify this target!<br /><br />"};
									if (_iThisTaskType == 4) then {
										_sTaskDescription = selectRandom[
										"We have a guy that holds valuable intel on enemy plans, he is walking around the area marked, unfortunately this area is occupied, but we need this intel regardless! move in, find him and talk to him.<br />We are not exactly sure which of the following two is our guy, so look out for them both!<br />" + InformantImage];
									};
									if (_iThisTaskType == 5) then {
										_sTaskDescription = selectRandom[
										"We have located an enemy officer who is a lead role in a current operation, we need you to get as much intel from this guy as possible!<br /><br />Shoot him in the leg to incapacitate him, then approch to tie up and interrogate him!<br /><br />" + OfficerImage];
									};
									if (_iThisTaskType == 7) then {
										_sTaskDescription = selectRandom[
										"HVT located, we need him dead! his death will cause major destruction to current enemy plans" + _bodyIDRequiredText + OfficerImage];
									};
									if (_iThisTaskType == 8) then {
										_sTaskDescription = selectRandom[
										"A weapons dealer is getting ready to meet up with an enemy general, he is about to sell weapons that have been stolen from us!  locate him and assainate him. We have intel of two dealers, here they both are, it will be one of these who you need to locate, we are unsure which one!" + _bodyIDRequiredText + WeaponDealerImage];
									};

								};
								//####################BUG RADIO##########################
								if (_iThisTaskType == 6) then {
									_allpositionsRadio1 = _infBuilding buildingPos -1;
									_sRadio1Name = format["objRadio%1",_iTaskIndex];
									_objRadio1 = selectRandom SideRadioClassNames createVehicle [0,0,500];
									_objRadio1 setVariable [_sRadio1Name, _objRadio1, true];
									missionNamespace setVariable [_sRadio1Name, _objRadio1];
									_objRadio1 setPosATL (selectRandom _allpositionsRadio1);

									[[_objRadio1, ["Send transmission to HQ","RandFramework\bugRadio1.sqf",[_iTaskIndex,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
								
									TREND_fnc_RadioLoop = {		
										_radioName = _this select 0;
										_bPlay = true;
										while {_bPlay && !isnil(_radioName)} do {
											if (!alive(call compile _radioName)) then {_bPlay = false};
											//hint format["radio: %1",_radioName];
											playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom EnemyRadioSounds + ".wss",call compile _radioName,false,getPosASL call compile _radioName,0.5,1,0];
											sleep selectRandom [10,15,20,30];
										};
									};
									[_sRadio1Name] spawn TREND_fnc_RadioLoop;
									_sTaskDescription = selectRandom[
										"We need you to locate an enemy radio, we know its being used for comms of a planned attack, we need you to send the transmission to us so our team can listen in until the plans have been identified!"];
								};
								//##############################################
								debugMessages = debugMessages + format["\n_bIsMainObjective: %1",_bIsMainObjective];
								debugMessages = debugMessages + format["\n_iTaskIndex: %1",_iTaskIndex];
								debugMessages = debugMessages + format["\n_MissionTitle: %1",_MissionTitle];

								if (_bIsMainObjective) then {
									_markerInformant1 = createMarker [format["mrkMainObjective%1",_iTaskIndex], [_inf1X,_inf1Y]];
								}
								else {
									_markerInformant1 = createMarker [format["Informant%1",_iTaskIndex], [_inf1X,_inf1Y]];

								};

								_markerInformant1 setMarkerShape "ICON";
								_markerInformant1 setMarkerType _MarkerType;
								//_markerInformant1 setMarkerText _MissionTitle;
								if (_bIsMainObjective) then {
									_markerInformant1 setMarkerText format["(Main) %1 ",_MissionTitle];
								}
								else {
									if (_bCreateTask) then {
										_markerInformant1 setMarkerText format["%1 ",_MissionTitle];
									}
									else {
										_markerInformant1 setMarkerText format["(Optional) %1 ",_MissionTitle];
									};
								};

								if (_bSideMissionsCivOnly && !_bCreateTask) then {
									ClearedPositions pushBack [_inf1X,_inf1Y];
									publicVariable "ClearedPositions";
									_markerInformant1 setMarkerText "An informat is located here.  No enemy reported at this location";
									[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns,true] spawn TREND_fnc_PopulateSideMission;
								}
								else {
									[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns] spawn TREND_fnc_PopulateSideMission;
								};

								//hint _sTaskDescription;
								if (_bCreateTask) then {
									if (_bIsCampaign) then {
										[FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format["Day: %1 : %2",_iTaskIndex+1,_MissionTitle],""]] call FHQ_TT_addTasks;
										ActiveTasks pushBack format["InfSide%1",_iTaskIndex]; 
										publicVariable "ActiveTasks";	
									}
									else {
										[FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format["%1 : %2",_iTaskIndex+1,_MissionTitle],""]] call FHQ_TT_addTasks;
										ActiveTasks pushBack format["InfSide%1",_iTaskIndex]; 
										publicVariable "ActiveTasks";	
									};
								};

								//_triggerSidePassClear = createTrigger ["EmptyDetector", [_inf1X,_inf1Y]];
								//_triggerSidePassClear setTriggerArea [2000, 2000, 0, false];
								//_triggerSidePassClear setTriggerStatements ["false", "{deleteVehicle _x} forEach nearestObjects [this, [""all""], 2000]", ""];		
								

							};	
						}
						else {
							_bInfor1Found = false;
						};

					};
				};
				if (InfTaskCount == 0) then {
					CurrentZeroMissionTitle = _MissionTitle; //curently only used for campaign
					publicVariable "CurrentZeroMissionTitle";

				};
				InfTaskCount = InfTaskCount + 1;
			//};

	};
};


_trgComplete = createTrigger ["EmptyDetector", [0,0]];
_trgComplete setVariable ["DelMeOnNewCampaignDay",true];
_trgComplete setTriggerArea [0, 0, 0, false];
if (iMissionParamType == 5) then {
	//MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""
	if (MaxBadPoints >= 10) then {
		_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "[FriendlySide, [""DeBrief"", ""Return to HQ to debrief"", ""Debrief"", """"]] call FHQ_TT_addTasks;  [[""CAMPAIGN_END""],""RandFramework\Campaign\SetMissionBoardOptions.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];}; deletevehicle thisTrigger", ""];
	}
	else {
		_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "hint ""return to base for next assignment!""; [[""MISSION_COMPLETE""],""RandFramework\Campaign\SetMissionBoardOptions.sqf""] remoteExec [""BIS_fnc_execVM"",0,true]; if (ActiveTasks call FHQ_TT_areTasksSuccessful) then {MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""}; deletevehicle thisTrigger", ""];
	}
}
else {
	//_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "", ""]; //not sure why this is here... commented out on 5th Jan 2018... delete of no issues sinse

	//If not campaign and rep is disabled, then we will not fail the mission if rep low, but will be a task to keep rep above average
	if (iMissionParamRepOption == 0) then {
		//CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
		[FriendlySide, ["tskKeepAboveAverage","Make too many mistakes, kill civs, lose too many units, your reputation will lower.  Try not to make too many errors","(optional) Uphold reputation",""]] call FHQ_TT_addTasks;
		["tskKeepAboveAverage", "succeeded"] call FHQ_TT_setTaskState;
	};
	if (iMissionParamRepOption == 1) then {
		//CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
		[FriendlySide, ["tskKeepAboveAverage","Make too many mistakes, kill civs, lose too many units, your reputation will lower.  Try not to make too many errors","!!Must uphold reputation!!",""]] call FHQ_TT_addTasks;
		["tskKeepAboveAverage", "succeeded"] call FHQ_TT_setTaskState;
	};
	
};


_bMoveToAO = false;
if (iStartLocation == 2) then {
	_bMoveToAO = selectRandom [true,false];
};
if (iStartLocation == 1) then {
	_bMoveToAO = true;
};
if (_bMoveToAO) then {
	_mainAOPos = ObjectivePossitions select 0;
	_flatPos = nil;
	_flatPos = [_mainAOPos , 1300, 1700, 8, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (str(_flatPos) == "[0,0,0]") then {_flatPos = [_mainAOPos , 1300, 2000, 8, 0, 0.4, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;};
	//"Marker1" setMarkerPos _flatPos;

	 	
	_nearestAOStartRoads = _flatPos nearRoads 100;
	_bAOStartRoadFound = false;
	if (count _nearestAOStartRoads > 0) then {
		_bAOStartRoadFound = true;

		_thisPosAreaOfCheckpoint = _flatPos;
		_thisRoadOnly = true;
		_thisSide = west; 
		_thisUnitTypes = FriendlyCheckpointUnits;
		_thisAllowBarakade = true;
		_thisIsDirectionAwayFromAO = false;
		[_flatPos,_flatPos,50,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,FriendlyScoutVehicles,500] execVM "RandFramework\setCheckpoint.sqf";
	};



	_markerFastResponseStart = createMarker ["mrkFastResponseStart", _flatPos];	
	_markerFastResponseStart setMarkerShape "ICON";
	_markerFastResponseStart setMarkerType "hd_dot";
	_markerFastResponseStart setMarkerText "Kilo 1 - Camp";
	//k1Car1 setPos _flatPos;
	//k1Car2 setPos _flatPos;

	_behindBlockPos = _flatPos;

	_flatPosCampFire = _behindBlockPos;
	_campFire = "Campfire_burning_F" createVehicle _flatPosCampFire;
	_campFire setDir (floor(random 360));


	if (!_bAOStartRoadFound) then {
		_flatPosTent1 = nil;
		_flatPosTent1 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
		_Tent1 = "Land_TentA_F" createVehicle _flatPosTent1;
		_Tent1 setDir (floor(random 360));

		_flatPos2 = nil;
		_flatPos2 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
		_Tent2 = "Land_TentA_F" createVehicle _flatPos2;
		_Tent2 setDir (floor(random 360));

		_Tent1 addAction ["Remove small vehicle from tent",{_veh = selectRandom SmallTransportVehicle createVehicle (getPos (_this select 0));}]; 
		_Tent2 addAction ["Remove small vehicle from tent",{_veh = selectRandom SmallTransportVehicle createVehicle (getPos (_this select 0));}]; 
	};
	
	_flatPos4 = nil;
	_flatPos4 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
	_Tent4 = "Land_WoodPile_F" createVehicle _flatPos4;
	_Tent4 setDir (floor(random 360));

	if (iMissionParamType == 5) then {
		_flatPos4b = nil;
		_flatPos4b = [_flatPosCampFire , 5, 10, 3, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
		endMissionBoard2 setPos _flatPos4b;
		_boardDirection = [_campFire, endMissionBoard2] call BIS_fnc_DirTo;
		endMissionBoard2 setDir _boardDirection;

	};

	_flatPos5 = nil;
	_flatPos5 = [_flatPosCampFire, 12, 30, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	_car1 = selectRandom FriendlyFastResponseVehicles createVehicle _flatPos5;
	_car1 allowDamage false;
	_car1 setDir (floor(random 360));

	_flatPos6 = nil;
	_flatPos6 = [_flatPosCampFire, 12, 30, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	_car2 = selectRandom FriendlyFastResponseVehicles createVehicle _flatPos6;
	_car2 allowDamage false;
	_car2 setDir (floor(random 360));
	sleep 1;
	_car1 allowDamage true;
	_car2 allowDamage true;

	[_car1, ["Unload Dingy","RandFramework\UnloadDingy.sqf"]] remoteExec ["addAction", 0];
	[_car2, ["Unload Dingy","RandFramework\UnloadDingy.sqf"]] remoteExec ["addAction", 0];
	[_car1,FastResponseCarItems] call bis_fnc_initAmmoBox;
	[_car2,FastResponseCarItems] call bis_fnc_initAmmoBox;

	_flatPos7 = nil;
	_flatPos7 = [_flatPosCampFire, 5, 12, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
	_AmmoBox1 = "C_T_supplyCrate_F" createVehicle _flatPos7;
	_AmmoBox1 allowDamage false;
	_AmmoBox1 setDir (floor(random 360));
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		[_AmmoBox1,InitialBoxItemsWithAce] call bis_fnc_initAmmoBox;
	}
	else {
		[_AmmoBox1,InitialBoxItems] call bis_fnc_initAmmoBox;
	};
	if (AdvancedSettings select ADVSET_VIRTUAL_ARSENAL_IDX == 1) then {
		_AmmoBox1 addAction ["<t color='#ff1111'>Virtual Arsenal</t>", {["Open",true] spawn BIS_fnc_arsenal}];
	};

	_flatPosUnits = [_flatPosCampFire, 8, 17, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
	if (!isnil "sl") then {sl setPos _flatPosUnits};
	if (!isnil "k1_2") then {k1_2 setPos _flatPosUnits};
	if (!isnil "k1_3") then {k1_3  setPos _flatPosUnits};
	if (!isnil "k1_4") then {k1_4  setPos _flatPosUnits};
	if (!isnil "k1_5") then {k1_5  setPos _flatPosUnits};
	_bGroupFound = false;
	{
		if (_x getVariable ["IsFRT",false] && !_bGroupFound) then {
			{
				_bGroupFound = true;
				_x setPos _flatPosUnits;
			} forEach units group _x;			
		};
	} forEach allUnits;

};




//now we have all our location positinos, we can set other area stuff
[] execVM "RandFramework\RandScript\TREND_fnc_setOtherAreaStuff.sqf";




publicVariable "debugMessages";

hint "And so it begins!";


[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
