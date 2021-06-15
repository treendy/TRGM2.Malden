format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if !(isServer) exitWith {};

// Set relationships
west setFriend [east, 0];
west setFriend [independent, 0];
east setFriend [west, 0];
east setFriend [independent, 1];
independent setFriend [west, 0];
independent setFriend [east, 1];
civilian setFriend [west, 1];
civilian setFriend [east, 1];

TRGM_VAR_SniperCount = 0; publicVariable "TRGM_VAR_SniperCount";
TRGM_VAR_SniperAttemptCount = 0; publicVariable "TRGM_VAR_SniperAttemptCount";
TRGM_VAR_SpotterCount = 0; publicVariable "TRGM_VAR_SpotterCount";
TRGM_VAR_SpotterAttemptCount = 0; publicVariable "TRGM_VAR_SpotterAttemptCount";
TRGM_VAR_friendlySentryCheckpointPos = []; publicVariable "TRGM_VAR_friendlySentryCheckpointPos";

if (isNil "tracer1") then {
    tracer1 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
    tracer1 setVehicleVarName "tracer1";
    tracer1 setVariable ['Side',"0",true];
    tracer1 setVariable ['Min',"10",true];
    tracer1 setVariable ['Max',"20",true];
    tracer1 setVariable ['Weapon',"",true];
    tracer1 setVariable ['Magazine',"",true];
    tracer1 setVariable ['Target',"",true];
    tracer1 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
if (isNil "tracer2") then {
    tracer2 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
    tracer2 setVehicleVarName "tracer2";
    tracer2 setVariable ['Side',"2",true];
    tracer2 setVariable ['Min',"10",true];
    tracer2 setVariable ['Max',"20",true];
    tracer2 setVariable ['Weapon',"",true];
    tracer2 setVariable ['Magazine',"",true];
    tracer2 setVariable ['Target',"",true];
    tracer2 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
if (isNil "tracer3") then {
    tracer3 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
    tracer3 setVehicleVarName "tracer3";
    tracer3 setVariable ['Side',"0",true];
    tracer3 setVariable ['Min',"10",true];
    tracer3 setVariable ['Max',"20",true];
    tracer3 setVariable ['Weapon',"",true];
    tracer3 setVariable ['Magazine',"",true];
    tracer3 setVariable ['Target',"",true];
    tracer3 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
if (isNil "tracer4") then {
    tracer4 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
    tracer4 setVehicleVarName "tracer4";
    tracer4 setVariable ['Side',"0",true];
    tracer4 setVariable ['Min',"10",true];
    tracer4 setVariable ['Max',"20",true];
    tracer4 setVariable ['Weapon',"",true];
    tracer4 setVariable ['Magazine',"",true];
    tracer4 setVariable ['Target',"",true];
    tracer4 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
tracer1 setPos [99999,99999];
tracer2 setPos [99999,99999];
tracer3 setPos [99999,99999];
tracer4 setPos [99999,99999];

[true] call TRGM_SERVER_fnc_setTimeAndWeather;

waitUntil {time > 0};

_trgRatingAdjust = createTrigger ["EmptyDetector", [0,0]];
_trgRatingAdjust setTriggerArea [0, 0, 0, false];
_trgRatingAdjust setTriggerStatements ["((rating player) < 0)", "player addRating -(rating player)", ""];

// Instead of only doing this in SP, check if the HCs are empty and delete the unused ones.
if (!isNil "vs1")  then { deleteVehicle vs1; };
if (!isNil "vs2")  then { deleteVehicle vs2; };
if (!isNil "vs3")  then { deleteVehicle vs3; };
if (!isNil "vs4")  then { deleteVehicle vs4; };
if (!isNil "vs5")  then { deleteVehicle vs5; };
if (!isNil "vs6")  then { deleteVehicle vs6; };
if (!isNil "vs7")  then { deleteVehicle vs7; };
if (!isNil "vs8")  then { deleteVehicle vs8; };
if (!isNil "vs9")  then { deleteVehicle vs9; };
if (!isNil "vs10") then { deleteVehicle vs10; };

waitUntil { TRGM_VAR_bAndSoItBegins };

TRGM_VAR_PopulateLoadingWait_percentage = 0; publicVariable "TRGM_VAR_PopulateLoadingWait_percentage";

[format["Mission Core: %1", "Init"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

if (TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_GROUP_MANAGE_IDX isEqualTo 1) then {
    ["Initialize"] call BIS_fnc_dynamicGroups;//Exec on Server
};

format["Mission Core: %1", "GroupManagementSet"] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

call TRGM_SERVER_fnc_initUnitVars;

[format["Mission Core: %1", "GlobalVarsSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

call TRGM_GLOBAL_fnc_buildEnemyFaction;
[format["Mission Core: %1", "EnemyGlobalVarsSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

call TRGM_GLOBAL_fnc_buildFriendlyFaction;
[format["Mission Core: %1", "FriendlyGlobalVarsSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

call CUSTOM_MISSION_fnc_SetEnemyFaction; //if TRGM_VAR_useCustomEnemyFaction set to true within this sqf, will overright the above enemy faction data
call CUSTOM_MISSION_fnc_SetMilitiaFaction; //if TRGM_VAR_useCustomMilitiaFaction set to true within this sqf, will overright the above enemy faction data
[format["Mission Core: %1", "EnemyFactionSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

call CUSTOM_MISSION_fnc_SetFriendlyFaction; //if TRGM_VAR_useCustomFriendlyFaction set to true within this sqf, will overright the above enemy faction data
[format["Mission Core: %1", "FriendlyLoadoutSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

// Fix any changed types
if (typeName sCivilian != "ARRAY") then {sCivilian = [sCivilian]};
// end

private _airTransClassName = selectRandom ((call SupplySupportChopperOptions) select {_x call TRGM_GLOBAL_fnc_isTransport});
if (!isNil "chopper1" && {_airTransClassName != typeOf chopper1}) then {
    {deleteVehicle _x;} forEach crew chopper1 + [chopper1];
    chopper1 = createVehicle [_airTransClassName, getPos heliPad1, [], 0, "NONE"];
    createVehicleCrew chopper1;
    crew vehicle chopper1 joinSilent createGroup WEST;
    chopper1 setVehicleVarName "chopper1";
    publicVariable "chopper1";
    chopper1 allowDamage false;
    chopper1 setPos getPos heliPad1;
    chopper1 setVelocity [0, 0, 0];
    chopper1 setdamage 0;
    chopper1 engineOn false;
    chopper1 lockDriver true;
    chopper1D = driver chopper1;
    chopper1D setVehicleVarName "chopper1D";
    chopper1D allowDamage false;
    chopper1D setCaptive true;
    chopper1D disableAI "AUTOTARGET";
    chopper1D disableAI "TARGET";
    chopper1D disableAI "SUPPRESSION";
    chopper1D disableAI "AUTOCOMBAT";
    chopper1D setBehaviour "CARELESS";
    publicVariable "chopper1D";
    private _totalTurrets = [_airTransClassName, true] call BIS_fnc_allTurrets;
    {chopper1 lockTurret [_x, true]} forEach _totalTurrets;
    { doStop _x; } forEach crew chopper1;
    chopper1 setPos getPos heliPad1;
};

private _airSupClassName = selectRandom (call FriendlyChopper);
if (!isNil "chopper2" && {_airSupClassName != typeOf chopper2}) then {
    {deleteVehicle _x;} forEach crew chopper2 + [chopper2];
    chopper2 = createVehicle [_airSupClassName, getPos airSupportHeliPad, [], 0, "NONE"];
    createVehicleCrew chopper2;
    crew vehicle chopper2 joinSilent createGroup WEST;
    chopper2 setVehicleVarName "chopper2";
    publicVariable "chopper2";
    chopper2 allowDamage false;
    chopper2 setPos getPos airSupportHeliPad;
    chopper2 setVelocity [0, 0, 0];
    chopper2 setdamage 0;
    chopper2 engineOn false;
    chopper2 lockDriver true;
    chopper2D = driver chopper2;
    chopper2D setVehicleVarName "chopper2D";
    publicVariable "chopper2D";
    private _totalTurrets = [_airSupClassName, true] call BIS_fnc_allTurrets;
    {chopper2 lockTurret [_x, true]} forEach _totalTurrets;
    { doStop _x; } forEach crew chopper2;
    chopper2 setPos getPos airSupportHeliPad;
    chopper2 allowDamage true;
};

TRGM_VAR_transportHelosToGetActions = [];
{
    if (isClass(configFile >> "CfgVehicles" >> typeOf _x) && {_x isKindOf "LandVehicle" || _x isKindOf "Air" || _x isKindOf "Ship"}) then {
        _faction = getText(configFile >> "CfgVehicles" >> typeOf _x >> "faction");
        _friendlyFactionIndex = TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_FRIENDLY_FACTIONS_IDX;
        _westFaction = (TRGM_VAR_AllFactionData select _friendlyFactionIndex) select 0;
        if ((crew _x) isEqualTo [] && {getNumber(configFile >> "CfgFactionClasses" >> _faction >> "side") isEqualTo 1 && {_faction != _westFaction}}) then {
            _newVehClass = [_x, WEST] call TRGM_GLOBAL_fnc_getFactionVehicle;
            if (!isNil "_newVehClass") then {
                private _pos = getPosATL _x;
                private _dir = getDir _x;
                deleteVehicle _x;
                sleep 0.01;
                private _newVeh = createVehicle [_newVehClass, _pos, [], 0, "NONE"];
                _newVeh setDir _dir;
                _newVeh allowDamage false;
                _newVeh setPos (_pos vectorAdd [0,0,0.1]);
                _newVeh allowDamage true;
            };

        };
    };

    if ((count crew _x) > 0 && {isClass(configFile >> "CfgVehicles" >> typeOf _x) && {_x isKindOf "Air" && {_x call TRGM_GLOBAL_fnc_isTransport}}}) then {
        TRGM_VAR_transportHelosToGetActions pushBackUnique _x;
    };
} forEach vehicles;

[TRGM_VAR_transportHelosToGetActions] call TRGM_GLOBAL_fnc_addTransportActions;
[format["Mission Core: %1", "TransportScriptRun"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

TRGM_VAR_CustomObjectsSet = true; publicVariable "TRGM_VAR_CustomObjectsSet";
// call compile preprocessFileLineNumbers "RandFramework\setFriendlyObjects.sqf";
[format["Mission Core: %1", "FriendlyObjectsSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[format["Mission Core: %1", "EnemyFactionDataProcessed"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

_isAceRespawnWithGear = false;
if (call TRGM_GLOBAL_fnc_isCbaLoaded) then {
    // check for ACE respawn with gear setting
    _isAceRespawnWithGear = "ace_respawn_savePreDeathGear" call CBA_settings_fnc_get;
};

[format["Mission Core: %1", "savePreDeathGear"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;
{
    if (!isPlayer _x) then {
        _handle = [_x] call TRGM_GLOBAL_fnc_setLoadout;
        waitUntil {_handle};
        if (!isNil("_isAceRespawnWithGear")) then {
            if (!_isAceRespawnWithGear) then {
                _x addEventHandler ["Respawn", { [_this select 0] call TRGM_GLOBAL_fnc_setLoadout; }];
            };
        };
    };
} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
[format["Mission Core: %1", "setLoadout ran"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

box1 allowDamage false;
[box1, (if (isMultiplayer) then {playableUnits} else {switchableUnits})] call TRGM_GLOBAL_fnc_initAmmoBox;

[format["Mission Core: %1", "boxCargo set"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[format["Mission Core: %1", "PreCustomObjectSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

waitUntil { TRGM_VAR_CustomObjectsSet };

[endMissionBoard] remoteExec ["removeAllActions"];
[endMissionBoard2] remoteExec ["removeAllActions"];

if (TRGM_VAR_iMissionSetup isEqualTo 5 && isMultiplayer && isServer) then {
    if (TRGM_VAR_SaveType isEqualTo 0) then {
        [laptop1, [localize "STR_TRGM2_TRGMInitPlayerLocal_SaveLocal",{[1,true] spawn TRGM_SERVER_fnc_serverSave;}]] remoteExec ["addaction"];
        [laptop1, [localize "STR_TRGM2_TRGMInitPlayerLocal_SaveGlobal",{[2,true] spawn TRGM_SERVER_fnc_serverSave;}]] remoteExec ["addaction"];
    };
    if (TRGM_VAR_SaveType isEqualTo 1) then {
        [(localize "STR_TRGM2_ServerSave_Save1")] call TRGM_GLOBAL_fnc_notify;
        [laptop1, [localize "STR_TRGM2_ServerSave_SaveLocal",{[(localize "STR_TRGM2_ServerSave_SaveHint")] call TRGM_GLOBAL_fnc_notify}]] remoteExec ["addaction"];
    };
    if (TRGM_VAR_SaveType isEqualTo 2) then {
        [(localize "STR_TRGM2_ServerSave_Save2")] call TRGM_GLOBAL_fnc_notify;
        [laptop1, [localize "STR_TRGM2_ServerSave_SaveGlobal",{[(localize "STR_TRGM2_ServerSave_SaveHint2")] call TRGM_GLOBAL_fnc_notify}]] remoteExec ["addaction"];
    };
};

[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRepLong", {[true] spawn TRGM_GLOBAL_fnc_showRepReport;}]] remoteExec ["addAction"];
[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_EndMission",{_this spawn TRGM_SERVER_fnc_attemptEndMission;}]] remoteExec ["addAction", 0];

[format["Mission Core: %1", "PostCustomObjectSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

if (TRGM_VAR_iUseRevive > 0 && {isNil "AIS_MOD_ENABLED"}) then {
    call AIS_Core_fnc_preInit;
    call AIS_Core_fnc_postInit;
    call AIS_System_fnc_postInit;
};

[format["Mission Core: %1", "AIS Script Run"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;


// Place in unit init to have them deleted in MP: this setVariable ["MP_ONLY", true, true];
if (!isMultiplayer) then {
    {
        if (_x getVariable ["MP_ONLY",false] && !isNil "_x") then {
            deleteVehicle _x;
        };
    } forEach allUnits;
};

[format["Mission Core: %1", "DeleteMpOnlyVehicles"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[format["Mission Core: %1", "DoFollowRun"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[format["Mission Core: %1", "CoreFinished"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

TRGM_VAR_CoreCompleted = true; publicVariable "TRGM_VAR_CoreCompleted";

if (TRGM_VAR_iMissionParamType isEqualTo 5) then {
    if (isServer) then {
        call TRGM_SERVER_fnc_initCampaign;
    };
}
else {
    call TRGM_SERVER_fnc_startMission;
};
[format["Mission Core: %1", "InitCampaign/StartMission ran"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

waitUntil { TRGM_VAR_MissionLoaded; };

[format["Mission Core: %1", "TRGM_VAR_MissionLoaded true"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[format["Mission Core: %1", "BadPointsSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

{
    _x setVariable ["DontDelete",true];
} forEach nearestObjects [getMarkerPos "mrkHQ", ["all"], 2000];
[format["Mission Core: %1", "DontDeleteSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

if (isMultiplayer && {!(TRGM_VAR_iMissionParamType isEqualTo 5)}) then {
    [] spawn TRGM_SERVER_fnc_checkAnyPlayersAlive;
};

[format["Mission Core: %1", "NonAliveEndCheckRunning"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

if (TRGM_VAR_iAllowNVG isEqualTo 0) then {
    {
        _unit = _x;
        _unit addPrimaryWeaponItem "acc_flashlight";
        _unit enableGunLights "forceOn";
        {_unit unassignItem _x; _unit removeItem _x;} forEach TRGM_VAR_aNVClassNames;
    } forEach allUnits;
};
[format["Mission Core: %1", "NVGStateSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[] spawn TRGM_SERVER_fnc_playBaseRadioEffect;
[format["Mission Core: %1", "PlayBaseRadioEffect"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[] spawn TRGM_SERVER_fnc_weatherAffectsAI;

[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

[] spawn TRGM_SERVER_fnc_sandStormEffect;

// [] spawn TRGM_GLOBAL_fnc_animateAnimals; // This is nice and all, but it adds an uneeded cost to performance and spams RPT

[format["Mission Core: %1", "AnimalStateSet"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

if (TRGM_VAR_iMissionParamType != 5) then {
    [] remoteExec ["TRGM_SERVER_fnc_postStartMission"];
};

[format["Mission Core: %1", "RunFlashLightState"], true] call TRGM_GLOBAL_fnc_log;
[3.3] call TRGM_GLOBAL_fnc_populateLoadingWait;

_iEnemyFlashLightOption = TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX;
if (_iEnemyFlashLightOption isEqualTo 0) then {_iEnemyFlashLightOption = selectRandom [1,2]}; //1=yes, 2=no
if (_iEnemyFlashLightOption isEqualTo 1) then {
    {
        if ((side _x) isEqualTo East) then
        {
            if (isNil { _x getVariable "ambushUnit" }) then {
                _unit = _x;
                _unit addPrimaryWeaponItem "acc_flashlight";
                _unit enableGunLights "forceOn";
                {_unit unassignItem _x; _unit removeItem _x;} forEach TRGM_VAR_aNVClassNames;
            };
        };
    } forEach allUnits;
};

[format["Mission Core: %1", "Main Init Complete"], true] call TRGM_GLOBAL_fnc_log;
[100] call TRGM_GLOBAL_fnc_populateLoadingWait;
TRGM_VAR_AllInitScriptsFinished = true; publicVariable "TRGM_VAR_AllInitScriptsFinished";