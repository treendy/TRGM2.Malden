format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

//hardcoded for now... see notes in root setunitglobalvars.sqf (main git/malden version of this sqf!)
TRGM_VAR_DefaultEnemyFactionValue    = [2]; publicVariable "TRGM_VAR_DefaultEnemyFactionValue";    //default to FIA
TRGM_VAR_DefaultMilitiaFactionValue  = [1]; publicVariable "TRGM_VAR_DefaultMilitiaFactionValue";  //default to AAF
TRGM_VAR_DefaultFriendlyFactionValue = [1]; publicVariable "TRGM_VAR_DefaultFriendlyFactionValue"; //default to NATO

/////// Custom Mission Init ///////
// _CustomMissionEnabled = (["CustomMission", 0] call BIS_fnc_getParamValue) isEqualTo 1;
// _MissionTitle         = "";
// if (_CustomMissionEnabled) then {
// 	call compile preprocessFileLineNumbers "CustomMission\customMission.sqf";
// };
// call MISSION_fnc_CustomVars;

/////// Set up faction arrays ///////
// TRGM_VAR_WestFactionData --- Initialized in initGlobalVars
// TRGM_VAR_EastFactionData --- Initialized in initGlobalVars
// TRGM_VAR_GuerFactionData --- Initialized in initGlobalVars
// TRGM_VAR_AllFactionData --- Initialized in initGlobalVars

TRGM_VAR_DefaultEnemyFactionArray        = []; publicVariable "TRGM_VAR_DefaultEnemyFactionArray";
TRGM_VAR_DefaultEnemyFactionArrayText    = []; publicVariable "TRGM_VAR_DefaultEnemyFactionArrayText";
TRGM_VAR_DefaultMilitiaFactionArray      = []; publicVariable "TRGM_VAR_DefaultMilitiaFactionArray";
TRGM_VAR_DefaultMilitiaFactionArrayText  = []; publicVariable "TRGM_VAR_DefaultMilitiaFactionArrayText";
TRGM_VAR_DefaultFriendlyFactionArray     = []; publicVariable "TRGM_VAR_DefaultFriendlyFactionArray";
TRGM_VAR_DefaultFriendlyFactionArrayText = []; publicVariable "TRGM_VAR_DefaultFriendlyFactionArrayText";

for "_i" from 0 to (count TRGM_VAR_AllFactionData - 1) do {
	(TRGM_VAR_AllFactionData select _i) params ["_className", "_displayName"];
	TRGM_VAR_DefaultFriendlyFactionArrayText pushBack _displayName;
	TRGM_VAR_DefaultFriendlyFactionArray pushBack _i;
	if (_className isEqualTo "BLU_F") then {
		TRGM_VAR_DefaultFriendlyFactionValue = [_i]; publicVariable "TRGM_VAR_DefaultFriendlyFactionValue";
	};
};

for "_i" from 0 to (count TRGM_VAR_AllFactionData - 1) do {
	(TRGM_VAR_AllFactionData select _i) params ["_className", "_displayName"];
	TRGM_VAR_DefaultEnemyFactionArrayText pushBack _displayName;
	TRGM_VAR_DefaultEnemyFactionArray pushBack _i;
	if (_className isEqualTo "OPF_F") then {
		TRGM_VAR_DefaultEnemyFactionValue = [_i]; publicVariable "TRGM_VAR_DefaultEnemyFactionValue";
	};
};

for "_i" from 0 to (count TRGM_VAR_AllFactionData - 1) do {
	(TRGM_VAR_AllFactionData select _i) params ["_className", "_displayName"];
	TRGM_VAR_DefaultMilitiaFactionArrayText pushBack _displayName;
	TRGM_VAR_DefaultMilitiaFactionArray pushBack _i;
	if (_className isEqualTo "IND_G_F") then {
		TRGM_VAR_DefaultMilitiaFactionValue = [_i]; publicVariable "TRGM_VAR_DefaultMilitiaFactionValue";
	};
};

publicVariable "TRGM_VAR_DefaultFriendlyFactionArrayText";
publicVariable "TRGM_VAR_DefaultFriendlyFactionArray";
publicVariable "TRGM_VAR_DefaultEnemyFactionArrayText";
publicVariable "TRGM_VAR_DefaultEnemyFactionArray";
publicVariable "TRGM_VAR_DefaultMilitiaFactionArrayText";
publicVariable "TRGM_VAR_DefaultMilitiaFactionArray";

