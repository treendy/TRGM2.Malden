if (bDebugMode) then {["Mission Setup: 16"] remoteExec ["systemChat", 0];};

#include "..\RandFramework\RandScript\trendFunctions.sqf";

//This is only ever called on server!!!!
if (bDebugMode) then {["Mission Setup: 15"] remoteExec ["systemChat", 0];};

TRGM_Logic setVariable ["DeathRunning", false, true];


if (bDebugMode) then {["Mission Setup: 14.5"] remoteExec ["systemChat", 0];};

_ThisTaskTypes = nil;
_IsMainObjs = nil;
_MarkerTypes = nil;
_CreateTasks = nil;
_SamePrevAOStats = nil;
_bIsCampaign = false;
_bIsCampaignFinalMission = false;
_bSideMissionsCivOnly = nil;

_MainMissionTasksToUse = MainMissionTasks;
_SideMissionTasksToUse1 = SideMissionTasks;
_SideMissionTasksToUse2 = SideMissionTasks;
if (iMissionParamObjective > 0) then {
	_MainMissionTasksToUse = [iMissionParamObjective];
	_SideMissionTasksToUse1 = [iMissionParamObjective];
};
if (iMissionParamObjective2 > 0) then {
	_SideMissionTasksToUse1 = [iMissionParamObjective2];
};
if (iMissionParamObjective3 > 0) then {
	_SideMissionTasksToUse2 = [iMissionParamObjective3];
};

if (bDebugMode) then {["Mission Setup: 14"] remoteExec ["systemChat", 0];};

iMissionSetup = iMissionParamType;
//_IsMainObjs: if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
switch (iMissionSetup) do {
	case 0: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		_IsMainObjs = [true,false,false];
		_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
		_CreateTasks = [true,false,false];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		MaxBadPoints = 1;
	};
	case 1: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom MissionsThatHaveIntel,selectRandom MissionsThatHaveIntel];
		_IsMainObjs = [true,false,false];
		_MarkerTypes = ["empty","hd_dot","hd_dot"];
		_CreateTasks = [true,false,false];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		MaxBadPoints = 1;
	};
	case 2: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
		_IsMainObjs = [true];
		_MarkerTypes = ["mil_objective"]; //INFORMANT: changed this back to mil_objective
		_CreateTasks = [true];
		_SamePrevAOStats = [false];
		_bSideMissionsCivOnly = [false];
		MaxBadPoints = 1;
	};
	case 3: {
		if (selectRandom [true,false,false]) then {
			_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1,4];
			_IsMainObjs = [false,false];
			_MarkerTypes = ["mil_objective","hd_dot"];
			_CreateTasks = [true,false];
			_SamePrevAOStats = [false,false];
			_bSideMissionsCivOnly = [false,true];
		}
		else {
			_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1];
			_IsMainObjs = [false];
			_MarkerTypes = ["mil_objective"];
			_CreateTasks = [true];
			_SamePrevAOStats = [false];
			_bSideMissionsCivOnly = [false];
		};
		MaxBadPoints = 1;
	};
	case 4;
	case 7: { //7 = as 4 but with hidden markers
		if (iMissionParamObjective > 0) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		}
		else {
			_ThisTaskTypes = [selectRandom SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		};
		_IsMainObjs = [false,false,false];
		_MarkerTypes = [["mil_objective","mil_objective","mil_objective"], ["empty","empty","empty"]] select (iMissionSetup == 7);
		_CreateTasks = [true,true,true];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		MaxBadPoints = 1;
	};
	case 5: { //campaign
		_totalRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
		if (_totalRep >= 10) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom MissionsThatHaveIntel,selectRandom MissionsThatHaveIntel];
			_IsMainObjs = [true,false,false];
			_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
			_CreateTasks = [true,false,false];
			_SamePrevAOStats = [false,false,false];
			_bSideMissionsCivOnly = [false,false,false];
			_bIsCampaignFinalMission = true;
		}
		else {
			if (selectRandom [true,false,false]) then {
				_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1,4];
				_IsMainObjs = [false,false];
				_MarkerTypes = ["mil_objective","hd_dot"];
				_CreateTasks = [true,false];
				_SamePrevAOStats = [false,false];
				_bSideMissionsCivOnly = [false,true];
			}
			else {
				_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1];
				_IsMainObjs = [false];
				_MarkerTypes = ["mil_objective"];
				_CreateTasks = [true];
				_SamePrevAOStats = [false];
				_bSideMissionsCivOnly = [false];
			};
		};
		_bIsCampaign = true;
	};
	case 6: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse1];
		_IsMainObjs = [true,false,false];
		_MarkerTypes = ["mil_objective","empty","empty"];
		_CreateTasks = [true,false,false];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		MaxBadPoints = 1;
	};
	case 8: { //Heavy Mission, hidden AO and mission type
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
		_IsMainObjs = [true,false,false];
		_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
		_CreateTasks = [true,true,false];
		_SamePrevAOStats = [false,true,false];
		_bSideMissionsCivOnly = [false,false,true];
		MaxBadPoints = 1;
	};
	case 9: { //Heavy Mission (two objectives at AO, chance of side)
		if (selectRandom[true,false]) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1];
			_IsMainObjs = [false,false];
			_MarkerTypes = ["mil_objective","hd_dot"];
			_CreateTasks = [true,true];
			_SamePrevAOStats = [false,true];
			_bSideMissionsCivOnly = [false,false];
		}
		else {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
			_IsMainObjs = [false,false,false];
			_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
			_CreateTasks = [true,true,false];
			_SamePrevAOStats = [false,true,false];
			_bSideMissionsCivOnly = [false,false,true];
		};
		MaxBadPoints = 1;
	};
	case 10: { //Hidden Full map Heavy Mission
		IsFullMap = true;
		publicVariable "IsFullMap";
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
		_IsMainObjs = [true];
		_MarkerTypes = ["empty"];
		_CreateTasks = [true];
		_SamePrevAOStats = [false];
		_bSideMissionsCivOnly = [false];
		MaxBadPoints = 1;
	};
};


