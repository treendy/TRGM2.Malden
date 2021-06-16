
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

["Mission Setup: 16", true] call TRGM_GLOBAL_fnc_log;

call TRGM_SERVER_fnc_initMissionVars;

//This is only ever called on server!!!!
["Mission Setup: 15", true] call TRGM_GLOBAL_fnc_log;

TRGM_Logic setVariable ["DeathRunning", false, true];
TRGM_Logic setVariable ["PointsUpdating", false, true];


["Mission Setup: 14.5", true] call TRGM_GLOBAL_fnc_log;

_ThisTaskTypes = nil;
_IsMainObjs = nil;
_MarkerTypes = nil;
_CreateTasks = nil;
_SamePrevAOStats = nil;
_bIsCampaign = false;
_bIsCampaignFinalMission = false;
_bSideMissionsCivOnly = nil;

_MainMissionTasksToUse = TRGM_VAR_MainMissionTasks;
_SideMissionTasksToUse1 = TRGM_VAR_SideMissionTasks;
_SideMissionTasksToUse2 = TRGM_VAR_SideMissionTasks;
if (TRGM_VAR_iMissionParamObjective > 0) then {
    _MainMissionTasksToUse = [TRGM_VAR_iMissionParamObjective];
    _SideMissionTasksToUse1 = [TRGM_VAR_iMissionParamObjective];
};
if (TRGM_VAR_iMissionParamObjective2 > 0) then {
    _SideMissionTasksToUse1 = [TRGM_VAR_iMissionParamObjective2];
};
if (TRGM_VAR_iMissionParamObjective3 > 0) then {
    _SideMissionTasksToUse2 = [TRGM_VAR_iMissionParamObjective3];
};

["Mission Setup: 14", true] call TRGM_GLOBAL_fnc_log;