//example: TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_ENEMY_FACTIONS_IDX
TRGM_VAR_ADVSET_VIRTUAL_ARSENAL_IDX              = 0;  publicVariable "TRGM_VAR_ADVSET_VIRTUAL_ARSENAL_IDX";
TRGM_VAR_ADVSET_GROUP_NAME_IDX                   = 1;  publicVariable "TRGM_VAR_ADVSET_GROUP_NAME_IDX";
TRGM_VAR_ADVSET_SUPPORT_OPTION_IDX               = 2;  publicVariable "TRGM_VAR_ADVSET_SUPPORT_OPTION_IDX";
TRGM_VAR_ADVSET_RESPAWN_TICKET_COUNT_IDX         = 3;  publicVariable "TRGM_VAR_ADVSET_RESPAWN_TICKET_COUNT_IDX";
TRGM_VAR_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX         = 4;  publicVariable "TRGM_VAR_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX";
TRGM_VAR_ADVSET_RESPAWN_TIMER_IDX                = 5;  publicVariable "TRGM_VAR_ADVSET_RESPAWN_TIMER_IDX";
TRGM_VAR_ADVSET_ENEMY_FACTIONS_IDX               = 6;  publicVariable "TRGM_VAR_ADVSET_ENEMY_FACTIONS_IDX";
TRGM_VAR_ADVSET_MILITIA_FACTIONS_IDX             = 7;  publicVariable "TRGM_VAR_ADVSET_MILITIA_FACTIONS_IDX";
TRGM_VAR_ADVSET_FRIENDLY_FACTIONS_IDX            = 8;  publicVariable "TRGM_VAR_ADVSET_FRIENDLY_FACTIONS_IDX";
TRGM_VAR_ADVSET_SANDSTORM_IDX                    = 9;  publicVariable "TRGM_VAR_ADVSET_SANDSTORM_IDX";
TRGM_VAR_ADVSET_GROUP_MANAGE_IDX                 = 10; publicVariable "TRGM_VAR_ADVSET_GROUP_MANAGE_IDX";
TRGM_VAR_ADVSET_SELECT_AO_IDX                    = 11; publicVariable "TRGM_VAR_ADVSET_SELECT_AO_IDX";
TRGM_VAR_ADVSET_SELECT_AO_CAMP_IDX               = 12; publicVariable "TRGM_VAR_ADVSET_SELECT_AO_CAMP_IDX";
TRGM_VAR_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX     = 13; publicVariable "TRGM_VAR_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX";
TRGM_VAR_ADVSET_MINIMISSIONS_IDX                 = 14; publicVariable "TRGM_VAR_ADVSET_MINIMISSIONS_IDX";
TRGM_VAR_ADVSET_IEDTARGET_COMPACT_SPACING_IDX    = 15; publicVariable "TRGM_VAR_ADVSET_IEDTARGET_COMPACT_SPACING_IDX";
TRGM_VAR_ADVSET_HIGHER_ENEMY_COUNT_IDX           = 16; publicVariable "TRGM_VAR_ADVSET_HIGHER_ENEMY_COUNT_IDX";
TRGM_VAR_ADVSET_LARGE_PATROLS_IDX                = 17; publicVariable "TRGM_VAR_ADVSET_LARGE_PATROLS_IDX";
TRGM_VAR_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX     = 18; publicVariable "TRGM_VAR_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX";
TRGM_VAR_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX = 19; publicVariable "TRGM_VAR_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX";