//HERE.... two objectives at one AO : as above, but also... randomo chance of third mission (inttel or mission)

if (!(isNil "IsTraining")) then {
		_ThisTaskTypes = [12,8,3];
		_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
		_CreateTasks = [true,true,true];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		MaxBadPoints = 100;
};

MissionParamsSet = true;
publicVariable "MissionParamsSet";

if (bDebugMode) then {["Mission Setup: 13"] remoteExec ["systemChat", 0];};

publicVariable "MaxBadPoints";

_randInfor1X = nil;
_randInfor1Y = nil;
_buildings = nil;

//mission title string per task type (index = task type, 1..12; custom missions 13+ set their own)
_MissionTitleKeys = [
	"",
	"STR_TRGM2_startInfMission_MissionTitle1", //1 Hack Data
	"STR_TRGM2_startInfMission_MissionTitle2", //2 Steal data from research vehicle
	"STR_TRGM2_startInfMission_MissionTitle3", //3 Destroy Ammo Trucks
	"STR_TRGM2_startInfMission_MissionTitle4", //4 Speak with informant
	"STR_TRGM2_startInfMission_MissionTitle5", //5 interrogate officer
	"STR_TRGM2_startInfMission_MissionTitle6", //6 Transmit Enemy Comms to HQ
	"STR_TRGM2_startInfMission_MissionTitle7", //7 Eliminate Officer   -   gain 1 point if side, if main, need to id him before complete
	"STR_TRGM2_startInfMission_MissionTitle8", //8 Assasinate weapon dealer   -   gain 1 point if side, no intel from him... if main need to id him before complete
	"STR_TRGM2_startInfMission_MissionTitle9", //9 Destroy AAA vehicles
	"STR_TRGM2_startInfMission_MissionTitle10", //10 Destroy Artillery vehicles
	"STR_TRGM2_Rescue_POW", //11
	"STR_TRGM2_Rescue_Reporter" //12
];

if (bDebugMode) then {["Mission Setup: 12.5"] remoteExec ["systemChat", 0];};

