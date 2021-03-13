
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

["Mission Setup: 16", true] call TREND_fnc_log;

call TREND_fnc_initMissionVars;
//#include "..\RandFramework\CustomMission\customMission.sqf";

//This is only ever called on server!!!!
["Mission Setup: 15", true] call TREND_fnc_log;

TRGM_Logic setVariable ["DeathRunning", false, true];
TRGM_Logic setVariable ["PointsUpdating", false, true];


//TREND_debugMessages = "";
//publicVariable "TREND_debugMessages";


["Mission Setup: 14.5", true] call TREND_fnc_log;

_ThisTaskTypes = nil;
_IsMainObjs = nil;
_MarkerTypes = nil;
_CreateTasks = nil;
_SamePrevAOStats = nil;
_bIsCampaign = false;
_bIsCampaignFinalMission = false;
_bSideMissionsCivOnly = nil;

_MainMissionTasksToUse = TREND_MainMissionTasks;
_SideMissionTasksToUse1 = TREND_SideMissionTasks;
_SideMissionTasksToUse2 = TREND_SideMissionTasks;
if (TREND_iMissionParamObjective > 0) then {
	_MainMissionTasksToUse = [TREND_iMissionParamObjective];
	_SideMissionTasksToUse1 = [TREND_iMissionParamObjective];
};
if (TREND_iMissionParamObjective2 > 0) then {
	_SideMissionTasksToUse1 = [TREND_iMissionParamObjective2];
};
if (TREND_iMissionParamObjective3 > 0) then {
	_SideMissionTasksToUse2 = [TREND_iMissionParamObjective3];
};

["Mission Setup: 14", true] call TREND_fnc_log;