/////// Advanced Settings Set up ///////
//NOTE the id's must go up in twos!
#define ADVCTRLIDC(IDX) 6001 + (2 * IDX)
TRGM_VAR_AdvControls = [ //IDX,Title,Type,Options,OptionValues,DefaultOptionIndex(zero based index)
	[ADVCTRLIDC(TRGM_VAR_ADVSET_VIRTUAL_ARSENAL_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_VirtualArsenal","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvVirtualArsenal"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_GROUP_NAME_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupName","RscEdit",[""],"","",localize "STR_TRGM2_Tooltip_AdvGroupName"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_SUPPORT_OPTION_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_SupportOptions","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_RESPAWN_TICKET_COUNT_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTickets","RscCombo",["1","2","3","4","5","6","7","8","9","10",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Unlimited"],[1,2,3,4,5,6,7,8,9,10,99999],0,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_Mapdraw","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0,localize "STR_TRGM2_Tooltip_AdvMapDraw"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_RESPAWN_TIMER_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTimer","RscCombo",["5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","30 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","1 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","20 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min"],[5,10,30,60,300,600,1200],1,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_ENEMY_FACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFactions","RscCombo",TRGM_VAR_DefaultEnemyFactionArrayText,TRGM_VAR_DefaultEnemyFactionArray,TRGM_VAR_DefaultEnemyFactionValue select 0,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_MILITIA_FACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MilitiaFactions","RscCombo",TRGM_VAR_DefaultMilitiaFactionArrayText,TRGM_VAR_DefaultMilitiaFactionArray,TRGM_VAR_DefaultMilitiaFactionValue select 0,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_FRIENDLY_FACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_FriendlyFactions","RscCombo",TRGM_VAR_DefaultFriendlyFactionArrayText,TRGM_VAR_DefaultFriendlyFactionArray,TRGM_VAR_DefaultFriendlyFactionValue select 0,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_SANDSTORM_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_Always",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Never",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_5Hours"],[0,1,2,3],2,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_GROUP_MANAGE_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupManagement","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvGroupManagement"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_SELECT_AO_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainAOSelect","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvAoSelect"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_SELECT_AO_CAMP_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainAO_CAMP_Select","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvCampStart"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFlashLights","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],0,""],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_MINIMISSIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MiniMissions","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvMinimission"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_IEDTARGET_COMPACT_SPACING_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_IedTargetCompact","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvIedTargetCompact"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_HIGHER_ENEMY_COUNT_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoreEnemies","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvMoreEnemies"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_LARGE_PATROLS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_LargePatrols","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],1,localize "STR_TRGM2_Tooltip_AdvLargePatrols"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_TimeBetweenSpotted","RscXSliderH",600,1800,1200,localize "STR_TRGM2_Tooltip_TimeBetweenSpotted"],
	[ADVCTRLIDC(TRGM_VAR_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_VehicleReqRep","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Disable", localize "STR_TRGM2_TRGMInitPlayerLocal_Enable"],[0,1],0,localize "STR_TRGM2_Tooltip_AdvVehicleReqRep"]
];
publicVariable "TRGM_VAR_AdvControls";

TRGM_VAR_DefaultAdvancedSettings = [];
{
	_defaultValue = _x select 5;
	TRGM_VAR_DefaultAdvancedSettings pushBack _defaultValue;
} forEach TRGM_VAR_AdvControls;
publicVariable "TRGM_VAR_DefaultAdvancedSettings";


/*DONT FORGET TO ADD THIS TO fn_openDialogMissionselection.sqf
if (count TRGM_VAR_AdvControls < 14) then {
	TRGM_VAR_AdvControls pushBack (TRGM_VAR_DefaultAdvancedSettings select 13);
};
*/

/////// Sandstorm settings ///////
if (isNil "TRGM_VAR_DefaultSandStormOption") then { TRGM_VAR_DefaultSandStormOption = 2; publicVariable "TRGM_VAR_DefaultSandStormOption"; };
TRGM_GETTER_fnc_sandStormOption = { TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_SANDSTORM_IDX };
publicVariable "TRGM_GETTER_fnc_sandStormOption";

/////// Patrol settings ///////
if (isNil "TRGM_VAR_iAllowLargePat") then { TRGM_VAR_iAllowLargePat =  1; publicVariable "TRGM_VAR_iAllowLargePat"; }; //("OUT_par_AllowLargePatrols" call BIS_fnc_getParamValue);
TRGM_GETTER_fnc_bAllowLargerPatrols = { [random 1 < .33, true, false] select (TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_LARGE_PATROLS_IDX)};
publicVariable "TRGM_GETTER_fnc_bAllowLargerPatrols";

/////// Higher Enemy Count ///////
TRGM_GETTER_fnc_bMoreEnemies = { ( (TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_HIGHER_ENEMY_COUNT_IDX isEqualTo 1) || (TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_HIGHER_ENEMY_COUNT_IDX isEqualTo 0 && random 1 < .25) ); };
publicVariable "TRGM_GETTER_fnc_bMoreEnemies";

//////// Vehicle Spawning Rep Requirement ///////
TRGM_GETTER_fnc_bVehiclesRequireRep = { TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX isEqualTo 1; };
publicVariable "TRGM_GETTER_fnc_bVehiclesRequireRep";

//////// Spotted Delay ///////
TRGM_GETTER_fnc_iGetSpottedDelay = { TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX };
publicVariable "TRGM_GETTER_fnc_iGetSpottedDelay";

//////// Manual AO Placement ///////
TRGM_GETTER_fnc_bManualAOPlacement = { TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_SELECT_AO_IDX isEqualTo 1 };
publicVariable "TRGM_GETTER_fnc_bManualAOPlacement";

//////// Manual Camp Placement ///////
TRGM_GETTER_fnc_bManualCampPlacement = { TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_SELECT_AO_CAMP_IDX isEqualTo 1 };
publicVariable "TRGM_GETTER_fnc_bManualCampPlacement";

/////// Revive Settings Set up ///////
//0 = no, 1 = guarantee revive, 2 = realistic revive, 3 = realistic revive (only medics can revive)

if (isNil "TRGM_VAR_iUseRevive") then { TRGM_VAR_iUseRevive =  0; publicVariable "TRGM_VAR_iUseRevive"; };
if (TRGM_VAR_iUseRevive isEqualTo 0) then {
	TRGM_VAR_bUseRevive = false; publicVariable "TRGM_VAR_bUseRevive";
}
else
{
	TRGM_VAR_bUseRevive = true; publicVariable "TRGM_VAR_bUseRevive";
};


/////// Building arrays init ///////

TRGM_VAR_BasicBuildings = [];
"if (configName _x find 'Land_' isEqualTo 0 && {configName _x isKindOf 'Building' && {getnumber (_x >> 'numberOfDoors')  >= 1 or !(getarray (_x >> 'Ladders')  isEqualTo [])}}) then {TRGM_VAR_BasicBuildings pushBack configName _x}" configClasses (configFile >> "CfgVehicles") apply {configName _x};
publicVariable "TRGM_VAR_BasicBuildings";

TRGM_VAR_MilBuildings   = [];
"if (configName _x find 'Land_' isEqualTo 0 && {configName _x isKindOf 'Building' && {(getnumber (_x >> 'numberOfDoors')  >= 1 or !(getarray (_x >> 'Ladders')  isEqualTo [])) && {getText( configFile >> 'CfgEditorSubCategories' >> getText( _x >> 'editorSubcategory' ) >> 'displayName' ) isEqualTo 'Military'}}}) then {TRGM_VAR_MilBuildings pushBack configName _x}" configClasses (configFile >> "CfgVehicles") apply {configName _x};
publicVariable "TRGM_VAR_MilBuildings";

TRGM_VAR_TowerBuildings = ["Land_TTowerBig_2_F","Land_TTowerBig_1_F (towertest)","land_Objects96","Land_wx_radiomast","LAND_uns_signaltower","rso_radiomast"];//,"Land_TTowerSmall_2_F","Land_TTowerSmall_1_F"];  //these small towers are too small for Altis or Malden.. looks strange if this is the comms tower and nearby is a massive unused tower
publicVariable "TRGM_VAR_TowerBuildings";

/////// Weather settings set up ///////
if (isNil "TRGM_VAR_iWeather")         then { TRGM_VAR_iWeather =  1;             publicVariable "TRGM_VAR_iWeather"; };
if (isNil "TRGM_VAR_UseEditorWeather") then { TRGM_VAR_UseEditorWeather =  false; publicVariable "TRGM_VAR_UseEditorWeather"; };

TRGM_GETTER_fnc_aWeatherOption = {
	_weatherOption = [TRGM_VAR_iWeather];
	switch (TRGM_VAR_iWeather) do {
		case 0:  { _weatherOption = [1,2,3];};
		case 99: { _weatherOption = [TRGM_VAR_iWeather]; TRGM_VAR_UseEditorWeather =  true; publicVariable "TRGM_VAR_UseEditorWeather"; };
		default  { _weatherOption = [TRGM_VAR_iWeather]; };
	};
	selectRandom _weatherOption;
}; publicVariable "TRGM_GETTER_fnc_aWeatherOption";

/////// Time settings set up ///////
//[hour,min]
if (isNil "TRGM_VAR_arrayTime")                                      then { TRGM_VAR_arrayTime =  [8, 15]; publicVariable "TRGM_VAR_arrayTime"; };

/////// Minefield settings ///////
if (isNil "TRGM_VAR_iAllowMineField")                                then { TRGM_VAR_iAllowMineField =  0; publicVariable "TRGM_VAR_iAllowMineField"; };
TRGM_VAR_AllowMineField = (TRGM_VAR_iAllowMineField isEqualTo 1); publicVariable "TRGM_VAR_AllowMineField";

/////// Civ/Ins settings ///////
if (isNil "TRGM_VAR_iBuildingCountToAllowCivsAndFriendlyInformants") then { TRGM_VAR_iBuildingCountToAllowCivsAndFriendlyInformants =  10; publicVariable "TRGM_VAR_iBuildingCountToAllowCivsAndFriendlyInformants"; };
if (isNil "TRGM_VAR_bFriendlyInsurgents")                            then { TRGM_VAR_bFriendlyInsurgents =  [false,true,false,false]; publicVariable "TRGM_VAR_bFriendlyInsurgents"; };
if (isNil "TRGM_VAR_bCivsOnly")                                      then { TRGM_VAR_bCivsOnly =  [false,false,false,false,false,false]; publicVariable "TRGM_VAR_bCivsOnly"; }; //all false at the moment... may never use this, but keep incase have idea!

/////// Punish settings ///////
if (isNil "TRGM_VAR_PunishmentTimer")                                then { TRGM_VAR_PunishmentTimer =  1200; publicVariable "TRGM_VAR_PunishmentTimer"; };
if (isNil "TRGM_VAR_PunishmentRadius")                               then { TRGM_VAR_PunishmentRadius =  1000; publicVariable "TRGM_VAR_PunishmentRadius"; }; //if 0 will be no safezone

/////// Mini mission and intel settings ///////
if (isNil "TRGM_VAR_ChanceOfOccurance")                              then { TRGM_VAR_ChanceOfOccurance =  [true,false,false,false,false]; publicVariable "TRGM_VAR_ChanceOfOccurance"; };  //downed chopper, medical emergancy, downed convoy, etc...
TRGM_VAR_IntelShownType = [1,2,3,4,5]; publicVariable "TRGM_VAR_IntelShownType";  // 1=Mortar    2=AAA    3=commsTower    4=checkpoints    5=ATMinefield
if (isNil "TRGM_VAR_TowerRadius")                                    then { TRGM_VAR_TowerRadius =  3500; publicVariable "TRGM_VAR_TowerRadius"; };

/////// Artillery offsets ///////
if (isNil "TRGM_VAR_GridXOffSet")                                    then { TRGM_VAR_GridXOffSet =  0; publicVariable "TRGM_VAR_GridXOffSet"; };  //to work this out, get vector21, mark pos at [0,0], the number for the X or Y is the offset, as it should be zero, so if not, we need to use this as an offset
if (isNil "TRGM_VAR_GridYOffSet")                                    then { TRGM_VAR_GridYOffSet =  0; publicVariable "TRGM_VAR_GridYOffSet"; };


/////// Mission parameters set up ///////
TRGM_VAR_MissionTypeDescriptions = [
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions1",  //Heavy Mission (with two optional sides)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions1b", //Heavy Mission (two hidden optional sides)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions1c", //Heavy Mission (two objectives at AO, chance of side)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions2",  //Heavy Mission (Intel required for AO Location)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions3",  //Heavy Mission Only
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions4",  //Single Mission
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions4b", //Single Mission (two objectives at AO, chance of side)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions5",  //Three Missions
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions5b", //Three Hidden Missions
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions7",  //Heavy mission (Hidden, full map)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions11", //Three Heavy Missions
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions12", //Three Heavy Missions (Hidden, full map)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions6"   //Campaign
];
publicVariable "TRGM_VAR_MissionTypeDescriptions";
// 0  = Heavy Mission (with two optional sides)
// 6  = Heavy Mission (two hidden optional sides)
// 8  = Heavy Mission (two objectives at AO, chance of side)
// 1  = Heavy Mission (Intel required for AO Location)
// 2  = Heavy Mission Only
// 3  = Single Mission
// 9  = Single Mission (two objectives at AO, chance of side)
// 4  = Three Missions
// 7  = Three Hidden Missions
// 10 = Heavy full map hidden mission
// 11 = Three heavy missions
// 12 = Three hidden heavy missions, full map
// 5  = Campaign

TRGM_VAR_MissionParamTypes = [
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName1",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName1b",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName1c",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName2",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName3",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName4",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName4b",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName5",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName5b",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName7",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName11",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName12",
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName6"
];
publicVariable "TRGM_VAR_MissionParamTypes";
TRGM_VAR_MissionParamTypesValues = [0,6,8,1,2,3,9,4,7,10,11,12,5]; publicVariable "TRGM_VAR_MissionParamTypesValues";


// 1  = Laptop
// 2  = Steal data from research vehicle
// 3  = Destroy Ammo Trucks
// 4  = Speak with informant
// 5  = interrogate officer
// 6  = Bug Radio
// 7  = Eliminate Officer
// 8  = Assasinate weapon dealer
// 9  = Destroy AAA vehicles
// 10 = Destroy Artillery vehicles
// 11 = Resue POW
// 12 = Resue Reporter
// 13 = Defuse IEDs
// 14 = BombMission
// 15 = TargetMission
// 16 = Destroy Cache
// 17 = Secure and Supply
// 18 = Meeting Assassination
// 19 = Convoy Ambush
// 99999 = CustomMission

/*
Add new misions to TRGM_VAR_MissionParamObjectives/TRGM_VAR_MissionParamObjectivesValues via pushBack,
but also add to the TRGM_VAR_SideMissionTasks, TRGM_VAR_MainMissionTasks and/or TRGM_VAR_MissionsThatHaveIntel (othrwise, wont be included in random selction or campaign)
Also, add new missions as cases in functions/mission/fn_startInfMission.sqf
*/

// TRGM_VAR_SideMissionTasks   = [17]; publicVariable "TRGM_VAR_SideMissionTasks";
TRGM_VAR_SideMissionTasks      = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]; publicVariable "TRGM_VAR_SideMissionTasks";
// TRGM_VAR_MainMissionTasks   = [17]; publicVariable "TRGM_VAR_MainMissionTasks";
TRGM_VAR_MainMissionTasks      = [1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]; publicVariable "TRGM_VAR_MainMissionTasks";
TRGM_VAR_MissionsThatHaveIntel = [1, 4, 5, 6]; publicVariable "TRGM_VAR_MissionsThatHaveIntel";