while {(InfTaskCount < count _ThisTaskTypes)} do {
	_iTaskIndex = 0;
	if (_bIsCampaign) then {
		_iTaskIndex = (iCampaignDay-1) + InfTaskCount;
	}
	else {
		_iTaskIndex = InfTaskCount;
	};

	_iThisTaskType = _ThisTaskTypes select InfTaskCount;


_bIsMainObjective = _IsMainObjs select InfTaskCount;  //more chance of bad things, and set middle area stuff around (comms, base etc...)
	_MarkerType = _MarkerTypes select InfTaskCount; //"Empty" or other
	_bCreateTask = _CreateTasks select InfTaskCount;
	_SamePrevAO = _SamePrevAOStats select InfTaskCount;
	_allowFriendlyIns = true;
	_bSideMissionsCivOnlyToUse = _bSideMissionsCivOnly select InfTaskCount;
	_hideTitleAndDesc = false;

	if (_MarkerTypes select 0 == "empty") then {
		MainIsHidden = true;
		publicVariable "MainIsHidden";
	}
	else {
		MainIsHidden = false;
		publicVariable "MainIsHidden";
	};

if (bDebugMode) then {["Mission Setup: 12"] remoteExec ["systemChat", 0];};

	if (true) then {
		InfTaskStarted = true;
		publicVariable "InfTaskStarted";


			//InformantStuff
			SideCompleted = [];
			publicVariable "SideCompleted";

				SideCompleted pushBack False;
				publicVariable "SideCompleted";
				_bInfor1Found = false;

				_MissionTitle = "";
				_RequiresNearbyRoad = false;
				_roadSearchRange = 20;
				_CustomMissionEnabled = false;

				_bNewTaskSetup = false;
				if (bDebugMode) then {["Mission Setup: 11"] remoteExec ["systemChat", 0];};

				if (_iThisTaskType >= 1 && _iThisTaskType < count _MissionTitleKeys) then {_MissionTitle = localize (_MissionTitleKeys select _iThisTaskType)};
				if (_iThisTaskType == 13) then {
					#include "..\RandFramework\CustomMission\Mission13.sqf"; //defuse 3 IEDs
					[] call fnc_CustomVars;
				};	
				if (_iThisTaskType == 14) then {
					#include "..\RandFramework\CustomMission\Mission14.sqf"; //defuse bomb
					[] call fnc_CustomVars;
				};	
				if (_iThisTaskType == 15) then {
					#include "..\RandFramework\CustomMission\Mission15.sqf"; //Search and Destroy
					[] call fnc_CustomVars;
				};	
				if (_iThisTaskType == 16) then {
					#include "..\RandFramework\CustomMission\Mission16.sqf"; //Search and Destroy
					[] call fnc_CustomVars;
				};			
				if (_iThisTaskType == 17) then {
					#include "..\RandFramework\CustomMission\Mission17.sqf"; //Clear Area
					[] call fnc_CustomVars;
				};	
				if (_iThisTaskType == 99999) then {
					#include "..\RandFramework\CustomMission\customMission.sqf"; //meeting assasination
					[] call fnc_CustomVars;					
				};

				if (_iThisTaskType > 12 && _iThisTaskType < 99999) then {
					_bNewTaskSetup = true; 
				};	


				//user defined AO location for the first three tasks (Mission1Loc..Mission3Loc)
				_sUserAOLocVar = format["Mission%1Loc",_iTaskIndex+1];
				_bUserDefinedAO = _iTaskIndex < 3 && {!isNil _sUserAOLocVar};

				//kill leader (he will run away in car to AO)    ::   save stranded guys    ::      
				if (bDebugMode) then {["Mission Setup: 10"] remoteExec ["systemChat", 0];};
				_attempts = 0;
				while {!_bInfor1Found} do {
					_attempts = _attempts + 1;
					if (bDebugMode) then {["Mission Setup: 9"] remoteExec ["systemChat", 0];};
					_markerInformant1 = nil;


if (!_SamePrevAO || _bUserDefinedAO || _attempts > 100) then {
						_randInfor1X = 0 + (floor random 25000);
						_randInfor1Y = 0 + (floor random 25000);
						_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], BasicBuildings, 200];
						if (_bUserDefinedAO && !_bIsCampaign) then {
							_userAOLoc = missionNamespace getVariable _sUserAOLocVar;
							_randInfor1X = _userAOLoc select 0;
							_randInfor1Y = _userAOLoc select 1;
							_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], BasicBuildings, 50*_attempts];
							if (_attempts > 100) then {hint format["Still no location found after %1 attempts!",_attempts]}
						};
						
						
					};

					
					_isPosFarEnoughFromHq = (getMarkerPos "mrkHQ" distance [_randInfor1X, _randInfor1Y]) > SideMissionMinDistFromBase;
					_playerSelectedAo = false;
					if (AdvancedSettings select ADVSET_SELECT_AO_IDX == 1) then {
						_playerSelectedAo = true;
					};

					if ((_isPosFarEnoughFromHq || _playerSelectedAo) && (count _buildings) > 0) then {
						_bInfor1Found = true;
						_infBuilding = selectRandom _buildings;
						_infBuilding setDamage 0;
						_allBuildingPos = _infBuilding buildingPos -1;
						_inf1X = position _infBuilding select 0;
						_inf1Y = position _infBuilding select 1;
						if (count _allBuildingPos > 2) then {

							_TasksToValidate = [_iThisTaskType];
							if (count _SamePrevAOStats > InfTaskCount+1) then {
								if (_SamePrevAOStats select (InfTaskCount + 1)) then {
									_TasksToValidate = _TasksToValidate + [_ThisTaskTypes select (InfTaskCount + 1)];
									if (count _SamePrevAOStats > InfTaskCount+2) then {
										if (_SamePrevAOStats select (InfTaskCount + 2)) then {
											_TasksToValidate = _TasksToValidate + [_ThisTaskTypes select (InfTaskCount + 2)];
										};	
									};
								};
							};

							_nearestRoads = nil;
							{
								if (_x == 99999 || _bNewTaskSetup) then {
									_bCustomRequiredPass = true;
									if (_CustomMissionEnabled || _bNewTaskSetup) then {_bCustomRequiredPass = [_infBuilding,_inf1X,_inf1Y] call fnc_CustomRequired;};							
									if (!_bCustomRequiredPass) then {_bInfor1Found = false};
								};		

								if (_x == 3) then {_roadSearchRange = 100;};
								_nearestRoads = [_inf1X,_inf1Y] nearRoads _roadSearchRange;					
								if (_x == 2 || _x == 3 || _RequiresNearbyRoad) then { //2 = retrive tank << so we need a nearby road
									if (count _nearestRoads == 0) then {
										_bInfor1Found = false;
									};
								};
							} forEach _TasksToValidate;


							if (_bInfor1Found) then {
								ObjectivePossitions pushBack [_inf1X,_inf1Y];
								publicVariable "ObjectivePossitions";
								if (_MarkerType == "empty") then {
									HiddenPossitions pushBack [_inf1X,_inf1Y];
									publicVariable "HiddenPossitions";
									_hideTitleAndDesc = true;
								};
								_sTaskDescription = "";
								if (ISUNSUNG) then {
									if (_iThisTaskType == 6) then {
										_radio = "uns_radio2_transitor_NVA" createVehicle (selectRandom (_infBuilding buildingPos -1));
									}
									else {
										_radio = selectRandom ["uns_radio2_nva_radio","uns_radio2_transitor_NVA","uns_radio2_transitor_NVA"] createVehicle (selectRandom (_infBuilding buildingPos -1));
									};

								};
								//###################################### CUSTOM MISSION ###################
				
								if (bDebugMode) then {["Mission Setup: 8-0-10"] remoteExec ["systemChat", 0];};
								if (_iThisTaskType == 99999 || _bNewTaskSetup) then {
									[_MarkerType,_infBuilding,_inf1X,_inf1Y,_roadSearchRange, _bCreateTask, _iTaskIndex, _bIsMainObjective] call fnc_CustomMission;		
								};
								//###################################### Hack Data ###################
								if (bDebugMode) then {["Mission Setup: 8-0-9"] remoteExec ["systemChat", 0];};
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
									[_objLaptop1, [localize "STR_TRGM2_startInfMission_MissionTitle1","RandFramework\hackIntel1.sqf",[_iTaskIndex,_bCreateTask]]] remoteExec ["addAction", 0, true];
									_sTaskDescription = selectRandom[
										localize "STR_TRGM2_startInfMission_MissionTitle1_Desc1",
										localize "STR_TRGM2_startInfMission_MissionTitle1_Desc2"];
								};
								//###################################### Steal data from research vehicle ###################
								if (bDebugMode) then {["Mission Setup: 8-0-8"] remoteExec ["systemChat", 0];};
								if (_iThisTaskType == 2) then {
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									_nearestRoad = nil;
									_nearestRoad = [[_inf1X,_inf1Y], _roadSearchRange, []] call BIS_fnc_nearestRoad;
									_roadConnectedTo = nil;
									_roadConnectedTo = roadsConnectedTo _nearestRoad;
									_objVehicle = selectRandom sideResarchTruck createVehicle [0,0,500];
									_objVehicle setPosATL getPosATL _nearestRoad;
									[_objVehicle, [localize "STR_TRGM2_startInfMission_MissionTitle2_Button","RandFramework\downloadResearchData.sqf",[_iTaskIndex,_bCreateTask]]] remoteExec ["addAction", 0, true];
									if (count _roadConnectedTo > 0) then {
										_connectedRoad = _roadConnectedTo select 0;
										_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
										_objVehicle setDir (_direction);
									};
									_sTaskDescription = selectRandom[
										localize "STR_TRGM2_startInfMission_MissionTitle2_Desc"];
								};
								//###################################### Destroy Ammo Trucks ###################
								if (bDebugMode) then {["Mission Setup: 8-0-7"] remoteExec ["systemChat", 0];};
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
										if (count _roadConnectedTo2 > 0) then {
											_connectedRoad2 = _roadConnectedTo2 select 0;
											_direction = [_nearestRoad2, _connectedRoad2] call BIS_fnc_DirTo;
											_objVehicle2 setDir (_direction);
										};
									};
									_sAliveCheck = format["!alive(%1) && !alive(%2)",_sTargetName,_sTargetName2];
									if (_bCreateTask) then {_sAliveCheck = _sAliveCheck + format[" && !([""InfSide%1""] call FHQ_TT_areTasksCompleted)",_iTaskIndex]};
									[_sAliveCheck, _iTaskIndex, _bCreateTask, "Destroyed ammo trucks", localize "STR_TRGM2_startInfMission_MissionTitle3_Destory"] call TRGM_fnc_createObjectiveClearedTrigger;
									_sTaskDescription = selectRandom[
										localize "STR_TRGM2_startInfMission_MissionTitle3_Desc"];
								};

								//###################################### Destroy AAA / Destroy Arti ###################
								if (bDebugMode) then {["Mission Setup: 8-0-6"] remoteExec ["systemChat", 0];};
								if (bDebugMode) then {["Mission Setup: 8-0-5"] remoteExec ["systemChat", 0];};
								if (_iThisTaskType == 9 || _iThisTaskType == 10) then { //9 = AAA, 10 = artillery
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };

									_bIsAAA = _iThisTaskType == 9;
									_sTargetName = format["objInformant%1",_iTaskIndex];
									_sTargetName2 = format["objInformant2_%1",_iTaskIndex];
									_truckType = if (_bIsAAA) then {selectRandom DestroyAAAVeh} else {sArtilleryVeh};
									_loopFnc = if (_bIsAAA) then {TRGM_fnc_radioChatterLoop} else {TRGM_fnc_artilleryFireLoop};
									_sAliveCheck = format["!alive(%1) && !alive(%2) && !([""InfSide%3""] call FHQ_TT_areTasksCompleted)",_sTargetName,_sTargetName2,_iTaskIndex];

									_flatPos = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos) == "[0,0,0]") then {_flatPos = [[_inf1X,_inf1Y,0] , 15, 250, 7, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;};
									[_truckType, _sTargetName, _flatPos, _loopFnc] call TRGM_fnc_createObjectiveVehicle;

									_flatPos2 = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[[_flatPos,100]],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos2) == "[0,0,0]") then {
										_sAliveCheck = format["!alive(%1) && !([""InfSide%2""] call FHQ_TT_areTasksCompleted)",_sTargetName,_iTaskIndex];
									}
									else {
										[_truckType, _sTargetName2, _flatPos2, _loopFnc, [20,20,500]] call TRGM_fnc_createObjectiveVehicle;
									};

									if (_bIsAAA) then {
										[_sAliveCheck, _iTaskIndex, _bCreateTask, "Destroyed AAA", localize "STR_TRGM2_startInfMission_MissionTitle9_Destory"] call TRGM_fnc_createObjectiveClearedTrigger;
										_sTaskDescription = localize "STR_TRGM2_startInfMission_MissionTitle9_Desc";
									}
									else {
										[_sAliveCheck, _iTaskIndex, _bCreateTask, "Destroyed Artillery", localize "STR_TRGM2_startInfMission_MissionTitle10_Destory"] call TRGM_fnc_createObjectiveClearedTrigger;
										_sTaskDescription = localize "STR_TRGM2_startInfMission_MissionTitle10_Desc";
									};
								};
								 //###################################### informant,intorigate officer, weapon dealer or kill officer, POW #########################################
								 if (bDebugMode) then {["Mission Setup: 8-4"] remoteExec ["systemChat", 0];};
								if (_iThisTaskType == 4 || _iThisTaskType == 5 || _iThisTaskType == 7 || _iThisTaskType == 8 || _iThisTaskType == 11 || _iThisTaskType == 12) then { //if informant,intorigate officer, weapon dealer or kill officer or rescue POW, rescue reporter

									_allpositionsLaptop1 = _infBuilding buildingPos -1;
									if (InfTaskCount == 0) then {
										AllowUAVLocateHelp = true;
										publicVariable "AllowUAVLocateHelp";
									};

									_sInformant1Name = format["objInformant%1",_iTaskIndex];
									_infClassToUse = "";
									_sideToUse = EnemySide;

									switch (_iThisTaskType) do {
										case 4: {_infClassToUse = selectRandom InformantClasses; _sideToUse = Civilian;}; //informant
										case 8: {_infClassToUse = selectRandom WeaponDealerClasses; _sideToUse = Civilian;}; //weapon dealer
										case 5;
										case 7: {_infClassToUse = selectRandom InterogateOfficerClasses; _sideToUse = EnemySide;}; //interogate officer or eleminate officer
										case 11: {_infClassToUse = selectRandom FriendlyVictims; _sideToUse = West;}; //rescue POW
										case 12: {_infClassToUse = selectRandom Reporters; _sideToUse = Civilian;}; //rescue reporter
									};
	
									_objInformant = createGroup _sideToUse createUnit [_infClassToUse,[0,0,500],[],0,"NONE"];
									_objInformant setVariable [_sInformant1Name, _objInformant, true];
									_objInformant setVariable ["taskIndex",_iTaskIndex, true];
									missionNamespace setVariable [_sInformant1Name, _objInformant];
									sleep 0.2;
									_MissionTitle = _MissionTitle + ": " + name _objInformant;
									if (_iThisTaskType == 11 || _iThisTaskType == 12) then { //if POW or reporter
										[_objInformant,["Carry",{
											_civ=_this select 0; 
											_player=_this select 1;
											[_civ, _player] execVM "RandFramework\CarryAndJoinWounded.sqf";		
											ClearedPositions pushBack ([ObjectivePossitions, _player] call BIS_fnc_nearestPosition);	
											publicVariable "ClearedPositions";
										}]] remoteExecCall ["addAction", 0];
									}; 
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

									_objInformant allowDamage false;
									_objInformant setVariable ["TaskType",_iThisTaskType,true];

									[_objInformant, ["HitPart",
										{
											_thisInformant = ((_this select 0) select 0);
											_thisShooter =((_this select 0) select 1);
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
														if (_ThisTaskType == 5) then {
															_thisInformant disableAI "anim";
															_thisInformant switchMove "Acts_CivilInjuredLegs_1";
															_thisInformant disableAI "anim";
															_thisInformant setHit ['legs',1];
															_thisInformant setVariable ["StopWalkScript", true, true];
															_thisInformant setCaptive true;
															removeAllWeapons _thisInformant;
														}
														else {
															_thisInformant setHit ['legs',1];
														};
														_bDone = true;
													};


													if (!_bDone) then {
														_thisInformant setDamage 0.8;
													};
												};
											};

										}
									]] remoteExec ["addEventHandler", 0, true];

									if (_bIsMainObjective && (_iThisTaskType == 5 || _iThisTaskType == 8 || _iThisTaskType == 7)) then {
										//if interrogate officer or kill weapon dealer or eleminate officer and main objective, then complete task when searched
										//its only the main objectie that we require the player to get to the body... otherwise, can kill him from a distance
										[_objInformant, [localize "STR_TRGM2_startInfMission_MissionTitle8_Button","RandFramework\IdentifyHVT.sqf",[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
									}
									else {
										if (!(_iThisTaskType == 5)) then {
											//pass in false so we know to just hint if this was our guy or not (just in case player wants to be sure before moving to next objective)
											//only need to search if its a kill objective... if for example its "interogate officer", there will already be an action to get intel
											[_objInformant, [localize "STR_TRGM2_startInfMission_MissionTitle8_Button","RandFramework\IdentifyHVT.sqf",[_iTaskIndex,false],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
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
											[_objInformant, [localize "STR_TRGM2_startInfMission_MissionTitle8_Button2","RandFramework\interrogateOfficer.sqf",[_iTaskIndex,_bCreateTask],10,true,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
										};
										//5 second delay allows any scripts to be run on officer before he moves e.g. if set as hostage when friendly rebels
										[_sInformant1Name,_initPos,75,false,5] spawn TRGM_fnc_walkingGuyLoop;

										if (!_bIsMainObjective) then {
											if (_iThisTaskType != 5) then {
												_sAliveCheck = format["!alive(%1)",_sInformant1Name];
												if (_bCreateTask) then {_sAliveCheck = _sAliveCheck + format[" && !([""InfSide%1""] call FHQ_TT_areTasksCompleted)",_iTaskIndex]};
												_trgKillOfficer = [_sAliveCheck, _iTaskIndex, _bCreateTask, "HVT Killed", localize "STR_TRGM2_startInfMission_MissionTitle8_Eliminated"] call TRGM_fnc_createObjectiveClearedTrigger;
												_trgKillOfficer setTriggerArea [0, 0, 0, false];
											};
										};
									}
									else {

										if (_iThisTaskType == 4) then {
											[_objInformant, [localize "STR_TRGM2_startInfMission_MissionTitle8_Button2","RandFramework\SpeakInformant.sqf",[_iTaskIndex,_bCreateTask],1,false,true,"","_this distance _target < 3"]] remoteExec ["addAction", 0, true];
										};
										if (_iThisTaskType == 11 || _iThisTaskType == 12) then { //pow or reporter
											_allowFriendlyIns = false;
											[_objInformant, "Acts_ExecutionVictim_Loop"] remoteExec ["switchMove", 0];
											_objInformant setCaptive true;
											_objInformant setDamage 0.8;
											_objInformant setHitPointDamage ["hitLegs", 1];
											//_sideMainBuilding
											_allpositionsMainBuiding = _infBuilding buildingPos -1;
											_objInformant setPosATL (selectRandom _allpositionsMainBuiding);
											removeAllWeapons _objInformant;
											[_objInformant,["Join Group",{
													_civ=_this select 0; 
													_player=_this select 1;
													[_civ] join (group _player);
													_civ enableAI "MOVE"; 
													_civ switchMove "Acts_ExecutionVictim_Unbow"; 
													_civ enableAI "anim";
													_civ setCaptive false;
													addSwitchableUnit _civ;
													_taskIndex = _civ getVariable ["taskIndex",-1];
													ClearedPositions pushBack ([ObjectivePossitions, getPos _civ] call BIS_fnc_nearestPosition);
													publicVariable "ClearedPositions";
											}]] remoteExecCall ["addAction", 0];

											TREND_fnc_POWCheck = {		
												_objManName = _this select 0;
												_bCreateTask = _this select 1;
												_iTaskIndex = _this select 2;
												_iThisTaskType = _this select 3;
												_objMan = missionNamespace getVariable _objManName;
												_doLoop = true;
												while {_doLoop} do {
													sleep 2;
													if (!alive(_objMan)) then {
														_doLoop = false;
														_sName = format["InfSide%1",_iTaskIndex];
														[_sName, "failed"] remoteExec ["FHQ_TT_setTaskState", 0, true];
													};
													if (_objMan distance (getMarkerPos "mrkHQ") < 500 || vehicle _objMan distance (getMarkerPos "mrkHQ") < 500) then {
														_doLoop = false;
														if (!_bCreateTask) then {
															if (_iThisTaskType == 11) then {
																[0.2, "Rescued a POW"] call TRGM_fnc_adjustMaxBadPoints;
																[_objMan] join grpNull;
																deleteVehicle _objMan;
															};
															if (_iThisTaskType == 12) then {
																[0.2, "Rescued a Reporter"] call TRGM_fnc_adjustMaxBadPoints;
																[_objMan] join grpNull;
																deleteVehicle _objMan;
															};
														}
														else {
															_sName = format["InfSide%1",_iTaskIndex];
															[_sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0, true];
															[_objMan] join grpNull;
															deleteVehicle _objMan;
														};
														
													};
												};
											};
											[_sInformant1Name,_bCreateTask,_iTaskIndex,_iThisTaskType] spawn TREND_fnc_POWCheck; 

										};
									
									};
									//4=Speak with informant || 5=interrogate officer || 7=Eliminate Officer || 8=Assasinate weapon dealer

									_bodyIDRequiredText = "";
									if (_bIsMainObjective && (_iThisTaskType == 7 || _iThisTaskType == 8)) then {_bodyIDRequiredText = localize "STR_TRGM2_startInfMission_MissionTitle8_MustSearch"};
									switch (_iThisTaskType) do {
										case 4: {_sTaskDescription = (localize "STR_TRGM2_startInfMission_MissionTitle4_Desc") + InformantImage;};
										case 5: {_sTaskDescription = (localize "STR_TRGM2_startInfMission_MissionTitle5_Desc") + OfficerImage;};
										case 7: {_sTaskDescription = (localize "STR_TRGM2_startInfMission_MissionTitle7_Desc") + _bodyIDRequiredText + OfficerImage;};
										case 8: {_sTaskDescription = (localize "STR_TRGM2_startInfMission_MissionTitle8_Desc") + _bodyIDRequiredText + WeaponDealerImage;};
										case 11: {_sTaskDescription = "We need you to locate and rescue our POW, the enemy are trying to gain valuable information from our guy!";};
										case 12: {_sTaskDescription = "We need you to locate and rescue a reporter!";};
									};

								};
								//####################BUG RADIO##########################
								if (bDebugMode) then {["Mission Setup: 8-3"] remoteExec ["systemChat", 0];};
								if (_iThisTaskType == 6) then {
									_allpositionsRadio1 = _infBuilding buildingPos -1;
									_sRadio1Name = format["objRadio%1",_iTaskIndex];
									_objRadio1 = selectRandom SideRadioClassNames createVehicle [0,0,500];
									_objRadio1 setVariable [_sRadio1Name, _objRadio1, true];
									missionNamespace setVariable [_sRadio1Name, _objRadio1];
									_objRadio1 setPosATL (selectRandom _allpositionsRadio1);

									[_objRadio1, [localize "STR_TRGM2_startInfMission_MissionTitle6_Button","RandFramework\bugRadio1.sqf",[_iTaskIndex,_bCreateTask]]] remoteExec ["addAction", 0, true];

									[missionNamespace getVariable _sRadio1Name] spawn TRGM_fnc_radioChatterLoop;
									_sTaskDescription = selectRandom[
										(localize "STR_TRGM2_startInfMission_MissionTitle6_Desc")];
								};
								//##############################################
								if (bDebugMode) then {["Mission Setup: 8-2"] remoteExec ["systemChat", 0];};

								//custom titles from TRGMSetDefaultMissionSetupVars.sqf (Mission1Title, Mission2Title etc...)
								_MissionTitle = missionNamespace getVariable [format["Mission%1Title",_iTaskIndex+1], _MissionTitle];
								_sTaskDescription = missionNamespace getVariable [format["Mission%1Desc",_iTaskIndex+1], _sTaskDescription];

								debugMessages = debugMessages + format["\n_bIsMainObjective: %1",_bIsMainObjective];
								debugMessages = debugMessages + format["\n_iTaskIndex: %1",_iTaskIndex];
								debugMessages = debugMessages + format["\n_MissionTitle: %1",_MissionTitle];

								_mrkPrefix = "";
								if (_bIsMainObjective) then {
									_markerInformant1 = createMarker [format["mrkMainObjective%1",_iTaskIndex], [_inf1X,_inf1Y]];
									_mrkPrefix = "mrkMainObjective";
								}
								else {
									_markerInformant1 = createMarker [format["Informant%1",_iTaskIndex], [_inf1X,_inf1Y]];
									_mrkPrefix = "Informant";
								};

								_markerInformant1 setMarkerShape "ICON";

								_hideAoMarker = false;
								if (!isNil "HideAoMarker") then {
									_hideAoMarker = HideAoMarker;
								};
								if (_hideAoMarker) then {
									_markerInformant1 setMarkerType "empty";
								}
								else {
									_markerInformant1 setMarkerType _MarkerType;
								};
								

								_bIsSameMrkPos = false;
								if (_iTaskIndex > 0) then {
									_sPrevMrkName = format["%1%2",_mrkPrefix,_iTaskIndex-1];
									_sCurrMrkName = format["%1%2",_mrkPrefix,_iTaskIndex];
									if (str(getMarkerPos _sCurrMrkName) == str(getMarkerPos _sPrevMrkName)) then {
										_bIsSameMrkPos = true;
										_sPrevMrkName setMarkerText format["%1 / %2",MarkerText _sPrevMrkName,_MissionTitle];
									};	
								};
								
								if (!_bIsSameMrkPos) then {
									if (_bIsMainObjective) then {
										_markerInformant1 setMarkerText format["(%2) %1 ",_MissionTitle,localize "STR_TRGM2_startInfMission_MainMission"];
									}
									else {
										if (_bCreateTask) then {
											_markerInformant1 setMarkerText format["%1 ",_MissionTitle];
										}
										else {
											_markerInformant1 setMarkerText format["(%2) %1 ",_MissionTitle,localize "STR_TRGM2_startInfMission_OptionalMission"];
										};
									};
								};

								if (_iTaskIndex == 0 && iMissionParamType != 5) then {_allowFriendlyIns = false};

								if (_bSideMissionsCivOnlyToUse && !_bCreateTask) then {
									ClearedPositions pushBack [_inf1X,_inf1Y];
									publicVariable "ClearedPositions";
									_markerInformant1 setMarkerText (localize "STR_TRGM2_startInfMission_markerInformant");
									if (!_SamePrevAO) then {
										[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns,true] spawn TRGM_fnc_populateSideMission;
									};
								}
								else {
									if (!_SamePrevAO) then {
										[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns] spawn TRGM_fnc_populateSideMission;
									};
								};

								
								if (_bCreateTask) then {
									if (_bIsCampaign) then {
										[FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format[localize "STR_TRGM2_startInfMission_MissionDayTitle",_iTaskIndex+1,_MissionTitle],""]] call FHQ_TT_addTasks;
										ActiveTasks pushBack format["InfSide%1",_iTaskIndex];
										publicVariable "ActiveTasks";
									}
									else {
										if (_hideTitleAndDesc) then {
											[FriendlySide,[format["InfSide%1",_iTaskIndex], "Objective unknown, recon the area!", format["%1 : %2",_iTaskIndex+1,"Objective Unknown"],""]] call FHQ_TT_addTasks;
										}
										else {
											[FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format["%1 : %2",_iTaskIndex+1,_MissionTitle],""]] call FHQ_TT_addTasks;
										};
										
										ActiveTasks pushBack format["InfSide%1",_iTaskIndex];
										publicVariable "ActiveTasks";
									};
								};


};
						}
						else {
							_bInfor1Found = false;
						};

					};
					if (bDebugMode) then {["Mission Setup: 8-1"] remoteExec ["systemChat", 0];};
				};
				if (InfTaskCount == 0) then {
					CurrentZeroMissionTitle = _MissionTitle; //curently only used for campaign
					if (MainMissionTitle != "") then {CurrentZeroMissionTitle = MainMissionTitle};
					publicVariable "CurrentZeroMissionTitle";
					if (_hideTitleAndDesc) then {
						MainMissionTitle = "Objective Unknown";
					};
				};
				if (bDebugMode) then {["Mission Setup: 8-0"] remoteExec ["systemChat", 0];};
				InfTaskCount = InfTaskCount + 1;


};
};