TREND_iMissionSetup = TREND_iMissionParamType; publicVariable "TREND_iMissionSetup";
switch (TREND_iMissionSetup) do {
	case 0: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
		_CreateTasks = [true,false,false];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	case 1: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom TREND_MissionsThatHaveIntel,selectRandom TREND_MissionsThatHaveIntel];
		_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["empty","hd_dot","hd_dot"];
		_CreateTasks = [true,false,false];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	case 2: {
		_ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
		_IsMainObjs = [true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective"]; //INFORMANT: changed this back to mil_objective
		_CreateTasks = [true];
		_SamePrevAOStats = [false];
		_bSideMissionsCivOnly = [false];
		TREND_MaxBadPoints = 1;
	};
	case 3: {
		if (random 1 < .33) then {
			_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1,4];
			_IsMainObjs = [false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot"];
			_CreateTasks = [true,false];
			_SamePrevAOStats = [false,false];
			TREND_MaxBadPoints = 1;
			_bSideMissionsCivOnly = [false,true];
		} else {
			_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1];
			_IsMainObjs = [false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective"];
			_CreateTasks = [true];
			_SamePrevAOStats = [false];
			_bSideMissionsCivOnly = [false];
			TREND_MaxBadPoints = 1;
		};
	};
	case 4: {
		if (TREND_iMissionParamObjective > 0) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		} else {
			_ThisTaskTypes = [selectRandom TREND_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		};

		_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
		_CreateTasks = [true,true,true];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	case 5: {
		_totalRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
		if (_totalRep >= 10) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom TREND_MissionsThatHaveIntel,selectRandom TREND_MissionsThatHaveIntel];
			_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
			_CreateTasks = [true,false,false];
			_SamePrevAOStats = [false,false,false];
			_bSideMissionsCivOnly = [false,false,false];
			_bIsCampaignFinalMission = true;
		} else {
			if (random 1 < .33) then {
				_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1,4];
				_IsMainObjs = [false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
				_MarkerTypes = ["mil_objective","hd_dot"];
				_CreateTasks = [true,false];
				_SamePrevAOStats = [false,false];
				_bSideMissionsCivOnly = [false,true];
			} else {
				_ThisTaskTypes = [selectRandom _SideMissionTasksToUse1];
				_IsMainObjs = [false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
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
		_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","empty","empty"];
		_CreateTasks = [true,false,false];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	case 7: {
		if (TREND_iMissionParamObjective > 0) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		} else {
			_ThisTaskTypes = [selectRandom TREND_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		};
		_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["empty","empty","empty"];
		_CreateTasks = [true,true,true];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	case 8: {
		if (random 1 < .80) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
			_IsMainObjs = [true,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot"];
			_CreateTasks = [true,true];
			_SamePrevAOStats = [false,true];
			_bSideMissionsCivOnly = [false,false];
			TREND_MaxBadPoints = 1;
		} else {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
			_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
			_CreateTasks = [true,true,false];
			_SamePrevAOStats = [false,true,false];
			_bSideMissionsCivOnly = [false,false,true];
			TREND_MaxBadPoints = 1;
		};
	};
	case 9: {
		if (random 1 < .50) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1];
			_IsMainObjs = [false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot"];
			_CreateTasks = [true,true];
			_SamePrevAOStats = [false,true];
			_bSideMissionsCivOnly = [false,false];
			TREND_MaxBadPoints = 1;
		} else {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
			_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
			_CreateTasks = [true,true,false];
			_SamePrevAOStats = [false,true,false];
			_bSideMissionsCivOnly = [false,false,true];
			TREND_MaxBadPoints = 1;
		};
	};
	case 10: {
		TREND_IsFullMap =  true; publicVariable "TREND_IsFullMap";
		if (random 1 < .50) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
			_IsMainObjs = [true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["empty"];
			_CreateTasks = [true];
			_SamePrevAOStats = [false];
			_bSideMissionsCivOnly = [false];
			TREND_MaxBadPoints = 1;
		} else {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
			_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
			_MarkerTypes = ["empty","empty","hd_dot"];
			_CreateTasks = [true,true,false];
			_SamePrevAOStats = [false,true,false];
			_bSideMissionsCivOnly = [false,false,true];
			TREND_MaxBadPoints = 1;
		}
	};
	case 11: {
		if (TREND_iMissionParamObjective > 0) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		} else {
			_ThisTaskTypes = [selectRandom TREND_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		};

		_IsMainObjs = [true,true,true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
		_CreateTasks = [true,true,true];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	case 12: {
		TREND_IsFullMap =  true; publicVariable "TREND_IsFullMap";
		if (TREND_iMissionParamObjective > 0) then {
			_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		} else {
			_ThisTaskTypes = [selectRandom TREND_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
		};
		_IsMainObjs = [true,true,true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
		_MarkerTypes = ["empty","empty","empty"];
		_CreateTasks = [true,true,true];
		_SamePrevAOStats = [false,false,false];
		_bSideMissionsCivOnly = [false,false,false];
		TREND_MaxBadPoints = 1;
	};
	default { };
};

//HERE.... two objectives at one AO : as above, but also... randomo chance of third mission (inttel or mission)

if (!(isNil "IsTraining")) then {
	_ThisTaskTypes = [12,8,3];
	_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
	_CreateTasks = [true,true,true];
	_SamePrevAOStats = [false,false,false];
	_bSideMissionsCivOnly = [false,false,false];
	TREND_MaxBadPoints = 100;
};

if (TREND_bDebugMode) then {
	_ThisTaskTypes = [18,19];
	_IsMainObjs = _ThisTaskTypes apply {true;}; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = _ThisTaskTypes apply {"mil_objective";};
	_CreateTasks = _ThisTaskTypes apply {true;};
	_SamePrevAOStats = _ThisTaskTypes apply {false;};
	_bSideMissionsCivOnly = _ThisTaskTypes apply {false;};
	TREND_MaxBadPoints = 100;
};

TREND_MissionParamsSet =  true; publicVariable "TREND_MissionParamsSet";

["Mission Setup: 13", true] call TREND_fnc_log;

publicVariable "TREND_MaxBadPoints";

_randInfor1X = nil;
_randInfor1Y = nil;
_buildings = nil;

["Mission Setup: 12.5", true] call TREND_fnc_log;

while {(TREND_InfTaskCount < count _ThisTaskTypes)} do {
	_iTaskIndex = TREND_InfTaskCount;
	if (_bIsCampaign) then {
		_iTaskIndex = (TREND_iCampaignDay - 1) + TREND_InfTaskCount;
	}
	else {
		_iTaskIndex = TREND_InfTaskCount;
	};

	_iThisTaskType = nil;
	_iThisTaskType = _ThisTaskTypes select TREND_InfTaskCount;

	_bIsMainObjective = _IsMainObjs select TREND_InfTaskCount; if (isNil "_bIsMainObjective") then { _bIsMainObjective = false; }; //more chance of bad things, and set middle area stuff around (comms, base etc...)
	_MarkerType = _MarkerTypes select TREND_InfTaskCount; if (isNil "_MarkerType") then { _MarkerType = "hd_dot"; };//"Empty" or other
	_bCreateTask = _CreateTasks select TREND_InfTaskCount; if (isNil "_bCreateTask") then { _bCreateTask = true; };
	_SamePrevAO = _SamePrevAOStats select TREND_InfTaskCount; if (isNil "_SamePrevAO") then { _SamePrevAO = false; };
	_allowFriendlyIns = true;
	_bSideMissionsCivOnlyToUse = _bSideMissionsCivOnly select TREND_InfTaskCount;
	_hideTitleAndDesc = false;

	if (_MarkerTypes select 0 == "empty") then {
		TREND_MainIsHidden =  true; publicVariable "TREND_MainIsHidden";
	}
	else {
		TREND_MainIsHidden =  false; publicVariable "TREND_MainIsHidden";
	};

	//["c"] call TREND_fnc_notify;
	["Mission Setup: 12", true] call TREND_fnc_log;

	TREND_InfTaskStarted =  true; publicVariable "TREND_InfTaskStarted";

	//TREND_InfTaskCount = TREND_InfTaskCount + 1;
	//publicVariable "TREND_InfTaskCount";

	//InformantStuff
	TREND_SideCompleted =  []; publicVariable "TREND_SideCompleted";

	TREND_SideCompleted pushBack false;
	publicVariable "TREND_SideCompleted";
	_bInfor1Found = false;

	_MissionTitle = "";
	_RequiresNearbyRoad = false;
	_roadSearchRange = 20;
	_CustomMissionEnabled = false;

	_bNewTaskSetup = false;
	_args = [];
	["Mission Setup: 11", true] call TREND_fnc_log;

	switch (_iThisTaskType) do {
		case 1: {
			#include "..\..\Missions\hackDataMission.sqf"; //Hack Data
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Hacked data, reputation increased", 1, "Hacked data"];
		};
		case 2: {
			#include "..\..\Missions\stealDataFromResearchVehMission.sqf"; //Steal data from research vehicle
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Data secured, reputation increased", 1, "Downloaded research data"];
		};
		case 3: {
			#include "..\..\Missions\destroyVehiclesMission.sqf"; //Destroy ammo trucks
			[localize "STR_TRGM2_startInfMission_MissionTitle3"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = [localize "STR_TRGM2_startInfMission_MissionTitle3_Destory", 1, "Destroyed ammo trucks", selectRandom (call sideAmmoTruck), [localize "STR_TRGM2_startInfMission_MissionTitle3_Desc"]];
		};
		case 4: {
			#include "..\..\Missions\hvtMission.sqf" //Speak with informant
			[localize "STR_TRGM2_startInfMission_MissionTitle4"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["", 0, "", selectRandom InformantClasses, Civilian, "SPEAK", "", localize "STR_TRGM2_startInfMission_MissionTitle8_Button2", [(localize "STR_TRGM2_startInfMission_MissionTitle4_Desc") + TREND_InformantImage]];
		};
		case 5: {
			#include "..\..\Missions\hvtMission.sqf" //interrogate officer
			[localize "STR_TRGM2_startInfMission_MissionTitle5"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["", 0, "", selectRandom InterogateOfficerClasses, TREND_EnemySide, "INTERROGATE", localize "STR_TRGM2_startInfMission_MissionTitle8_Button", localize "STR_TRGM2_startInfMission_MissionTitle8_Button2", [(localize "STR_TRGM2_startInfMission_MissionTitle5_Desc") + TREND_OfficerImage]];
		};
		case 6: {
			#include "..\..\Missions\bugRadioMission.sqf"; //Transmit Enemy Comms to HQ
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Bugged radio, reputation increased.", 0.5, "Bugged radio"];
		};
		case 7: {
			#include "..\..\Missions\hvtMission.sqf" //Eliminate Officer   -   gain 1 point if side, if main, need to id him before complete
			[localize "STR_TRGM2_startInfMission_MissionTitle7"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = [localize "STR_TRGM2_startInfMission_MissionTitle8_Eliminated", 1, "HVT Killed", selectRandom InterogateOfficerClasses, TREND_EnemySide, "KILL", localize "STR_TRGM2_startInfMission_MissionTitle8_Button", "", [(localize "STR_TRGM2_startInfMission_MissionTitle7_Desc") + (["", localize "STR_TRGM2_startInfMission_MissionTitle8_MustSearch"] select (_bIsMainObjective)) + TREND_OfficerImage]];
		};
		case 8: {
			#include "..\..\Missions\hvtMission.sqf" //Assasinate weapon dealer   -   gain 1 point if side, no intel from him... if main need to id him before complete
			[localize "STR_TRGM2_startInfMission_MissionTitle8"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = [localize "STR_TRGM2_startInfMission_MissionTitle8_Eliminated", 1, "HVT Killed", selectRandom WeaponDealerClasses, Civilian, "KILL", localize "STR_TRGM2_startInfMission_MissionTitle8_Button", "", [(localize "STR_TRGM2_startInfMission_MissionTitle8_Desc") + (["", localize "STR_TRGM2_startInfMission_MissionTitle8_MustSearch"] select (_bIsMainObjective)) + TREND_WeaponDealerImage]];
		};
		case 9: {
			#include "..\..\Missions\destroyVehiclesMission.sqf"; //Destroy AAA vehicles
			[localize "STR_TRGM2_startInfMission_MissionTitle9"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = [localize "STR_TRGM2_startInfMission_MissionTitle9_Destory", 1, "Destroyed AAA", selectRandom (call DestroyAAAVeh), [localize "STR_TRGM2_startInfMission_MissionTitle9_Desc"]];
		};
		case 10: {
			#include "..\..\Missions\destroyVehiclesMission.sqf"; //Destroy Artillery vehicles
			[localize "STR_TRGM2_startInfMission_MissionTitle10"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = [localize "STR_TRGM2_startInfMission_MissionTitle10_Destory", 1, "Destroyed Artillery", selectRandom (call sArtilleryVeh), [localize "STR_TRGM2_startInfMission_MissionTitle10_Desc"]];
		};
		case 11: {
			#include "..\..\Missions\hvtMission.sqf" //Rescue POW
			[localize "STR_TRGM2_Rescue_POW"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Rescued a POW, reputation increased.", 1, "Rescued a POW", selectRandom FriendlyVictims, TREND_FriendlySide, "RESCUE", "", "", ["We need you to locate and rescue our POW, the enemy are trying to gain valuable information from our guy!"]];
		};
		case 12: {
			#include "..\..\Missions\hvtMission.sqf"; //Rescue Reporter
			[localize "STR_TRGM2_Rescue_Reporter"] call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Rescued a Reporter, reputation increased.", 1, "Rescued a Reporter", selectRandom Reporters, Civilian, "RESCUE", "", "", ["We need you to locate and rescue a reporter!"]];
		};
		case 13: {
			#include "..\..\Missions\defuseIEDsMission.sqf"; //defuse 3 IEDs
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Defused IEDs, reputation increased.", 1, "Defused IEDs"];
		};
		case 14: {
			#include "..\..\Missions\bombDisposalMission.sqf"; //defuse 3 IEDs
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Defused Bomb, reputation increased.", 1, "Defused Bomb"];
		};
		case 15: {
			#include "..\..\Missions\searchAndDestroyMission.sqf"; //Search and Destroy
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Targets destoryed, reputation increased.", 1, "Targets destoryed"];
		};
		case 16: {
			#include "..\..\Missions\destroyCacheMission.sqf"; //Destroy Cache
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Cache destoryed, reputation increased.", 1, "Cache destoryed"];
		};
		case 17:  {
			#include "..\..\Missions\secureAndResupplyMission.sqf"; //Secure and Resupply
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Area Cleared, reputation increased.", 1, "Area Cleared"];
		};
		case 18:  {
			#include "..\..\Missions\meetingAssassinationMission.sqf"; //Meeting Assassination
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["HVT assassinated, reputation increased.", 1, "HVT assassinated"];
		};
		case 19:  {
			#include "..\..\Missions\ambushConvoyMission.sqf"; //Ambush Convoy
			call fnc_CustomVars;
			_bNewTaskSetup = true;
			_args = ["Convoy eliminated, reputation increased.", 1, "Convoy eliminated"];
		};
		case 99999: {
			//[format["pre: %1",_RequiresNearbyRoad]] call TREND_fnc_notify; sleep 2;
			//#include "..\..\CustomMission\customMission.sqf"; //Custom Mission
			//call fnc_CustomVars;
			//[format["post: %1",_RequiresNearbyRoad]] call TREND_fnc_notify; sleep 2;
			//_args = ["Objective completed, reputation increased.", 1, "Objective completed"];
		};
		default { };
	};

	_bUserDefinedAO = false;
	///*orangestest
	if (_iTaskIndex == 0 && {!isNil "TREND_Mission1Loc"}) then {
		_bUserDefinedAO = true;
	};
	if (_iTaskIndex == 1 && {!isNil "TREND_Mission2Loc"}) then {
		_bUserDefinedAO = true;
	};
	if (_iTaskIndex == 2 && {!isNil "TREND_Mission3Loc"}) then {
		_bUserDefinedAO = true;
	};
	//orangestest*/

	//kill leader (he will run away in car to AO)    ::   save stranded guys    ::

	_allLocationTypes = [];
	"_allLocationTypes pushBack configName _x" configClasses (configFile >> "CfgLocationTypes");
	_allLocations = nearestLocations [(getMarkerPos "mrkHQ"), _allLocationTypes, 25000];
	_allLocationPositions = _allLocations apply {[locationPosition _x select 0, locationPosition _x select 1]};
	_allLocationPositions = _allLocationPositions select {((getMarkerPos "mrkHQ") distance _x) > TREND_SideMissionMinDistFromBase};
	_allLocationPositions = _allLocationPositions select {count nearestObjects [_x, TREND_BasicBuildings, 200] > 0};

	["Mission Setup: 10", true] call TREND_fnc_log;
	_attempts = 0;
	while {!_bInfor1Found} do {
		_attempts = _attempts + 1;
		["Mission Setup: 9", true] call TREND_fnc_log;
		_markerInformant1 = nil;

		if (!_SamePrevAO || {_bUserDefinedAO || {_attempts > 100}}) then {
			_randLocation = if !(isNil "_allLocationPositions") then {selectRandom _allLocationPositions} else {[0 + (floor random 25000), 0 + (floor random 25000)]};
			_randInfor1X = _randLocation select 0;
			_randInfor1Y = _randLocation select 1;
			_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TREND_BasicBuildings, 200*_attempts] select {!((_x buildingPos -1) isEqualTo [])};

			if (_iTaskIndex == 0 && {!_bIsCampaign && {!(isNil "TREND_Mission1Loc")}}) then {
				_randInfor1X = TREND_Mission1Loc select 0;
				_randInfor1Y = TREND_Mission1Loc select 1;
				_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TREND_BasicBuildings, 50*_attempts] select {!((_x buildingPos -1) isEqualTo [])};
				if (_attempts > 100) then {[format["Still no location found after %1 attempts!",_attempts]] call TREND_fnc_notify;}
			};

			if (_iTaskIndex == 1 && {!_bIsCampaign && {!(isNil "TREND_Mission2Loc")}}) then {
				_randInfor1X = TREND_Mission2Loc select 0;
				_randInfor1Y = TREND_Mission2Loc select 1;
				_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TREND_BasicBuildings, 50*_attempts] select {!((_x buildingPos -1) isEqualTo [])};
				if (_attempts > 100) then {[format["Still no location found after %1 attempts!",_attempts]] call TREND_fnc_notify;}
			};

			if (_iTaskIndex == 2 && {!_bIsCampaign && {!(isNil "TREND_Mission3Loc")}}) then {
				_randInfor1X = TREND_Mission3Loc select 0;
				_randInfor1Y = TREND_Mission3Loc select 1;
				_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TREND_BasicBuildings, 50*_attempts] select {!((_x buildingPos -1) isEqualTo [])};
				if (_attempts > 100) then {[format["Still no location found after %1 attempts!",_attempts]] call TREND_fnc_notify;}
			};
		};

		_isPosFarEnoughFromHq = (getMarkerPos "mrkHQ" distance [_randInfor1X, _randInfor1Y]) > TREND_SideMissionMinDistFromBase;
		_playerSelectedAo = call TREND_manualAOPlacement;

		if ((_isPosFarEnoughFromHq || _playerSelectedAo) && {(count _buildings) > 0}) then {
			_bInfor1Found = true;
			_infBuilding = selectRandom _buildings;
			_infBuilding setDamage 0;
			_allBuildingPos = _infBuilding buildingPos -1;
			_inf1X = position _infBuilding select 0;
			_inf1Y = position _infBuilding select 1;
			if (count _allBuildingPos > 2) then {
				_TasksToValidate = [_iThisTaskType];
				if (count _SamePrevAOStats > TREND_InfTaskCount) then {
					if (_SamePrevAOStats select (TREND_InfTaskCount + 1)) then {
						_TasksToValidate = _TasksToValidate + [_ThisTaskTypes select (TREND_InfTaskCount + 1)];
						if (count _SamePrevAOStats > TREND_InfTaskCount + 1) then {
							if (_SamePrevAOStats select (TREND_InfTaskCount + 2)) then {
								_TasksToValidate = _TasksToValidate + [_ThisTaskTypes select (TREND_InfTaskCount + 2)];
							};
						};
					};
				};

				_nearestRoads = nil;
				{
					if (_x == 99999 || _bNewTaskSetup) then {
						_bCustomRequiredPass = true;
						if (_CustomMissionEnabled || _bNewTaskSetup) then {
							_bCustomRequiredPass = [_infBuilding,_inf1X,_inf1Y] call fnc_CustomRequired;
						};
						if (!_bCustomRequiredPass) then {
							_bInfor1Found = false
						};
					};

					_nearestRoads = [_inf1X,_inf1Y] nearRoads _roadSearchRange;
					if (_RequiresNearbyRoad) then {
						if (count _nearestRoads == 0) then {
							_bInfor1Found = false;
						};
					};
				} forEach _TasksToValidate;


				if (_bInfor1Found) then {
					TREND_ObjectivePossitions pushBack [_inf1X,_inf1Y];
					publicVariable "TREND_ObjectivePossitions";
					if (_MarkerType == "empty") then {
						TREND_HiddenPossitions pushBack [_inf1X,_inf1Y];
						publicVariable "TREND_HiddenPossitions";
						_hideTitleAndDesc = true;
					};
					_sTaskDescription = "";
					if (TREND_ISUNSUNG) then {
						if (_iThisTaskType == 6) then {
							_radio = selectRandom ["uns_radio2_transitor_NVA","uns_radio2_transitor_NVA"] createVehicle (selectRandom (_infBuilding buildingPos -1));
						}
						else {
							_radio = selectRandom ["uns_radio2_nva_radio","uns_radio2_transitor_NVA","uns_radio2_transitor_NVA"] createVehicle (selectRandom (_infBuilding buildingPos -1));
						};

					};
					//###################################### CUSTOM MISSION ######################################
					["Mission Setup: 8-0-10", true] call TREND_fnc_log;
					if (_iThisTaskType == 99999 || _bNewTaskSetup) then {
						[_MarkerType, _infBuilding, _inf1X, _inf1Y, _roadSearchRange, _bCreateTask, _iTaskIndex, _bIsMainObjective, _args] call fnc_CustomMission;
					};
					//############################################################################################
					["Mission Setup: 8-2", true] call TREND_fnc_log;

					if (!isNil "TREND_Mission1Title") then {_MissionTitle = TREND_Mission1Title};
					if (!isNil "TREND_Mission1Desc") then {_sTaskDescription = TREND_Mission1Desc};

					TREND_debugMessages = TREND_debugMessages + format["\n_bIsMainObjective: %1",_bIsMainObjective];
					TREND_debugMessages = TREND_debugMessages + format["\n_iTaskIndex: %1",_iTaskIndex];
					TREND_debugMessages = TREND_debugMessages + format["\n_MissionTitle: %1",_MissionTitle];

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
					if (!isNil "TREND_HideAoMarker") then {
						_hideAoMarker = TREND_HideAoMarker;
					};
					if (_hideAoMarker) then {
						_markerInformant1 setMarkerType "empty";
					}
					else {
						_markerInformant1 setMarkerType _MarkerType;
					};

					//_markerInformant1 setMarkerText _MissionTitle;

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

					if (_iTaskIndex == 0 && TREND_iMissionParamType != 5) then {_allowFriendlyIns = false};

					if (_bSideMissionsCivOnlyToUse && !_bCreateTask) then {
						TREND_ClearedPositions pushBack [_inf1X,_inf1Y];
						publicVariable "TREND_ClearedPositions";
						_markerInformant1 setMarkerText (localize "STR_TRGM2_startInfMission_markerInformant");
						if (!_SamePrevAO) then {
							[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns,true] spawn TREND_fnc_PopulateSideMission;
						};
					}
					else {
						if (!_SamePrevAO) then {
							[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns] spawn TREND_fnc_PopulateSideMission;
						};
					};

					//[_sTaskDescription] call TREND_fnc_notify;

					if (_bCreateTask) then {
						if (_bIsCampaign) then {
							[TREND_FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format[localize "STR_TRGM2_startInfMission_MissionDayTitle",_iTaskIndex+1,_MissionTitle],""]] call FHQ_fnc_ttAddTasks;
							TREND_ActiveTasks pushBack format["InfSide%1",_iTaskIndex];
							publicVariable "TREND_ActiveTasks";
						}
						else {
							if (_hideTitleAndDesc) then {
								[TREND_FriendlySide,[format["InfSide%1",_iTaskIndex], "Objective unknown, recon the area!", format["%1 : %2",_iTaskIndex+1,"Objective Unknown"],""]] call FHQ_fnc_ttAddTasks;
							}
							else {
								[TREND_FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format["%1 : %2",_iTaskIndex+1,_MissionTitle],""]] call FHQ_fnc_ttAddTasks;
							};

							TREND_ActiveTasks pushBack format["InfSide%1",_iTaskIndex];
							publicVariable "TREND_ActiveTasks";
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
		["Mission Setup: 8-1", true] call TREND_fnc_log;
	};

	if (TREND_InfTaskCount == 0) then {
		TREND_CurrentZeroMissionTitle = _MissionTitle; //curently only used for campaign
		if (TREND_MainMissionTitle != "") then {TREND_CurrentZeroMissionTitle = TREND_MainMissionTitle};
		publicVariable "TREND_CurrentZeroMissionTitle";
		if (_hideTitleAndDesc) then {
			TREND_MainMissionTitle = "Objective Unknown";
		};
	};
	["Mission Setup: 8-0", true] call TREND_fnc_log;
	TREND_InfTaskCount = TREND_InfTaskCount + 1;
};


["Mission Setup: 7", true] call TREND_fnc_log;

_trgComplete = createTrigger ["EmptyDetector", [0,0]];
_trgComplete setVariable ["DelMeOnNewCampaignDay",true];
_trgComplete setTriggerArea [0, 0, 0, false];
if (TREND_iMissionParamType == 5) then {
	_totalRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;

	if (_totalRep >= 10 && TREND_FinalMissionStarted) then {
		_trgComplete setTriggerStatements ["TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted;", "[TREND_FriendlySide, [""DeBrief"", localize ""STR_TRGM2_mainInit_Debrief"", ""Debrief"", """"]] call FHQ_fnc_ttAddTasks;  [""CAMPAIGN_END""] remoteExec [""TREND_fnc_SetMissionBoardOptions"",0,true];}; deletevehicle thisTrigger", ""];

	}
	else {
		_trgComplete setTriggerStatements ["TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted;", "[(localize ""STR_TRGM2_startInfMission_RTBNextMission"")] call TREND_fnc_notify; [""MISSION_COMPLETE""] remoteExec [""TREND_fnc_SetMissionBoardOptions"",0,true]; if (TREND_ActiveTasks call FHQ_fnc_ttAreTasksSuccessful) then {[1, format[localize ""STR_TRGM2_startInfMission_DayComplete"",str(TREND_iCampaignDay)]] spawn TREND_fnc_AdjustMaxBadPoints}; deletevehicle thisTrigger", ""];
	};
	//TESTTEST = triggerStatements _trgComplete;
}
else {
	//_trgComplete setTriggerStatements ["TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted;", "", ""]; //not sure why this is here... commented out on 5th Jan 2018... delete of no issues sinse

	//If not campaign and rep is disabled, then we will not fail the mission if rep low, but will be a task to keep rep above average
	if (TREND_iMissionParamRepOption == 0) then {
		//CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
		[TREND_FriendlySide, ["tskKeepAboveAverage",localize "STR_TRGM2_startInfMission_HoldReputation_Desc",localize "STR_TRGM2_startInfMission_HoldReputation_Title",""]] call FHQ_fnc_ttAddTasks;
		["tskKeepAboveAverage", "created"] call FHQ_fnc_ttSetTaskState;
	};
	if (TREND_iMissionParamRepOption == 1) then {
		//CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
		[TREND_FriendlySide, ["tskKeepAboveAverage",localize "STR_TRGM2_startInfMission_HoldReputation_Desc",localize "STR_TRGM2_startInfMission_HoldReputation_Title2",""]] call FHQ_fnc_ttAddTasks;
		["tskKeepAboveAverage", "created"] call FHQ_fnc_ttSetTaskState;
	};

};

["Mission Setup: 6", true] call TREND_fnc_log;
///*orangestest



///*orangestest
//now we have all our location positinos, we can set other area stuff
[] spawn TREND_fnc_setOtherAreaStuff;
//orangestest*/

//orangestest*/
["Mission Setup: 2", true] call TREND_fnc_log;


TREND_fnc_PopulateLoadingWait = {
	TREND_PopulateLoadingWait_percentage = 0; publicVariable "TREND_PopulateLoadingWait_percentage";
	while {TREND_PopulateLoadingWait_percentage < 100} do {
		[format["Populating AO please wait... %1 percent", TREND_PopulateLoadingWait_percentage], {TREND_PopulateLoadingWait_percentage < 100}, 100] call TREND_fnc_notifyGlobal;
		TREND_PopulateLoadingWait_percentage = TREND_PopulateLoadingWait_percentage + 1;
		publicVariable "TREND_PopulateLoadingWait_percentage";
		sleep 0.1;
	};
	sleep 10;
	TREND_PopulateLoadingWait_percentage = nil; publicVariable "TREND_PopulateLoadingWait_percentage";
	TREND_MissionLoaded =  true; publicVariable "TREND_MissionLoaded";
	TREND_AllInitScriptsFinished = true; publicVariable "TREND_AllInitScriptsFinished";
};
[] spawn TREND_fnc_PopulateLoadingWait;



["Mission Setup: 1", true] call TREND_fnc_log;


publicVariable "TREND_debugMessages";

[(localize "STR_TRGM2_startInfMission_SoItBegin")] call TREND_fnc_notify;

///*orangestest
[] remoteExec ["TREND_fnc_animateAnimals",0,true];
//orangestest*/



["Mission Setup: 0", true] call TREND_fnc_log;
true;