TRGM_VAR_MissionParamObjectives       = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_startInfMission_MissionTitle1", localize "STR_TRGM2_startInfMission_MissionTitle2", localize "STR_TRGM2_startInfMission_MissionTitle3", localize "STR_TRGM2_startInfMission_MissionTitle4", localize "STR_TRGM2_startInfMission_MissionTitle5", localize "STR_TRGM2_startInfMission_MissionTitle6", localize "STR_TRGM2_startInfMission_MissionTitle7", localize "STR_TRGM2_startInfMission_MissionTitle8", localize "STR_TRGM2_startInfMission_MissionTitle9", localize "STR_TRGM2_startInfMission_MissionTitle10", localize "STR_TRGM2_startInfMission_MissionTitle11", localize "STR_TRGM2_startInfMission_MissionTitle12"];
TRGM_VAR_MissionParamObjectivesValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

TRGM_VAR_MissionParamObjectives       pushBack "Defuse IEDs";
TRGM_VAR_MissionParamObjectivesValues pushBack 13;

TRGM_VAR_MissionParamObjectives       pushBack localize "STR_TRGM2_BombMissionTitle";
TRGM_VAR_MissionParamObjectivesValues pushBack 14;

TRGM_VAR_MissionParamObjectives       pushBack localize "STR_TRGM2_TargetMissionTitle";
TRGM_VAR_MissionParamObjectivesValues pushBack 15;