if (bDebugMode) then {["Mission Setup: 7"] remoteExec ["systemChat", 0];};

_trgComplete = createTrigger ["EmptyDetector", [0,0], false];
_trgComplete setVariable ["DelMeOnNewCampaignDay",true];
_trgComplete setTriggerArea [0, 0, 0, false];
if (iMissionParamType == 5) then {
	//MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""
	_totalRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;

	if (_totalRep >= 10 && FinalMissionStarted) then {
		_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "[FriendlySide, [""DeBrief"", localize ""STR_TRGM2_mainInit_Debrief"", ""Debrief"", """"]] call FHQ_TT_addTasks;  [[""CAMPAIGN_END""],""RandFramework\Campaign\SetMissionBoardOptions.sqf""] remoteExec [""BIS_fnc_execVM"",0,""TRGM_missionBoardOptions""]; deletevehicle thisTrigger", ""];

	}
	else {
		_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "[localize ""STR_TRGM2_startInfMission_RTBNextMission""] remoteExec [""Hint"", 0]; [[""MISSION_COMPLETE""],""RandFramework\Campaign\SetMissionBoardOptions.sqf""] remoteExec [""BIS_fnc_execVM"",0,""TRGM_missionBoardOptions""]; if (ActiveTasks call FHQ_TT_areTasksSuccessful) then {[1, format[localize ""STR_TRGM2_startInfMission_DayComplete"",str(iCampaignDay)]] call TRGM_fnc_adjustMaxBadPoints}; deletevehicle thisTrigger", ""];
	};
}
else {
	//_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "", ""]; //not sure why this is here... commented out on 5th Jan 2018... delete of no issues sinse

	//If not campaign and rep is disabled, then we will not fail the mission if rep low, but will be a task to keep rep above average
	if (iMissionParamRepOption == 0) then {
		//CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
		[FriendlySide, ["tskKeepAboveAverage",localize "STR_TRGM2_startInfMission_HoldReputation_Desc",localize "STR_TRGM2_startInfMission_HoldReputation_Title",""]] call FHQ_TT_addTasks;
		["tskKeepAboveAverage", "succeeded"] call FHQ_TT_setTaskState;
	};
	if (iMissionParamRepOption == 1) then {
		//CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
		[FriendlySide, ["tskKeepAboveAverage",localize "STR_TRGM2_startInfMission_HoldReputation_Desc",localize "STR_TRGM2_startInfMission_HoldReputation_Title2",""]] call FHQ_TT_addTasks;
		["tskKeepAboveAverage", "succeeded"] call FHQ_TT_setTaskState;
	};

};

if (bDebugMode) then {["Mission Setup: 6"] remoteExec ["systemChat", 0];};


//now we have all our location positinos, we can set other area stuff
[] execVM "RandFramework\RandScript\TREND_fnc_setOtherAreaStuff.sqf";

if (bDebugMode) then {["Mission Setup: 2"] remoteExec ["systemChat", 0];};


TREND_fnc_PopulateLoadingWait = {
	hintSilent "Populating AO please wait...";
	_percentage = 0;
	while {_percentage < 100} do {
		[format["Populating AO please wait... %1 percent", _percentage]] remoteExecCall ["hintSilent", 0];
		_percentage = _percentage + 1;
		sleep 0.1;
	};
	[""] remoteExecCall ["Hint", 0];
	MissionLoaded = true;
	publicVariable "MissionLoaded";
};
[] spawn TREND_fnc_PopulateLoadingWait;


if (bDebugMode) then {["Mission Setup: 1"] remoteExec ["systemChat", 0];};


publicVariable "debugMessages";

hint (localize "STR_TRGM2_startInfMission_SoItBegin");

[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,"TRGM_animateAnimals"]; //ambient animals are local to each client


if (bDebugMode) then {["Mission Setup: 0"] remoteExec ["systemChat", 0];};