TRGM_VAR_iMissionSetup = TRGM_VAR_iMissionParamType; publicVariable "TRGM_VAR_iMissionSetup";
switch (TRGM_VAR_iMissionSetup) do {
    case 0: {
        _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        _IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
        _CreateTasks = [true,false,false];
        _SamePrevAOStats = [false,false,false];
        _bSideMissionsCivOnly = [false,false,false];
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 1: {
        _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom TRGM_VAR_MissionsThatHaveIntel,selectRandom TRGM_VAR_MissionsThatHaveIntel];
        _IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["empty","hd_dot","hd_dot"];
        _CreateTasks = [true,false,false];
        _SamePrevAOStats = [false,false,false];
        _bSideMissionsCivOnly = [false,false,false];
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 2: {
        _ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
        _IsMainObjs = [true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["mil_objective"]; //INFORMANT: changed this back to mil_objective
        _CreateTasks = [true];
        _SamePrevAOStats = [false];
        _bSideMissionsCivOnly = [false];
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 3: {
        if (random 1 < .33) then {
            _ThisTaskTypes = [selectRandom _SideMissionTasksToUse1,4];
            _IsMainObjs = [false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["mil_objective","hd_dot"];
            _CreateTasks = [true,false];
            _SamePrevAOStats = [false,false];
            TRGM_VAR_MaxBadPoints = 1;
            _bSideMissionsCivOnly = [false,true];
        } else {
            _ThisTaskTypes = [selectRandom _SideMissionTasksToUse1];
            _IsMainObjs = [false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["mil_objective"];
            _CreateTasks = [true];
            _SamePrevAOStats = [false];
            _bSideMissionsCivOnly = [false];
            TRGM_VAR_MaxBadPoints = 1;
        };
    };
    case 4: {
        if (TRGM_VAR_iMissionParamObjective > 0) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        } else {
            _ThisTaskTypes = [selectRandom TRGM_VAR_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        };

        _IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
        _CreateTasks = [true,true,true];
        _SamePrevAOStats = [false,false,false];
        _bSideMissionsCivOnly = [false,false,false];
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 5: {
        _totalRep = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;
        if (_totalRep >= 10) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom TRGM_VAR_MissionsThatHaveIntel,selectRandom TRGM_VAR_MissionsThatHaveIntel];
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
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 7: {
        if (TRGM_VAR_iMissionParamObjective > 0) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        } else {
            _ThisTaskTypes = [selectRandom TRGM_VAR_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        };
        _IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["empty","empty","empty"];
        _CreateTasks = [true,true,true];
        _SamePrevAOStats = [false,false,false];
        _bSideMissionsCivOnly = [false,false,false];
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 8: {
        if (random 1 < .80) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
            _IsMainObjs = [true,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["mil_objective","hd_dot"];
            _CreateTasks = [true,true];
            _SamePrevAOStats = [false,true];
            _bSideMissionsCivOnly = [false,false];
            TRGM_VAR_MaxBadPoints = 1;
        } else {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
            _IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
            _CreateTasks = [true,true,false];
            _SamePrevAOStats = [false,true,false];
            _bSideMissionsCivOnly = [false,false,true];
            TRGM_VAR_MaxBadPoints = 1;
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
            TRGM_VAR_MaxBadPoints = 1;
        } else {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
            _IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
            _CreateTasks = [true,true,false];
            _SamePrevAOStats = [false,true,false];
            _bSideMissionsCivOnly = [false,false,true];
            TRGM_VAR_MaxBadPoints = 1;
        };
    };
    case 10: {
        TRGM_VAR_IsFullMap =  true; publicVariable "TRGM_VAR_IsFullMap";
        if (random 1 < .50) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
            _IsMainObjs = [true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["empty"];
            _CreateTasks = [true];
            _SamePrevAOStats = [false];
            _bSideMissionsCivOnly = [false];
            TRGM_VAR_MaxBadPoints = 1;
        } else {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,4];
            _IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
            _MarkerTypes = ["empty","empty","hd_dot"];
            _CreateTasks = [true,true,false];
            _SamePrevAOStats = [false,true,false];
            _bSideMissionsCivOnly = [false,false,true];
            TRGM_VAR_MaxBadPoints = 1;
        }
    };
    case 11: {
        if (TRGM_VAR_iMissionParamObjective > 0) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        } else {
            _ThisTaskTypes = [selectRandom TRGM_VAR_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        };

        _IsMainObjs = [true,true,true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
        _CreateTasks = [true,true,true];
        _SamePrevAOStats = [false,false,false];
        _bSideMissionsCivOnly = [false,false,false];
        TRGM_VAR_MaxBadPoints = 1;
    };
    case 12: {
        TRGM_VAR_IsFullMap =  true; publicVariable "TRGM_VAR_IsFullMap";
        if (TRGM_VAR_iMissionParamObjective > 0) then {
            _ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        } else {
            _ThisTaskTypes = [selectRandom TRGM_VAR_SideMissionTasks,selectRandom _SideMissionTasksToUse1,selectRandom _SideMissionTasksToUse2];
        };
        _IsMainObjs = [true,true,true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
        _MarkerTypes = ["empty","empty","empty"];
        _CreateTasks = [true,true,true];
        _SamePrevAOStats = [false,false,false];
        _bSideMissionsCivOnly = [false,false,false];
        TRGM_VAR_MaxBadPoints = 1;
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
    TRGM_VAR_MaxBadPoints = 100;
};

if (TRGM_VAR_bDebugMode) then {
    _ThisTaskTypes = [18,19];
    _IsMainObjs = _ThisTaskTypes apply {true;}; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
    _MarkerTypes = _ThisTaskTypes apply {"mil_objective";};
    _CreateTasks = _ThisTaskTypes apply {true;};
    _SamePrevAOStats = _ThisTaskTypes apply {false;};
    _bSideMissionsCivOnly = _ThisTaskTypes apply {false;};
    TRGM_VAR_MaxBadPoints = 100;
};

TRGM_VAR_MissionParamsSet =  true; publicVariable "TRGM_VAR_MissionParamsSet";

["Mission Setup: 13", true] call TRGM_GLOBAL_fnc_log;

publicVariable "TRGM_VAR_MaxBadPoints";

_randInfor1X = nil;
_randInfor1Y = nil;
_buildings = nil;

["Mission Setup: Gatherthing map info", true] call TRGM_GLOBAL_fnc_log;

TRGM_VAR_allLocationTypes = [];
"TRGM_VAR_allLocationTypes pushBack configName _x" configClasses (configFile >> "CfgLocationTypes");
publicVariable "TRGM_VAR_allLocationTypes";
TRGM_VAR_allLocations = nearestLocations [(getMarkerPos "mrkHQ"), TRGM_VAR_allLocationTypes, 25000];
publicVariable "TRGM_VAR_allLocations";

["Mission Setup: Map info collected", true] call TRGM_GLOBAL_fnc_log;

["Mission Setup: 12.5", true] call TRGM_GLOBAL_fnc_log;

while {(TRGM_VAR_InfTaskCount < count _ThisTaskTypes)} do {
    _iTaskIndex = TRGM_VAR_InfTaskCount;
    if (_bIsCampaign) then {
        _iTaskIndex = (TRGM_VAR_iCampaignDay - 1) + TRGM_VAR_InfTaskCount;
    }
    else {
        _iTaskIndex = TRGM_VAR_InfTaskCount;
    };

    _iThisTaskType = nil;
    _iThisTaskType = _ThisTaskTypes select TRGM_VAR_InfTaskCount;

    _bIsMainObjective = _IsMainObjs select TRGM_VAR_InfTaskCount; if (isNil "_bIsMainObjective") then { _bIsMainObjective = false; }; //more chance of bad things, and set middle area stuff around (comms, base etc...)
    _MarkerType = _MarkerTypes select TRGM_VAR_InfTaskCount; if (isNil "_MarkerType") then { _MarkerType = "hd_dot"; };//"Empty" or other
    _bCreateTask = _CreateTasks select TRGM_VAR_InfTaskCount; if (isNil "_bCreateTask") then { _bCreateTask = true; };
    _SamePrevAO = _SamePrevAOStats select TRGM_VAR_InfTaskCount; if (isNil "_SamePrevAO") then { _SamePrevAO = false; };
    _allowFriendlyIns = true;
    _bSideMissionsCivOnlyToUse = _bSideMissionsCivOnly select TRGM_VAR_InfTaskCount;
    _hideTitleAndDesc = false;

    if (_MarkerTypes select 0 isEqualTo "empty") then {
        TRGM_VAR_MainIsHidden =  true; publicVariable "TRGM_VAR_MainIsHidden";
    }
    else {
        TRGM_VAR_MainIsHidden =  false; publicVariable "TRGM_VAR_MainIsHidden";
    };

    //["c"] call TRGM_GLOBAL_fnc_notify;
    ["Mission Setup: 12", true] call TRGM_GLOBAL_fnc_log;

    TRGM_VAR_InfTaskStarted =  true; publicVariable "TRGM_VAR_InfTaskStarted";

    //TRGM_VAR_InfTaskCount = TRGM_VAR_InfTaskCount + 1;
    //publicVariable "TRGM_VAR_InfTaskCount";

    //InformantStuff
    TRGM_VAR_SideCompleted =  []; publicVariable "TRGM_VAR_SideCompleted";

    TRGM_VAR_SideCompleted pushBack false;
    publicVariable "TRGM_VAR_SideCompleted";
    _bInfor1Found = false;

    _MissionTitle = "";
    _RequiresNearbyRoad = false;
    _roadSearchRange = 20;
    _CustomMissionEnabled = false;

    _bNewTaskSetup = false;
    _args = [];
    ["Mission Setup: 11", true] call TRGM_GLOBAL_fnc_log;

    switch (_iThisTaskType) do {
        case 1: {
            ["Mission Setup: Init Hack Data", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hackDataMission; //Hack Data
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Hacked data, reputation increased", 1, "Hacked data"];
            ["Mission Setup: Generating Hack Data", true] call TRGM_GLOBAL_fnc_log;
        };
        case 2: {
            ["Mission Setup: Init Steal data from research vehicle", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_stealDataFromResearchVehMission; //Steal data from research vehicle
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Data secured, reputation increased", 1, "Downloaded research data"];
            ["Mission Setup: Generating Steal data from research vehicle", true] call TRGM_GLOBAL_fnc_log;
        };
        case 3: {
            ["Mission Setup: Init Destroy ammo trucks", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_destroyVehiclesMission; //Destroy ammo trucks
            [localize "STR_TRGM2_startInfMission_MissionTitle3"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = [localize "STR_TRGM2_startInfMission_MissionTitle3_Destory", 1, "Destroyed ammo trucks", selectRandom (call sideAmmoTruck), [localize "STR_TRGM2_startInfMission_MissionTitle3_Desc"]];
            ["Mission Setup: Generating Destroy ammo trucks", true] call TRGM_GLOBAL_fnc_log;
        };
        case 4: {
            ["Mission Setup: Init Speak with informant", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hvtMission; //Speak with informant
            [localize "STR_TRGM2_startInfMission_MissionTitle4"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["", 0, "", selectRandom InformantClasses, Civilian, "SPEAK", "", localize "STR_TRGM2_startInfMission_MissionTitle8_Button2", [(localize "STR_TRGM2_startInfMission_MissionTitle4_Desc") + TRGM_VAR_InformantImage]];
            ["Mission Setup: Generating Speak with informant", true] call TRGM_GLOBAL_fnc_log;
        };
        case 5: {
            ["Mission Setup: Init Interrogate officer", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hvtMission; //Interrogate officer
            [localize "STR_TRGM2_startInfMission_MissionTitle5"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["", 0, "", selectRandom InterogateOfficerClasses, TRGM_VAR_EnemySide, "INTERROGATE", localize "STR_TRGM2_startInfMission_MissionTitle8_Button", localize "STR_TRGM2_startInfMission_MissionTitle8_Button2", [(localize "STR_TRGM2_startInfMission_MissionTitle5_Desc") + TRGM_VAR_OfficerImage]];
            ["Mission Setup: Generating Interrogate officer", true] call TRGM_GLOBAL_fnc_log;
        };
        case 6: {
            ["Mission Setup: Init Transmit Enemy Comms to HQ", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_bugRadioMission; //Transmit Enemy Comms to HQ
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Bugged radio, reputation increased.", 0.5, "Bugged radio"];
            ["Mission Setup: Generating Transmit Enemy Comms to HQ", true] call TRGM_GLOBAL_fnc_log;
        };
        case 7: {
            ["Mission Setup: Init Eliminate Officer", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hvtMission; //Eliminate Officer   -   gain 1 point if side, if main, need to id him before complete
            [localize "STR_TRGM2_startInfMission_MissionTitle7"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = [localize "STR_TRGM2_startInfMission_MissionTitle8_Eliminated", 1, "HVT Killed", selectRandom InterogateOfficerClasses, TRGM_VAR_EnemySide, "KILL", localize "STR_TRGM2_startInfMission_MissionTitle8_Button", "", [(localize "STR_TRGM2_startInfMission_MissionTitle7_Desc") + (["", localize "STR_TRGM2_startInfMission_MissionTitle8_MustSearch"] select (_bIsMainObjective)) + TRGM_VAR_OfficerImage]];
            ["Mission Setup: Generating Eliminate Officer", true] call TRGM_GLOBAL_fnc_log;
        };
        case 8: {
            ["Mission Setup: Init Assasinate weapon dealer", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hvtMission; //Assasinate weapon dealer   -   gain 1 point if side, no intel from him... if main need to id him before complete
            [localize "STR_TRGM2_startInfMission_MissionTitle8"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = [localize "STR_TRGM2_startInfMission_MissionTitle8_Eliminated", 1, "HVT Killed", selectRandom WeaponDealerClasses, Civilian, "KILL", localize "STR_TRGM2_startInfMission_MissionTitle8_Button", "", [(localize "STR_TRGM2_startInfMission_MissionTitle8_Desc") + (["", localize "STR_TRGM2_startInfMission_MissionTitle8_MustSearch"] select (_bIsMainObjective)) + TRGM_VAR_WeaponDealerImage]];
            ["Mission Setup: Generating Assasinate weapon dealer", true] call TRGM_GLOBAL_fnc_log;
        };
        case 9: {
            ["Mission Setup: Init Destroy AAA vehicles", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_destroyVehiclesMission; //Destroy AAA vehicles
            [localize "STR_TRGM2_startInfMission_MissionTitle9"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = [localize "STR_TRGM2_startInfMission_MissionTitle9_Destory", 1, "Destroyed AAA", selectRandom (call DestroyAAAVeh), [localize "STR_TRGM2_startInfMission_MissionTitle9_Desc"]];
            ["Mission Setup: Generating Destroy AAA vehicles", true] call TRGM_GLOBAL_fnc_log;
        };
        case 10: {
            ["Mission Setup: Init Destroy Artillery vehicles", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_destroyVehiclesMission; //Destroy Artillery vehicles
            [localize "STR_TRGM2_startInfMission_MissionTitle10"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = [localize "STR_TRGM2_startInfMission_MissionTitle10_Destory", 1, "Destroyed Artillery", selectRandom (call sArtilleryVeh), [localize "STR_TRGM2_startInfMission_MissionTitle10_Desc"]];
            ["Mission Setup: Generating Destroy Artillery vehicles", true] call TRGM_GLOBAL_fnc_log;
        };
        case 11: {
            ["Mission Setup: Init Rescue POW", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hvtMission; //Rescue POW
            [localize "STR_TRGM2_Rescue_POW"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Rescued a POW, reputation increased.", 1, "Rescued a POW", selectRandom FriendlyVictims, TRGM_VAR_FriendlySide, "RESCUE", "", "", ["We need you to locate and rescue our POW, the enemy are trying to gain valuable information from our guy!"]];
            ["Mission Setup: Generating Rescue POW", true] call TRGM_GLOBAL_fnc_log;
        };
        case 12: {
            ["Mission Setup: Init Rescue Reporter", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_hvtMission; //Rescue Reporter
            [localize "STR_TRGM2_Rescue_Reporter"] call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Rescued a Reporter, reputation increased.", 1, "Rescued a Reporter", selectRandom Reporters, Civilian, "RESCUE", "", "", ["We need you to locate and rescue a reporter!"]];
            ["Mission Setup: Generating Rescue Reporter", true] call TRGM_GLOBAL_fnc_log;
        };
        case 13: {
            ["Mission Setup: Init Defuse 3 IEDs", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_defuseIEDsMission; //Defuse 3 IEDs
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Defused IEDs, reputation increased.", 1, "Defused IEDs"];
            ["Mission Setup: Generating Defuse 3 IEDs", true] call TRGM_GLOBAL_fnc_log;
        };
        case 14: {
            ["Mission Setup: Init Defuse Bomb", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_bombDisposalMission; //Defuse Bomb
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Defused Bomb, reputation increased.", 1, "Defused Bomb"];
            ["Mission Setup: Generating Defuse Bomb", true] call TRGM_GLOBAL_fnc_log;
        };
        case 15: {
            ["Mission Setup: Init Search and Destroy", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_searchAndDestroyMission; //Search and Destroy
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Targets destoryed, reputation increased.", 1, "Targets destoryed"];
            ["Mission Setup: Generating Search and Destroy", true] call TRGM_GLOBAL_fnc_log;
        };
        case 16: {
            ["Mission Setup: Init Destroy Cache", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_destroyCacheMission; //Destroy Cache
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Cache destoryed, reputation increased.", 1, "Cache destoryed"];
            ["Mission Setup: Generating Destroy Cache", true] call TRGM_GLOBAL_fnc_log;
        };
        case 17:  {
            ["Mission Setup: Init Secure and Resupply", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_secureAndResupplyMission; //Secure and Resupply
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Area Cleared, reputation increased.", 1, "Area Cleared"];
            ["Mission Setup: Generating Secure and Resupply", true] call TRGM_GLOBAL_fnc_log;
        };
        case 18:  {
            ["Mission Setup: Init Meeting Assassination", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_meetingAssassinationMission; //Meeting Assassination
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["HVT assassinated, reputation increased.", 1, "HVT assassinated"];
            ["Mission Setup: Generating Meeting Assassination", true] call TRGM_GLOBAL_fnc_log;
        };
        case 19:  {
            ["Mission Setup: Init Ambush Convoy", true] call TRGM_GLOBAL_fnc_log;
            call MISSIONS_fnc_ambushConvoyMission //Ambush Convoy
            call MISSION_fnc_CustomVars;
            _bNewTaskSetup = true;
            _args = ["Convoy eliminated, reputation increased.", 1, "Convoy eliminated"];
            ["Mission Setup: Generating Ambush Convoy", true] call TRGM_GLOBAL_fnc_log;
        };
        case 99999: {
            ["Mission Setup: Init Custom Mission", true] call TRGM_GLOBAL_fnc_log;
            call CUSTOM_MISSION_fnc_CustomMission; //Custom Mission
            call MISSION_fnc_CustomVars;
            _args = ["Objective completed, reputation increased.", 1, "Objective completed"];
            ["Mission Setup: Generating Custom Mission", true] call TRGM_GLOBAL_fnc_log;
        };
        default { };
    };

    _bUserDefinedAO = false;
    ///*orangestest
    if (_iTaskIndex isEqualTo 0 && {!isNil "TRGM_VAR_Mission1Loc"}) then {
        _bUserDefinedAO = true;
    };
    if (_iTaskIndex isEqualTo 1 && {!isNil "TRGM_VAR_Mission2Loc"}) then {
        _bUserDefinedAO = true;
    };
    if (_iTaskIndex isEqualTo 2 && {!isNil "TRGM_VAR_Mission3Loc"}) then {
        _bUserDefinedAO = true;
    };
    [format ["Mission Setup: Task: %1", _iTaskIndex], true] call TRGM_GLOBAL_fnc_log;
    //orangestest*/

    //kill leader (he will run away in car to AO)    ::   save stranded guys    ::

    ["Mission Setup: Getting potential locations", true] call TRGM_GLOBAL_fnc_log;

    TRGM_VAR_allLocationPositions = TRGM_VAR_allLocations apply {[locationPosition _x select 0, locationPosition _x select 1]};
    TRGM_VAR_allLocationPositions = TRGM_VAR_allLocationPositions select {((getMarkerPos "mrkHQ") distance _x) > TRGM_VAR_SideMissionMinDistFromBase};
    TRGM_VAR_allLocationPositions = TRGM_VAR_allLocationPositions select {count nearestObjects [_x, TRGM_VAR_BasicBuildings, 200] > 0};

    ["Mission Setup: Locations found", true] call TRGM_GLOBAL_fnc_log;

    ["Mission Setup: 10", true] call TRGM_GLOBAL_fnc_log;
    _attempts = 0;
    while {!_bInfor1Found} do {
        _attempts = _attempts + 1;
        ["Mission Setup: 9", true] call TRGM_GLOBAL_fnc_log;
        _markerInformant1 = nil;

        if (!_SamePrevAO || {_bUserDefinedAO || {_attempts > 100}}) then {
            _randLocation = if !(isNil "TRGM_VAR_allLocationPositions") then {selectRandom TRGM_VAR_allLocationPositions} else {[0 + (floor random 25000), 0 + (floor random 25000)]};
            _randInfor1X = _randLocation select 0;
            _randInfor1Y = _randLocation select 1;
            _buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TRGM_VAR_BasicBuildings, 200*_attempts] select {!((_x buildingPos -1) isEqualTo [])};

            if (_iTaskIndex isEqualTo 0 && {!_bIsCampaign && {!(isNil "TRGM_VAR_Mission1Loc")}}) then {
                _randInfor1X = TRGM_VAR_Mission1Loc select 0;
                _randInfor1Y = TRGM_VAR_Mission1Loc select 1;
                _buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TRGM_VAR_BasicBuildings, 50*_attempts] select {!((_x buildingPos -1) isEqualTo [])};
                if (_attempts > 100) then {[format["Still no location found after %1 attempts!",_attempts]] call TRGM_GLOBAL_fnc_notify;}
            };

            if (_iTaskIndex isEqualTo 1 && {!_bIsCampaign && {!(isNil "TRGM_VAR_Mission2Loc")}}) then {
                _randInfor1X = TRGM_VAR_Mission2Loc select 0;
                _randInfor1Y = TRGM_VAR_Mission2Loc select 1;
                _buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TRGM_VAR_BasicBuildings, 50*_attempts] select {!((_x buildingPos -1) isEqualTo [])};
                if (_attempts > 100) then {[format["Still no location found after %1 attempts!",_attempts]] call TRGM_GLOBAL_fnc_notify;}
            };

            if (_iTaskIndex isEqualTo 2 && {!_bIsCampaign && {!(isNil "TRGM_VAR_Mission3Loc")}}) then {
                _randInfor1X = TRGM_VAR_Mission3Loc select 0;
                _randInfor1Y = TRGM_VAR_Mission3Loc select 1;
                _buildings = nearestObjects [[_randInfor1X,_randInfor1Y], TRGM_VAR_BasicBuildings, 50*_attempts] select {!((_x buildingPos -1) isEqualTo [])};
                if (_attempts > 100) then {[format["Still no location found after %1 attempts!",_attempts]] call TRGM_GLOBAL_fnc_notify;}
            };
        };

        _isPosFarEnoughFromHq = (getMarkerPos "mrkHQ" distance [_randInfor1X, _randInfor1Y]) > TRGM_VAR_SideMissionMinDistFromBase;
        _playerSelectedAo = call TRGM_GETTER_fnc_bManualAOPlacement;

        if ((_isPosFarEnoughFromHq || _playerSelectedAo) && {(count _buildings) > 0}) then {
            ["Mission Setup: Task location found", true] call TRGM_GLOBAL_fnc_log;
            _bInfor1Found = true;
            _infBuilding = selectRandom _buildings;
            _infBuilding setDamage 0;
            _allBuildingPos = _infBuilding buildingPos -1;
            _inf1X = position _infBuilding select 0;
            _inf1Y = position _infBuilding select 1;
            if (count _allBuildingPos > 2) then {
                _TasksToValidate = [_iThisTaskType];
                if (count _SamePrevAOStats > TRGM_VAR_InfTaskCount) then {
                    if (_SamePrevAOStats select (TRGM_VAR_InfTaskCount + 1)) then {
                        _TasksToValidate = _TasksToValidate + [_ThisTaskTypes select (TRGM_VAR_InfTaskCount + 1)];
                        if (count _SamePrevAOStats > TRGM_VAR_InfTaskCount + 1) then {
                            if (_SamePrevAOStats select (TRGM_VAR_InfTaskCount + 2)) then {
                                _TasksToValidate = _TasksToValidate + [_ThisTaskTypes select (TRGM_VAR_InfTaskCount + 2)];
                            };
                        };
                    };
                };

                _nearestRoads = nil;
                {
                    if (_x isEqualTo 99999 || _bNewTaskSetup) then {
                        _bCustomRequiredPass = true;
                        if (_CustomMissionEnabled || _bNewTaskSetup) then {
                            _bCustomRequiredPass = [_infBuilding,_inf1X,_inf1Y] call MISSION_fnc_CustomRequired;
                        };
                        if (!_bCustomRequiredPass) then {
                            _bInfor1Found = false
                        };
                    };

                    _nearestRoads = [_inf1X,_inf1Y] nearRoads _roadSearchRange;
                    if (_RequiresNearbyRoad) then {
                        if (count _nearestRoads isEqualTo 0) then {
                            _bInfor1Found = false;
                        };
                    };
                } forEach _TasksToValidate;


                if (_bInfor1Found) then {
                    TRGM_VAR_ObjectivePossitions pushBack [_inf1X,_inf1Y];
                    publicVariable "TRGM_VAR_ObjectivePossitions";
                    if (_MarkerType isEqualTo "empty") then {
                        TRGM_VAR_HiddenPossitions pushBack [_inf1X,_inf1Y];
                        publicVariable "TRGM_VAR_HiddenPossitions";
                        _hideTitleAndDesc = true;
                    };
                    _sTaskDescription = "";
                    if (TRGM_VAR_ISUNSUNG) then {
                        if (_iThisTaskType isEqualTo 6) then {
                            _radio = selectRandom ["uns_radio2_transitor_NVA","uns_radio2_transitor_NVA"] createVehicle (selectRandom (_infBuilding buildingPos -1));
                        }
                        else {
                            _radio = selectRandom ["uns_radio2_nva_radio","uns_radio2_transitor_NVA","uns_radio2_transitor_NVA"] createVehicle (selectRandom (_infBuilding buildingPos -1));
                        };

                    };
                    //###################################### CUSTOM MISSION ######################################
                    ["Mission Setup: 8-0-10", true] call TRGM_GLOBAL_fnc_log;
                    if (_iThisTaskType isEqualTo 99999 || _bNewTaskSetup) then {
                        ["Mission Setup: Generating mission", true] call TRGM_GLOBAL_fnc_log;
                        [_MarkerType, _infBuilding, _inf1X, _inf1Y, _roadSearchRange, _bCreateTask, _iTaskIndex, _bIsMainObjective, _args] call MISSION_fnc_CustomMission;
                    };
                    //############################################################################################
                    ["Mission Setup: 8-2", true] call TRGM_GLOBAL_fnc_log;

                    if (!isNil "TRGM_VAR_Mission1Title") then {_MissionTitle = TRGM_VAR_Mission1Title};
                    if (!isNil "TRGM_VAR_Mission1Desc") then {_sTaskDescription = TRGM_VAR_Mission1Desc};

                    TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["\n_bIsMainObjective: %1",_bIsMainObjective];
                    TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["\n_iTaskIndex: %1",_iTaskIndex];
                    TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["\n_MissionTitle: %1",_MissionTitle];

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
                    if (!isNil "TRGM_VAR_HideAoMarker") then {
                        _hideAoMarker = TRGM_VAR_HideAoMarker;
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
                        if (str(getMarkerPos _sCurrMrkName) isEqualTo str(getMarkerPos _sPrevMrkName)) then {
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

                    if (_iTaskIndex isEqualTo 0 && TRGM_VAR_iMissionParamType != 5) then {_allowFriendlyIns = false};

                    if (_bSideMissionsCivOnlyToUse && !_bCreateTask) then {
                        TRGM_VAR_ClearedPositions pushBack [_inf1X,_inf1Y];
                        publicVariable "TRGM_VAR_ClearedPositions";
                        _markerInformant1 setMarkerText (localize "STR_TRGM2_startInfMission_markerInformant");
                        if (!_SamePrevAO) then {
                            [[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns,true] spawn TRGM_SERVER_fnc_populateSideMission;
                        };
                    }
                    else {
                        if (!_SamePrevAO) then {
                            [[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, _iTaskIndex, _allowFriendlyIns] spawn TRGM_SERVER_fnc_populateSideMission;
                        };
                    };

                    //[_sTaskDescription] call TRGM_GLOBAL_fnc_notify;

                    if (_bCreateTask) then {
                        if (_bIsCampaign) then {
                            [TRGM_VAR_FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format[localize "STR_TRGM2_startInfMission_MissionDayTitle",_iTaskIndex+1,_MissionTitle],""]] call FHQ_fnc_ttAddTasks;
                            TRGM_VAR_ActiveTasks pushBack format["InfSide%1",_iTaskIndex];
                            publicVariable "TRGM_VAR_ActiveTasks";
                        }
                        else {
                            if (_hideTitleAndDesc) then {
                                [TRGM_VAR_FriendlySide,[format["InfSide%1",_iTaskIndex], "Objective unknown, recon the area!", format["%1 : %2",_iTaskIndex+1,"Objective Unknown"],""]] call FHQ_fnc_ttAddTasks;
                            }
                            else {
                                [TRGM_VAR_FriendlySide,[format["InfSide%1",_iTaskIndex], _sTaskDescription, format["%1 : %2",_iTaskIndex+1,_MissionTitle],""]] call FHQ_fnc_ttAddTasks;
                            };

                            TRGM_VAR_ActiveTasks pushBack format["InfSide%1",_iTaskIndex];
                            publicVariable "TRGM_VAR_ActiveTasks";
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
        ["Mission Setup: 8-1", true] call TRGM_GLOBAL_fnc_log;
    };

    if (TRGM_VAR_InfTaskCount isEqualTo 0) then {
        TRGM_VAR_CurrentZeroMissionTitle = _MissionTitle; //curently only used for campaign
        if (TRGM_VAR_MainMissionTitle != "") then {TRGM_VAR_CurrentZeroMissionTitle = TRGM_VAR_MainMissionTitle};
        publicVariable "TRGM_VAR_CurrentZeroMissionTitle";
        if (_hideTitleAndDesc) then {
            TRGM_VAR_MainMissionTitle = "Objective Unknown";
        };
    };
    ["Mission Setup: 8-0", true] call TRGM_GLOBAL_fnc_log;
    TRGM_VAR_InfTaskCount = TRGM_VAR_InfTaskCount + 1;
};


["Mission Setup: 7", true] call TRGM_GLOBAL_fnc_log;

_trgComplete = createTrigger ["EmptyDetector", [0,0]];
_trgComplete setVariable ["DelMeOnNewCampaignDay",true];
_trgComplete setTriggerArea [0, 0, 0, false];
if (TRGM_VAR_iMissionParamType isEqualTo 5) then {
    _totalRep = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;

    if (_totalRep >= 10 && TRGM_VAR_FinalMissionStarted) then {
        _trgComplete setTriggerStatements ["TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksCompleted;", "[TRGM_VAR_FriendlySide, [""DeBrief"", localize ""STR_TRGM2_mainInit_Debrief"", ""Debrief"", """"]] call FHQ_fnc_ttAddTasks;  [""CAMPAIGN_END""] remoteExec [""TRGM_SERVER_fnc_setMissionBoardOptions"",0,true];}; deletevehicle thisTrigger", ""];

    }
    else {
        _trgComplete setTriggerStatements ["TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksCompleted;", "[(localize ""STR_TRGM2_startInfMission_RTBNextMission"")] call TRGM_GLOBAL_fnc_notify; [""MISSION_COMPLETE""] remoteExec [""TRGM_SERVER_fnc_setMissionBoardOptions"",0,true]; if (TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksSuccessful) then {[1, format[localize ""STR_TRGM2_startInfMission_DayComplete"",str(TRGM_VAR_iCampaignDay)]] spawn TRGM_GLOBAL_fnc_adjustMaxBadPoints}; deletevehicle thisTrigger", ""];
    };
    //TESTTEST = triggerStatements _trgComplete;
}
else {
    //_trgComplete setTriggerStatements ["TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksCompleted;", "", ""]; //not sure why this is here... commented out on 5th Jan 2018... delete of no issues sinse

    //If not campaign and rep is disabled, then we will not fail the mission if rep low, but will be a task to keep rep above average
    if (TRGM_VAR_iMissionParamRepOption isEqualTo 0) then {
        //CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
        [TRGM_VAR_FriendlySide, ["tskKeepAboveAverage",localize "STR_TRGM2_startInfMission_HoldReputation_Desc",localize "STR_TRGM2_startInfMission_HoldReputation_Title",""]] call FHQ_fnc_ttAddTasks;
        ["tskKeepAboveAverage", "created"] call FHQ_fnc_ttSetTaskState;
    };
    if (TRGM_VAR_iMissionParamRepOption isEqualTo 1) then {
        //CREATE TASK HERE... we fail it in mainInit.sqf when checking rep points
        [TRGM_VAR_FriendlySide, ["tskKeepAboveAverage",localize "STR_TRGM2_startInfMission_HoldReputation_Desc",localize "STR_TRGM2_startInfMission_HoldReputation_Title2",""]] call FHQ_fnc_ttAddTasks;
        ["tskKeepAboveAverage", "created"] call FHQ_fnc_ttSetTaskState;
    };

};

["Mission Setup: 6", true] call TRGM_GLOBAL_fnc_log;
///*orangestest



///*orangestest
//now we have all our location positinos, we can set other area stuff
[] spawn TRGM_SERVER_fnc_setOtherAreaStuff;
//orangestest*/

//orangestest*/
["Mission Setup: 2", true] call TRGM_GLOBAL_fnc_log;


["Mission Setup: 1", true] call TRGM_GLOBAL_fnc_log;


publicVariable "TRGM_VAR_debugMessages";
[TRGM_VAR_debugMessages, true] call TRGM_GLOBAL_fnc_log;

[(localize "STR_TRGM2_startInfMission_SoItBegin")] call TRGM_GLOBAL_fnc_notify;

///*orangestest
[] remoteExec ["TRGM_GLOBAL_fnc_animateAnimals",0,true];
//orangestest*/

TRGM_VAR_MissionLoaded = true; publicVariable "TRGM_VAR_MissionLoaded";

["Mission Setup: 0", true] call TRGM_GLOBAL_fnc_log;
true;