TRGM_VAR_MissionParamObjectives       pushBack localize "STR_TRGM2_CacheMissionTitle";
TRGM_VAR_MissionParamObjectivesValues pushBack 16;

TRGM_VAR_MissionParamObjectives       pushBack localize "STR_TRGM2_ClearAreaMissionTitle";
TRGM_VAR_MissionParamObjectivesValues pushBack 17;

TRGM_VAR_MissionParamObjectives       pushBack localize "STR_TRGM2_MeetingAssassinationMissionTitle";
TRGM_VAR_MissionParamObjectivesValues pushBack 18;

TRGM_VAR_MissionParamObjectives       pushBack "Ambush Convoy";
TRGM_VAR_MissionParamObjectivesValues pushBack 19;

// if (_CustomMissionEnabled) then {
// 	TRGM_VAR_MissionParamObjectives       pushBack _MissionTitle;
// 	TRGM_VAR_MissionParamObjectivesValues pushBack 99999;
// };

publicVariable "TRGM_VAR_MissionParamObjectives";
publicVariable "TRGM_VAR_MissionParamObjectivesValues";


TRGM_VAR_MissionParamRepOptions            = [localize "STR_TRGM2_TRGMInitPlayerLocal_Enable", localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"]; publicVariable "TRGM_VAR_MissionParamRepOptions";
TRGM_VAR_MissionParamRepOptionsValues      = [1, 0]; publicVariable "TRGM_VAR_MissionParamRepOptionsValues";

TRGM_VAR_MissionParamWeatherOptions        = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Clear", localize "STR_TRGM2_TRGMSetUnitGlobalVars_HeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_AverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Realistic", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Monsoon", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Snowstorm", localize "STR_TRGM2_TRGMSetUnitGlobalVars_UseEditorWeather"]; publicVariable "TRGM_VAR_MissionParamWeatherOptions";
TRGM_VAR_MissionParamWeatherOptionsValues  = [0, 1, 2, 3, 4, 31, 41, 99]; publicVariable "TRGM_VAR_MissionParamWeatherOptionsValues";

TRGM_VAR_MissionParamNVGOptions            =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Real", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Allow", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_NoAllow"]; publicVariable "TRGM_VAR_MissionParamNVGOptions";
TRGM_VAR_MissionParamNVGOptionsValues      =  [2,1,0]; publicVariable "TRGM_VAR_MissionParamNVGOptionsValues";

TRGM_VAR_MissionParamReviveOptions         =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_No", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Guarantee", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real1", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real2", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real3", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real4"]; publicVariable "TRGM_VAR_MissionParamReviveOptions";
TRGM_VAR_MissionParamReviveOptionsValues   =  [0,1,2,3,4,5]; publicVariable "TRGM_VAR_MissionParamReviveOptionsValues";

