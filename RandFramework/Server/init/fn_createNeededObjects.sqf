params[["_pos", [0,0,0]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;


// create the HQ building
[_pos, sizeOf "Land_Cargo_HQ_V1_F"] call TRGM_GLOBAL_fnc_hideTerrainObjects;
HQBuilding = "Land_Cargo_HQ_V1_F" createVehicle _pos;
HQBuilding setVehicleVarName "HQBuilding";
HQBuilding allowDamage false;
publicVariable "HQBuilding";
private _HQpos = getPos HQBuilding;
TRGM_VAR_spawnedObjectsArray = [[_HQpos, sizeOf "Land_Cargo_HQ_V1_F"]];
bAllAtBase = false; publicVariable "bAllAtBase";

Marker1 = createMarker ["Marker1", _HQpos];
"Marker1" setMarkerShape "ICON";
"Marker1" setMarkerType "mil_flag";
"Marker1" setMarkerColor "ColorBlue";
"Marker1" setMarkerText "Head Quarters";
publicVariable "Marker1";

mrkHQ = createMarker ["mrkHQ", _HQpos];
"mrkHQ" setMarkerShape "ICON";
"mrkHQ" setMarkerType "Empty";
publicVariable "mrkHQ";

respawn_west_HQ = createMarker ["respawn_west_HQ", _HQpos];
"respawn_west_HQ" setMarkerShape "ICON";
"respawn_west_HQ" setMarkerType "Empty";
publicVariable "respawn_west_HQ";

TRGM_VAR_trg_baseArea = createTrigger["EmptyDetector",_HQpos];
TRGM_VAR_trg_baseArea setVehicleVarName "TRGM_VAR_trg_baseArea";
TRGM_VAR_trg_baseArea setTriggerArea[300,300,0,false];
TRGM_VAR_trg_baseArea setTriggerStatements["({ (alive _x)&&(_x inArea TRGM_VAR_trg_baseArea) } count (call BIS_fnc_listPlayers)) isEqualTo ({ (alive _x) } count (call BIS_fnc_listPlayers))", "bAllAtBase = true;publicVariable 'bAllAtBase';", "bAllAtBase = false;publicVariable 'bAllAtBase';"];
publicVariable "TRGM_VAR_trg_baseArea";

opforPresentAtBaseTrigger = createTrigger["EmptyDetector",_HQpos];
opforPresentAtBaseTrigger setVehicleVarName "opforPresentAtBaseTrigger";
opforPresentAtBaseTrigger setTriggerArea[300,300,0,false];
opforPresentAtBaseTrigger setTriggerActivation["EAST","PRESENT",true];
opforPresentAtBaseTrigger setTriggerStatements["this","[West,""HQ""] sidechat 'This is HQ, there are enemies near our head quarters!'", ""];
publicVariable "opforPresentAtBaseTrigger";

SERVER = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["Logic",[0,0,0],[],0,"CAN_COLLIDE"];
SERVER setPos _HQpos;
SERVER setVehicleVarName "SERVER";
publicVariable "SERVER";
[] execVM "RandFramework\cos\cosInit.sqf";

TRGM_Logic = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["Logic",[0,0,0],[],0,"CAN_COLLIDE"];
TRGM_Logic setPos _HQpos;
TRGM_Logic setVehicleVarName "TRGM_Logic";
publicVariable "TRGM_Logic";

private _group = [getMarkerPos "mrkHQ", WEST, ["B_officer_F"]] call BIS_fnc_spawnGroup;
HQMan = units _group select 0;
HQMan setVehicleVarName "HQMan";
HQMan allowDamage false;
sleep 0.2;
HQMan setFormDir 200;
HQMan allowFleeing 0;
HQMan disableAI "TARGET";
HQMan disableAI "FSM";
HQMan disableAI "AUTOTARGET";
HQMan disableAI "MOVE";
// Disable ASR for officer
HQMan setVariable ["asr_ai_exclude", true];
// Disable VCOM for officer
HQMan setVariable ["NOAI", 1, true];
// Disable LAMBS for officer
HQMan setVariable ["lambs_danger_disableAI", true, true];
// Disable ZBE Caching
HQMan setVariable ["zbe_cacheDisabled", true, true];
HQMan setpos [_HQpos select 0, _HQpos select 1, 0.59];
HQMan setdir 270;
removeallweapons HQMan;
HQMan switchMove "acts_StandingSpeakingUnarmed";
publicVariable "HQMan";

private _object_spawn = {
    params ["_name", "_center", "_offset", ["_enableSim", false]];
    private _newx = (_center select 0) + (_offset select 0);
    private _newy = (_center select 1) + (_offset select 1);
    private _newz = (_offset select 2);

    [[_newx, _newy, _newz], sizeOf _name] call TRGM_GLOBAL_fnc_hideTerrainObjects;
    private _object = createVehicle [_name, [0,0,0], [], 0, "NONE"];
    _object allowdamage false;
    _object enableSimulation _enableSim;
    _object setpos [_newx, _newy, _newz];
    _object setdamage 0;
    TRGM_VAR_spawnedObjectsArray pushBack [getPos _object, sizeOf _name];
    _object;
};

private _building_spawn = {
    params ["_name", "_center", "_offset"];
    private _newx = (_center select 0) + (_offset select 0);
    private _newy = (_center select 1) + (_offset select 1);
    private _newz = (_offset select 2);
    private _safePos = [[_newx, _newy, _newz], sizeOf "Land_Cargo_HQ_V1_F", (sizeOf "Land_Cargo_HQ_V1_F" + sizeOf _name), sizeOf _name, 0, 0.2, 0, TRGM_VAR_spawnedObjectsArray, [[_newx, _newy],[_newx, _newy]], _name] call TRGM_GLOBAL_fnc_findSafePos; // find a valid pos

    [_safePos, sizeOf _name] call TRGM_GLOBAL_fnc_hideTerrainObjects;
    private _building = createVehicle [_name, [0,0,0], [], 0, "NONE"];
    _building allowdamage false;
    _building setpos _safePos;
    _building setdamage 0;
    TRGM_VAR_spawnedObjectsArray pushBack [getPos _building, sizeOf _name];
    _building;
};

private _helo_spawn = {
    params ["_name", "_center", "_offset"];
    private _newx = (_center select 0) + (_offset select 0);
    private _newy = (_center select 1) + (_offset select 1);
    private _newz = (_offset select 2);
    private _safePos = [[_newx, _newy, _newz], sizeOf "Land_Cargo_HQ_V1_F", ((2 * sizeOf "Land_Cargo_HQ_V1_F") + sizeOf _name), sizeOf _name, 0, 0.2, 0, TRGM_VAR_spawnedObjectsArray, [[_newx, _newy],[_newx, _newy]], _name] call TRGM_GLOBAL_fnc_findSafePos; // find a valid pos

    [_safePos, sizeOf _name] call TRGM_GLOBAL_fnc_hideTerrainObjects;
    private _helo = createVehicle [_name, _safePos, [], 0, "NONE"];
    createVehicleCrew _helo;
    crew vehicle _helo joinSilent createGroup WEST;
    _helo allowDamage false;
    _helo setpos _safePos;
    _helo setVelocity [0,0,0];
    _helo setPosASL [getPosASL _helo select 0, getPosASL _helo select 1, getTerrainHeightASL getPosASL _helo];
    _helo setdamage 0;
    _helo engineOn false;
    _helo lockDriver true;
    private _totalTurrets = [_name, true] call BIS_fnc_allTurrets;
    {_helo lockTurret [_x, true]} forEach _totalTurrets;
    { doStop _x; } forEach crew _helo;
    TRGM_VAR_spawnedObjectsArray pushBack [getPos _helo, sizeOf _name];
    _helo;
};

private _lightPositions = [[5.5,-5.5,0], [-5.5,3.5,0], [5.5,3.5,0], [-5.5,-5.5,0], [-2.75,-2.75,0], [-2.75,2.75,0], [2.75,2.75,0], [2.75,2.75,1]];
{
    ["Land_Camping_Light_F", _HQpos, _x, true] call _object_spawn;
} forEach _lightPositions;

terminal1 = ["Land_DataTerminal_01_F", _HQpos, [-1.1,2.7,0.6]] call _object_spawn;
terminal1 setdir 180;
terminal1 setVehicleVarName "terminal1";
publicVariable "terminal1";

_table = ["Land_CampingTable_white_F", _HQpos, [-1.1,3.1,0.6]] call _object_spawn;
_table setdir 180;

laptop1 = ["Land_Laptop_unfolded_F", _HQpos, [-1.6,2.8,1.6]] call _object_spawn;
laptop1 setdir 180;
laptop1 setVehicleVarName "laptop1";
publicVariable "laptop1";

baseRadio = ["Land_SatellitePhone_F", _HQpos, [-0.9,2.8,1.6]] call _object_spawn;
baseRadio setdir 360;
baseRadio setVehicleVarName "baseRadio";
publicVariable "baseRadio";

endMissionBoard = ["MapBoard_seismic_F", _HQpos, [-3.5,2.8,0.6]] call _object_spawn;
endMissionBoard setdir 315;
endMissionBoard setVehicleVarName "endMissionBoard";
[endMissionBoard, ["End Mission", "[] remoteExec [""TRGM_SERVER_fnc_endMission""];", [], 0, true, true, "", "_this isEqualTo player && leader group _this isEqualTo _this"]] remoteExec ["addAction", 0, true];
publicVariable "endMissionBoard";

endMissionBoard2 = createVehicle ["MapBoard_seismic_F",[0,0,0],[],0,"CAN_COLLIDE"];
endMissionBoard2 setPos [0,0,0];
endMissionBoard2 enableSimulation false;
endMissionBoard2 allowdamage false;
endMissionBoard2 setVehicleVarName "endMissionBoard2";
[endMissionBoard2, ["End Mission", "[] remoteExec [""TRGM_SERVER_fnc_endMission""];", [], 0, true, true, "", "_this isEqualTo player && leader group _this isEqualTo _this"]] remoteExec ["addAction", 0, true];
publicVariable "endMissionBoard2";

box1 = ["B_CargoNet_01_ammo_F", _HQpos, [4,1.5,0.6]] call _object_spawn;
box1 setdir 0;
box1 setVehicleVarName "box1";
publicVariable "box1";

medBuilding = ["Land_Medevac_house_V1_F", _HQpos, [-20,-20,0]] call _building_spawn;
medBuilding setVehicleVarName "medBuilding";
publicVariable "medBuilding";
sleep 5;

_repairBuilding = ["Land_RepairDepot_01_tan_F", _HQpos, [20,20,0]] call _building_spawn;
sleep 5;

chopper1 = ["B_Heli_Transport_03_unarmed_F", _HQpos, [-50,-50,0]] call _helo_spawn;
chopper1 setVehicleVarName "chopper1";
publicVariable "chopper1";
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
heliPad1 = createVehicle ["Land_HelipadCircle_F", [getPosASL chopper1 select 0, getPosASL chopper1 select 1, getTerrainHeightASL getPosASL chopper1], [], 0, "CAN_COLLIDE"];
heliPad1 allowdamage false;
heliPad1 setdamage 0;
heliPad1 setVehicleVarName "heliPad1";
publicVariable "heliPad1";
transportChopper = createMarker ["transportChopper", getPos chopper1];
"transportChopper" setMarkerShape "ICON";
"transportChopper" setMarkerType "b_air";
"transportChopper" setMarkerColor "ColorBlue";
"transportChopper" setMarkerText "Transport Chopper";
publicVariable "transportChopper";
sleep 5;

chopper2 = ["B_Heli_Attack_01_dynamicLoadout_F", _HQpos, [50,50,0]] call _helo_spawn;
chopper2 setVehicleVarName "chopper2";
publicVariable "chopper2";
chopper2D = driver chopper2;
chopper2D setVehicleVarName "chopper2D";
publicVariable "chopper2D";
airSupportHeliPad = createVehicle ["Land_HelipadCircle_F", [getPosASL chopper2 select 0, getPosASL chopper2 select 1, getTerrainHeightASL getPosASL chopper2], [], 0, "CAN_COLLIDE"];
airSupportHeliPad allowdamage false;
airSupportHeliPad setdamage 0;
airSupportHeliPad setVehicleVarName "airSupportHeliPad";
publicVariable "airSupportHeliPad";
chopper2 allowDamage true;
sleep 5;

supReq = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportRequester",[0,0,0],[],0,"CAN_COLLIDE"];
supReq setVehicleVarName "supReq";
supReq setVariable ['BIS_SUPP_custom_HQ',"HQMan",true];
supReq setVariable ['BIS_SUPP_limit_Artillery',"-1",true];
supReq setVariable ['BIS_SUPP_limit_CAS_Bombing',"-1",true];
supReq setVariable ['BIS_SUPP_limit_CAS_Heli',"-1",true];
supReq setVariable ['BIS_SUPP_limit_Drop',"-1",true];
supReq setVariable ['BIS_SUPP_limit_Transport',"-1",true];
supReq setVariable ['BIS_SUPP_limit_UAV',"-1",true];
supReq setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "supReq";

supReqAirSup = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportProvider_Virtual_CAS_Bombing",[0,0,200],[],0,"CAN_COLLIDE"];
supReqAirSup setVehicleVarName "supReqAirSup";
supReqAirSup setVariable ['BIS_SUPP_vehicles',"[]",true];
supReqAirSup setVariable ['BIS_SUPP_vehicleInit',"[_this] call TRGM_CLIENT_fnc_airSupportRequested",true];
supReqAirSup setVariable ['BIS_SUPP_filter',"Side",true];
supReqAirSup setVariable ['BIS_SUPP_cooldown',0,true];
supReqAirSup setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "supReqAirSup";

supReqAir = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportRequester",[0,0,200],[],0,"CAN_COLLIDE"];
supReqAir setVehicleVarName "supReqAir";
supReqAir setVariable ['BIS_SUPP_custom_HQ',"HQMan",true];
supReqAir setVariable ['BIS_SUPP_limit_Artillery',"-1",true];
supReqAir setVariable ['BIS_SUPP_limit_CAS_Bombing',"1",true];
supReqAir setVariable ['BIS_SUPP_limit_CAS_Heli',"-1",true];
supReqAir setVariable ['BIS_SUPP_limit_Drop',"-1",true];
supReqAir setVariable ['BIS_SUPP_limit_Transport',"-1",true];
supReqAir setVariable ['BIS_SUPP_limit_UAV',"-1",true];
supReqAir setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "supReqAir";

supReqSupDrop = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportProvider_Virtual_Drop",[0,0,200],[],0,"CAN_COLLIDE"];
supReqSupDrop setVehicleVarName "supReqSupDrop";
supReqSupDrop setVariable ['BIS_SUPP_vehicles',"[]",true];
supReqSupDrop setVariable ['BIS_SUPP_vehicleInit',"[_this] call TRGM_CLIENT_fnc_supplyDropVehInit",true];
supReqSupDrop setVariable ['BIS_SUPP_crateInit',"[_this] call TRGM_CLIENT_fnc_supplyDropCrateInit",true];
supReqSupDrop setVariable ['BIS_SUPP_filter',"Side",true];
supReqSupDrop setVariable ['BIS_SUPP_cooldown',0,true];
supReqSupDrop setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "supReqSupDrop";

supReqSupply = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportRequester",[0,0,200],[],0,"CAN_COLLIDE"];
supReqSupply setVehicleVarName "supReqSupply";
supReqSupply setVariable ['BIS_SUPP_custom_HQ',"HQMan",true];
supReqSupply setVariable ['BIS_SUPP_limit_Artillery',"-1",true];
supReqSupply setVariable ['BIS_SUPP_limit_CAS_Bombing',"-1",true];
supReqSupply setVariable ['BIS_SUPP_limit_CAS_Heli',"-1",true];
supReqSupply setVariable ['BIS_SUPP_limit_Drop',"-1",true];
supReqSupply setVariable ['BIS_SUPP_limit_Transport',"-1",true];
supReqSupply setVariable ['BIS_SUPP_limit_UAV',"-1",true];
supReqSupply setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "supReqSupply";

supReqTrans = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportProvider_Transport",[0,0,0],[],0,"CAN_COLLIDE"];
supReqTrans setPos getPos chopper1;
supReqTrans setVehicleVarName "supReqTrans";
supReqTrans setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "supReqTrans";

SupProArti = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["SupportProvider_Virtual_Artillery",[0,0,0],[],0,"CAN_COLLIDE"];
SupProArti setVehicleVarName "SupProArti";
SupProArti setVariable ['BIS_SUPP_vehicles',"[]",true];
SupProArti setVariable ['BIS_SUPP_vehicleInit',"[_this] call TRGM_CLIENT_fnc_supportArtiRequested",true];
SupProArti setVariable ['BIS_SUPP_filter',"Side",true];
SupProArti setVariable ['BIS_SUPP_cooldown',0,true];
SupProArti setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
publicVariable "SupProArti";

chopper1 synchronizeObjectsAdd [supReqTrans];         supReqTrans synchronizeObjectsAdd [chopper1];
supReqAirSup synchronizeObjectsAdd [supReqAir];     supReqAir synchronizeObjectsAdd [supReqAirSup];
supReqSupDrop synchronizeObjectsAdd [supReqSupply]; supReqSupply synchronizeObjectsAdd [supReqSupDrop];
SupProArti synchronizeObjectsAdd [supReq];             supReq synchronizeObjectsAdd [SupProArti];

TRGM_VAR_NeededObjectsAvailable = true; publicVariable "TRGM_VAR_NeededObjectsAvailable";