TRGM_VAR_MissionParamLocationOptions       =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NearAO", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainHQ"]; publicVariable "TRGM_VAR_MissionParamLocationOptions";
TRGM_VAR_MissionParamLocationOptionsValues =  [2,1,0]; publicVariable "TRGM_VAR_MissionParamLocationOptionsValues";

TRGM_VAR_FastResponseCarItems              = [[[["arifle_SDAR_F"],[10]],[["20Rnd_556x45_UW_mag"],[20]],[["G_B_Diving","V_RebreatherB","U_B_Wetsuit"],[10,10,10]],[[],[]]],false]; publicVariable "TRGM_VAR_FastResponseCarItems";

if (isNil "TRGM_VAR_AreasBlackList") then { TRGM_VAR_AreasBlackList =  []; publicVariable "TRGM_VAR_AreasBlackList"; };
if (!isNil "TRGM_VAR_TopLeftPos")    then {
	TRGM_VAR_AreaLeft       = [[(TRGM_VAR_TopLeftPos select 0)-5000,TRGM_VAR_TopLeftPos select 1,0],[TRGM_VAR_TopLeftPos select 0,TRGM_VAR_BotRightPos select 1,0]];
	TRGM_VAR_AreaRight      = [[TRGM_VAR_BotRightPos select 0,TRGM_VAR_TopLeftPos select 1,0],[(TRGM_VAR_BotRightPos select 0) +5000,TRGM_VAR_BotRightPos select 1,0]];
	TRGM_VAR_AreaTop        = [[(TRGM_VAR_TopLeftPos select 0)-5000,(TRGM_VAR_TopLeftPos select 1)+5000,0],[(TRGM_VAR_BotRightPos select 0) +5000,TRGM_VAR_TopLeftPos select 1,0]];
	TRGM_VAR_AreaBottom     = [[(TRGM_VAR_TopLeftPos select 0)-5000,TRGM_VAR_BotRightPos select 1,0],[(TRGM_VAR_BotRightPos select 0) +5000,(TRGM_VAR_BotRightPos select 1)-5000,0]];
	TRGM_VAR_AreasBlackList = [TRGM_VAR_AreaLeft,TRGM_VAR_AreaRight,TRGM_VAR_AreaTop,TRGM_VAR_AreaBottom]; publicVariable "TRGM_VAR_AreasBlackList";
};

true;