format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

//hardcoded for now... see notes in root setunitglobalvars.sqf (main git/malden version of this sqf!)
TREND_DefaultEnemyFactionValue    = [2]; publicVariable "TREND_DefaultEnemyFactionValue";    //default to FIA
TREND_DefaultMilitiaFactionValue  = [1]; publicVariable "TREND_DefaultMilitiaFactionValue";  //default to AAF
TREND_DefaultFriendlyFactionValue = [1]; publicVariable "TREND_DefaultFriendlyFactionValue"; //default to NATO

/////// Custom Mission Init ///////
// _CustomMissionEnabled = (["CustomMission", 0] call BIS_fnc_getParamValue) isEqualTo 1;
// _MissionTitle         = "";
// if (_CustomMissionEnabled) then {
// 	call compile preprocessFileLineNumbers "CustomMission\customMission.sqf";
// };
// call fnc_CustomVars;

/////// Set up faction arrays ///////
// TREND_WestFactionData --- Initialized in initGlobalVars
// TREND_EastFactionData --- Initialized in initGlobalVars
// TREND_GuerFactionData --- Initialized in initGlobalVars
// TREND_AllFactionData --- Initialized in initGlobalVars

TREND_DefaultEnemyFactionArray        = []; publicVariable "TREND_DefaultEnemyFactionArray";
TREND_DefaultEnemyFactionArrayText    = []; publicVariable "TREND_DefaultEnemyFactionArrayText";
TREND_DefaultMilitiaFactionArray      = []; publicVariable "TREND_DefaultMilitiaFactionArray";
TREND_DefaultMilitiaFactionArrayText  = []; publicVariable "TREND_DefaultMilitiaFactionArrayText";
TREND_DefaultFriendlyFactionArray     = []; publicVariable "TREND_DefaultFriendlyFactionArray";
TREND_DefaultFriendlyFactionArrayText = []; publicVariable "TREND_DefaultFriendlyFactionArrayText";

for "_i" from 0 to (count TREND_AllFactionData - 1) do {
	(TREND_AllFactionData select _i) params ["_className", "_displayName"];
	TREND_DefaultFriendlyFactionArrayText pushBack _displayName;
	TREND_DefaultFriendlyFactionArray pushBack _i;
	if (_className isEqualTo "BLU_F") then {
		TREND_DefaultFriendlyFactionValue = [_i]; publicVariable "TREND_DefaultFriendlyFactionValue";
	};
};

for "_i" from 0 to (count TREND_AllFactionData - 1) do {
	(TREND_AllFactionData select _i) params ["_className", "_displayName"];
	TREND_DefaultEnemyFactionArrayText pushBack _displayName;
	TREND_DefaultEnemyFactionArray pushBack _i;
	if (_className isEqualTo "OPF_F") then {
		TREND_DefaultEnemyFactionValue = [_i]; publicVariable "TREND_DefaultEnemyFactionValue";
	};
};

for "_i" from 0 to (count TREND_AllFactionData - 1) do {
	(TREND_AllFactionData select _i) params ["_className", "_displayName"];
	TREND_DefaultMilitiaFactionArrayText pushBack _displayName;
	TREND_DefaultMilitiaFactionArray pushBack _i;
	if (_className isEqualTo "IND_G_F") then {
		TREND_DefaultMilitiaFactionValue = [_i]; publicVariable "TREND_DefaultMilitiaFactionValue";
	};
};

publicVariable "TREND_DefaultFriendlyFactionArrayText";
publicVariable "TREND_DefaultFriendlyFactionArray";
publicVariable "TREND_DefaultEnemyFactionArrayText";
publicVariable "TREND_DefaultEnemyFactionArray";
publicVariable "TREND_DefaultMilitiaFactionArrayText";
publicVariable "TREND_DefaultMilitiaFactionArray";

//example: TREND_AdvancedSettings select TREND_ADVSET_ENEMY_FACTIONS_IDX
TREND_ADVSET_VIRTUAL_ARSENAL_IDX              = 0;  publicVariable "TREND_ADVSET_VIRTUAL_ARSENAL_IDX";
TREND_ADVSET_GROUP_NAME_IDX                   = 1;  publicVariable "TREND_ADVSET_GROUP_NAME_IDX";
TREND_ADVSET_SUPPORT_OPTION_IDX               = 2;  publicVariable "TREND_ADVSET_SUPPORT_OPTION_IDX";
TREND_ADVSET_RESPAWN_TICKET_COUNT_IDX         = 3;  publicVariable "TREND_ADVSET_RESPAWN_TICKET_COUNT_IDX";
TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX         = 4;  publicVariable "TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX";
TREND_ADVSET_RESPAWN_TIMER_IDX                = 5;  publicVariable "TREND_ADVSET_RESPAWN_TIMER_IDX";
TREND_ADVSET_ENEMY_FACTIONS_IDX               = 6;  publicVariable "TREND_ADVSET_ENEMY_FACTIONS_IDX";
TREND_ADVSET_MILITIA_FACTIONS_IDX             = 7;  publicVariable "TREND_ADVSET_MILITIA_FACTIONS_IDX";
TREND_ADVSET_FRIENDLY_FACTIONS_IDX            = 8;  publicVariable "TREND_ADVSET_FRIENDLY_FACTIONS_IDX";
TREND_ADVSET_SANDSTORM_IDX                    = 9;  publicVariable "TREND_ADVSET_SANDSTORM_IDX";
TREND_ADVSET_GROUP_MANAGE_IDX                 = 10; publicVariable "TREND_ADVSET_GROUP_MANAGE_IDX";
TREND_ADVSET_SELECT_AO_IDX                    = 11; publicVariable "TREND_ADVSET_SELECT_AO_IDX";
TREND_ADVSET_SELECT_AO_CAMP_IDX               = 12; publicVariable "TREND_ADVSET_SELECT_AO_CAMP_IDX";
TREND_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX     = 13; publicVariable "TREND_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX";
TREND_ADVSET_MINIMISSIONS_IDX                 = 14; publicVariable "TREND_ADVSET_MINIMISSIONS_IDX";
TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX    = 15; publicVariable "TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX";
TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX           = 16; publicVariable "TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX";
TREND_ADVSET_LARGE_PATROLS_IDX                = 17; publicVariable "TREND_ADVSET_LARGE_PATROLS_IDX";
TREND_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX     = 18; publicVariable "TREND_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX";
TREND_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX = 19; publicVariable "TREND_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX";

/////// Advanced Settings Set up ///////
//NOTE the id's must go up in twos!
#define AdvCtrlIDC(IDX) 6001 + (2 * IDX)
TREND_AdvControls = [ //IDX,Title,Type,Options,OptionValues,DefaultOptionIndex(zero based index)
	[AdvCtrlIDC(TREND_ADVSET_VIRTUAL_ARSENAL_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_VirtualArsenal","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvVirtualArsenal"],
	[AdvCtrlIDC(TREND_ADVSET_GROUP_NAME_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupName","RscEdit",[""],"","",localize "STR_TRGM2_Tooltip_AdvGroupName"],
	[AdvCtrlIDC(TREND_ADVSET_SUPPORT_OPTION_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_SupportOptions","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0,""],
	[AdvCtrlIDC(TREND_ADVSET_RESPAWN_TICKET_COUNT_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTickets","RscCombo",["1","2","3","4","5","6","7","8","9","10",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Unlimited"],[1,2,3,4,5,6,7,8,9,10,99999],0,""],
	[AdvCtrlIDC(TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_Mapdraw","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0,localize "STR_TRGM2_Tooltip_AdvMapDraw"],
	[AdvCtrlIDC(TREND_ADVSET_RESPAWN_TIMER_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTimer","RscCombo",["5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","30 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","1 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","20 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min"],[5,10,30,60,300,600,1200],1,""],
	[AdvCtrlIDC(TREND_ADVSET_ENEMY_FACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFactions","RscCombo",TREND_DefaultEnemyFactionArrayText,TREND_DefaultEnemyFactionArray,TREND_DefaultEnemyFactionValue select 0,""],
	[AdvCtrlIDC(TREND_ADVSET_MILITIA_FACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MilitiaFactions","RscCombo",TREND_DefaultMilitiaFactionArrayText,TREND_DefaultMilitiaFactionArray,TREND_DefaultMilitiaFactionValue select 0,""],
	[AdvCtrlIDC(TREND_ADVSET_FRIENDLY_FACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_FriendlyFactions","RscCombo",TREND_DefaultFriendlyFactionArrayText,TREND_DefaultFriendlyFactionArray,TREND_DefaultFriendlyFactionValue select 0,""],
	[AdvCtrlIDC(TREND_ADVSET_SANDSTORM_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_Always",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Never",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_5Hours"],[0,1,2,3],2,""],
	[AdvCtrlIDC(TREND_ADVSET_GROUP_MANAGE_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupManagement","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvGroupManagement"],
	[AdvCtrlIDC(TREND_ADVSET_SELECT_AO_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainAOSelect","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvAoSelect"],
	[AdvCtrlIDC(TREND_ADVSET_SELECT_AO_CAMP_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainAO_CAMP_Select","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvCampStart"],
	[AdvCtrlIDC(TREND_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFlashLights","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],0,""],
	[AdvCtrlIDC(TREND_ADVSET_MINIMISSIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MiniMissions","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvMinimission"],
	[AdvCtrlIDC(TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_IedTargetCompact","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvIedTargetCompact"],
	[AdvCtrlIDC(TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoreEnemies","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvMoreEnemies"],
	[AdvCtrlIDC(TREND_ADVSET_LARGE_PATROLS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_LargePatrols","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],1,localize "STR_TRGM2_Tooltip_AdvLargePatrols"],
	[AdvCtrlIDC(TREND_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_TimeBetweenSpotted","RscXSliderH",60,600,300,localize "STR_TRGM2_Tooltip_TimeBetweenSpotted"],
	[AdvCtrlIDC(TREND_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX), localize "STR_TRGM2_TRGMSetUnitGlobalVars_VehicleReqRep","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Disable", localize "STR_TRGM2_TRGMInitPlayerLocal_Enable"],[0,1],0,localize "STR_TRGM2_Tooltip_AdvVehicleReqRep"]
];
publicVariable "TREND_AdvControls";

TREND_DefaultAdvancedSettings = [];
{
	_defaultValue = _x select 5;
	TREND_DefaultAdvancedSettings pushBack _defaultValue;
} forEach TREND_AdvControls;
publicVariable "TREND_DefaultAdvancedSettings";


/*DONT FORGET TO ADD THIS TO fn_openDialogMissionselection.sqf
if (count TREND_AdvControls < 14) then {
	TREND_AdvControls pushBack (TREND_DefaultAdvancedSettings select 13);
};
*/

/////// Sandstorm settings ///////
if (isNil "TREND_DefaultSandStormOption") then { TREND_DefaultSandStormOption = 2; publicVariable "TREND_DefaultSandStormOption"; };
TREND_sandStormOption = { TREND_AdvancedSettings select TREND_ADVSET_SANDSTORM_IDX };
publicVariable "TREND_sandStormOption";

/////// Patrol settings ///////
if (isNil "TREND_iAllowLargePat") then { TREND_iAllowLargePat =  1; publicVariable "TREND_iAllowLargePat"; }; //("OUT_par_AllowLargePatrols" call BIS_fnc_getParamValue);
TREND_bAllowLargerPatrols = { [random 1 < .33, true, false] select (TREND_AdvancedSettings select TREND_ADVSET_LARGE_PATROLS_IDX)};
publicVariable "TREND_bAllowLargerPatrols";

/////// Higher Enemy Count ///////
TREND_bMoreEnemies = { ( (TREND_AdvancedSettings select TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX isEqualTo 1) || (TREND_AdvancedSettings select TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX isEqualTo 0 && random 1 < .25) ); };
publicVariable "TREND_bMoreEnemies";

//////// Vehicle Spawning Rep Requirement ///////
TREND_VehiclesRequireRep = { TREND_AdvancedSettings select TREND_ADVSET_VEHICLE_SPAWNING_REQ_REP_IDX isEqualTo 1; };
publicVariable "TREND_VehiclesRequireRep";

//////// Spotted Delay ///////
TREND_GetSpottedDelay = { TREND_AdvancedSettings select TREND_ADVSET_TIME_BETWEEN_SPOTTED_ACTIONS_IDX };
publicVariable "TREND_GetSpottedDelay";

//////// Manual AO Placement ///////
TREND_manualAOPlacement = { TREND_AdvancedSettings select TREND_ADVSET_SELECT_AO_IDX isEqualTo 1 };
publicVariable "TREND_manualAOPlacement";

//////// Manual Camp Placement ///////
TREND_manualCampPlacement = { TREND_AdvancedSettings select TREND_ADVSET_SELECT_AO_CAMP_IDX isEqualTo 1 };
publicVariable "TREND_manualCampPlacement";

/////// Revive Settings Set up ///////
//0 = no, 1 = guarantee revive, 2 = realistic revive, 3 = realistic revive (only medics can revive)

if (isNil "TREND_iUseRevive") then { TREND_iUseRevive =  0; publicVariable "TREND_iUseRevive"; };
if (TREND_iUseRevive isEqualTo 0) then {
	TREND_bUseRevive = false; publicVariable "TREND_bUseRevive";
}
else
{
	TREND_bUseRevive = true; publicVariable "TREND_bUseRevive";
};


/////// Building arrays init ///////

TREND_BasicBuildings = [];
"if (configName _x find 'Land_' isEqualTo 0 && {configName _x isKindOf 'Building' && {getnumber (_x >> 'numberOfDoors')  >= 1 or !(getarray (_x >> 'Ladders')  isEqualTo [])}}) then {TREND_BasicBuildings pushBack configName _x}" configClasses (configFile >> "CfgVehicles") apply {configName _x};
publicVariable "TREND_BasicBuildings";

TREND_MilBuildings   = [];
"if (configName _x find 'Land_' isEqualTo 0 && {configName _x isKindOf 'Building' && {(getnumber (_x >> 'numberOfDoors')  >= 1 or !(getarray (_x >> 'Ladders')  isEqualTo [])) && {getText( configFile >> 'CfgEditorSubCategories' >> getText( _x >> 'editorSubcategory' ) >> 'displayName' ) isEqualTo 'Military'}}}) then {TREND_MilBuildings pushBack configName _x}" configClasses (configFile >> "CfgVehicles") apply {configName _x};
publicVariable "TREND_MilBuildings";

TREND_TowerBuildings = ["Land_TTowerBig_2_F","Land_TTowerBig_1_F (towertest)","land_Objects96","Land_wx_radiomast","LAND_uns_signaltower","rso_radiomast"];//,"Land_TTowerSmall_2_F","Land_TTowerSmall_1_F"];  //these small towers are too small for Altis or Malden.. looks strange if this is the comms tower and nearby is a massive unused tower
publicVariable "TREND_TowerBuildings";

/////// Weather settings set up ///////
if (isNil "TREND_iWeather")         then { TREND_iWeather =  1;             publicVariable "TREND_iWeather"; };
if (isNil "TREND_UseEditorWeather") then { TREND_UseEditorWeather =  false; publicVariable "TREND_UseEditorWeather"; };

TREND_WeatherOption = {
	_weatherOption = [TREND_iWeather];
	switch (TREND_iWeather) do {
		case 0:  { _weatherOption = [1,2,3];};
		case 99: { _weatherOption = [TREND_iWeather]; TREND_UseEditorWeather =  true; publicVariable "TREND_UseEditorWeather"; };
		default  { _weatherOption = [TREND_iWeather]; };
	};
	selectRandom _weatherOption;
}; publicVariable "TREND_WeatherOption";

/////// Time settings set up ///////
//[hour,min]
if (isNil "TREND_arrayTime")                                      then { TREND_arrayTime =  [8, 15]; publicVariable "TREND_arrayTime"; };

/////// Minefield settings ///////
if (isNil "TREND_iAllowMineField")                                then { TREND_iAllowMineField =  0; publicVariable "TREND_iAllowMineField"; };
TREND_AllowMineField = (TREND_iAllowMineField isEqualTo 1); publicVariable "TREND_AllowMineField";

/////// Civ/Ins settings ///////
if (isNil "TREND_iBuildingCountToAllowCivsAndFriendlyInformants") then { TREND_iBuildingCountToAllowCivsAndFriendlyInformants =  10; publicVariable "TREND_iBuildingCountToAllowCivsAndFriendlyInformants"; };
if (isNil "TREND_bFriendlyInsurgents")                            then { TREND_bFriendlyInsurgents =  [false,true,false,false]; publicVariable "TREND_bFriendlyInsurgents"; };
if (isNil "TREND_bCivsOnly")                                      then { TREND_bCivsOnly =  [false,false,false,false,false,false]; publicVariable "TREND_bCivsOnly"; }; //all false at the moment... may never use this, but keep incase have idea!

/////// Punish settings ///////
if (isNil "TREND_PunishmentTimer")                                then { TREND_PunishmentTimer =  1200; publicVariable "TREND_PunishmentTimer"; };
if (isNil "TREND_PunishmentRadius")                               then { TREND_PunishmentRadius =  1000; publicVariable "TREND_PunishmentRadius"; }; //if 0 will be no safezone

/////// Mini mission and intel settings ///////
if (isNil "TREND_ChanceOfOccurance")                              then { TREND_ChanceOfOccurance =  [true,false,false,false,false]; publicVariable "TREND_ChanceOfOccurance"; };  //downed chopper, medical emergancy, downed convoy, etc...
TREND_IntelShownType = [1,2,3,4,5]; publicVariable "TREND_IntelShownType";  // 1=Mortar    2=AAA    3=commsTower    4=checkpoints    5=ATMinefield
if (isNil "TREND_TowerRadius")                                    then { TREND_TowerRadius =  3500; publicVariable "TREND_TowerRadius"; };

/////// Artillery offsets ///////
if (isNil "TREND_GridXOffSet")                                    then { TREND_GridXOffSet =  0; publicVariable "TREND_GridXOffSet"; };  //to work this out, get vector21, mark pos at [0,0], the number for the X or Y is the offset, as it should be zero, so if not, we need to use this as an offset
if (isNil "TREND_GridYOffSet")                                    then { TREND_GridYOffSet =  0; publicVariable "TREND_GridYOffSet"; };


/////// Mission parameters set up ///////
TREND_MissionTypeDescriptions = [
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
publicVariable "TREND_MissionTypeDescriptions";
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

TREND_MissionParamTypes = [
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
publicVariable "TREND_MissionParamTypes";
TREND_MissionParamTypesValues = [0,6,8,1,2,3,9,4,7,10,11,12,5]; publicVariable "TREND_MissionParamTypesValues";


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
Add new misions to TREND_MissionParamObjectives/TREND_MissionParamObjectivesValues via pushBack,
but also add to the TREND_SideMissionTasks, TREND_MainMissionTasks and/or TREND_MissionsThatHaveIntel (othrwise, wont be included in random selction or campaign)
Also, add new missions as cases in functions/mission/fn_startInfMission.sqf
*/

// TREND_SideMissionTasks   = [17]; publicVariable "TREND_SideMissionTasks";
TREND_SideMissionTasks      = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]; publicVariable "TREND_SideMissionTasks";
// TREND_MainMissionTasks   = [17]; publicVariable "TREND_MainMissionTasks";
TREND_MainMissionTasks      = [1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]; publicVariable "TREND_MainMissionTasks";
TREND_MissionsThatHaveIntel = [1, 4, 5, 6]; publicVariable "TREND_MissionsThatHaveIntel";

TREND_MissionParamObjectives       = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_startInfMission_MissionTitle1", localize "STR_TRGM2_startInfMission_MissionTitle2", localize "STR_TRGM2_startInfMission_MissionTitle3", localize "STR_TRGM2_startInfMission_MissionTitle4", localize "STR_TRGM2_startInfMission_MissionTitle5", localize "STR_TRGM2_startInfMission_MissionTitle6", localize "STR_TRGM2_startInfMission_MissionTitle7", localize "STR_TRGM2_startInfMission_MissionTitle8", localize "STR_TRGM2_startInfMission_MissionTitle9", localize "STR_TRGM2_startInfMission_MissionTitle10", localize "STR_TRGM2_startInfMission_MissionTitle11", localize "STR_TRGM2_startInfMission_MissionTitle12"];
TREND_MissionParamObjectivesValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

TREND_MissionParamObjectives       pushBack "Defuse IEDs";
TREND_MissionParamObjectivesValues pushBack 13;

TREND_MissionParamObjectives       pushBack localize "STR_TRGM2_BombMissionTitle";
TREND_MissionParamObjectivesValues pushBack 14;

TREND_MissionParamObjectives       pushBack localize "STR_TRGM2_TargetMissionTitle";
TREND_MissionParamObjectivesValues pushBack 15;

TREND_MissionParamObjectives       pushBack localize "STR_TRGM2_CacheMissionTitle";
TREND_MissionParamObjectivesValues pushBack 16;

TREND_MissionParamObjectives       pushBack localize "STR_TRGM2_ClearAreaMissionTitle";
TREND_MissionParamObjectivesValues pushBack 17;

TREND_MissionParamObjectives       pushBack localize "STR_TRGM2_MeetingAssassinationMissionTitle";
TREND_MissionParamObjectivesValues pushBack 18;

TREND_MissionParamObjectives       pushBack "Ambush Convoy";
TREND_MissionParamObjectivesValues pushBack 19;

// if (_CustomMissionEnabled) then {
// 	TREND_MissionParamObjectives       pushBack _MissionTitle;
// 	TREND_MissionParamObjectivesValues pushBack 99999;
// };

publicVariable "TREND_MissionParamObjectives";
publicVariable "TREND_MissionParamObjectivesValues";


TREND_MissionParamRepOptions            = [localize "STR_TRGM2_TRGMInitPlayerLocal_Enable", localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"]; publicVariable "TREND_MissionParamRepOptions";
TREND_MissionParamRepOptionsValues      = [1, 0]; publicVariable "TREND_MissionParamRepOptionsValues";

TREND_MissionParamWeatherOptions        = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Clear", localize "STR_TRGM2_TRGMSetUnitGlobalVars_HeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_AverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Realistic", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Monsoon", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Snowstorm", localize "STR_TRGM2_TRGMSetUnitGlobalVars_UseEditorWeather"]; publicVariable "TREND_MissionParamWeatherOptions";
TREND_MissionParamWeatherOptionsValues  = [0, 1, 2, 3, 4, 31, 41, 99]; publicVariable "TREND_MissionParamWeatherOptionsValues";

TREND_MissionParamNVGOptions            =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Real", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Allow", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_NoAllow"]; publicVariable "TREND_MissionParamNVGOptions";
TREND_MissionParamNVGOptionsValues      =  [2,1,0]; publicVariable "TREND_MissionParamNVGOptionsValues";

TREND_MissionParamReviveOptions         =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_No", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Guarantee", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real1", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real2", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real3", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real4"]; publicVariable "TREND_MissionParamReviveOptions";
TREND_MissionParamReviveOptionsValues   =  [0,1,2,3,4,5]; publicVariable "TREND_MissionParamReviveOptionsValues";

TREND_MissionParamLocationOptions       =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NearAO", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainHQ"]; publicVariable "TREND_MissionParamLocationOptions";
TREND_MissionParamLocationOptionsValues =  [2,1,0]; publicVariable "TREND_MissionParamLocationOptionsValues";

TREND_FastResponseCarItems              = [[[["arifle_SDAR_F"],[10]],[["20Rnd_556x45_UW_mag"],[20]],[["G_B_Diving","V_RebreatherB","U_B_Wetsuit"],[10,10,10]],[[],[]]],false]; publicVariable "TREND_FastResponseCarItems";

TREND_ThemeAndIntroMusic                = ["LeadTrack01_F_Curator","Fallout","Wasteland","AmbientTrack01_F","AmbientTrack01b_F","Track02_SolarPower","Track03_OnTheRoad","Track04_Underwater1","Track05_Underwater2","Track06_CarnHeli","Track07_ActionDark","Track08_Night_ambient","Track09_Night_percussions","Track10_StageB_action","Track11_StageB_stealth","Track12_StageC_action","Track13_StageC_negative","Track14_MainMenu","Track15_MainTheme","LeadTrack01_F_EPA","LeadTrack02_F_EPA","LeadTrack02a_F_EPA","LeadTrack02b_F_EPA","LeadTrack03_F_EPA","LeadTrack03a_F_EPA","EventTrack01_F_EPA","EventTrack01a_F_EPA","EventTrack02_F_EPA","EventTrack02a_F_EPA","EventTrack03_F_EPA","EventTrack03a_F_EPA","LeadTrack01_F_EPB","LeadTrack01a_F_EPB","LeadTrack02_F_EPB","LeadTrack02a_F_EPB","LeadTrack02b_F_EPB","LeadTrack03_F_EPB","LeadTrack03a_F_EPB","LeadTrack04_F_EPB","EventTrack01_F_EPB","EventTrack01a_F_EPB","EventTrack02_F_EPB","EventTrack02a_F_EPB","EventTrack03_F_EPB","EventTrack04_F_EPB","EventTrack04a_F_EPB","EventTrack03a_F_EPB","AmbientTrack01_F_EPB","BackgroundTrack01_F_EPB","LeadTrack01_F_EPC","LeadTrack02_F_EPC","LeadTrack03_F_EPC","LeadTrack04_F_EPC","LeadTrack05_F_EPC","LeadTrack06_F_EPC","LeadTrack06b_F_EPC","EventTrack01_F_EPC","EventTrack02_F_EPC","EventTrack02b_F_EPC","EventTrack03_F_EPC","BackgroundTrack01_F_EPC","BackgroundTrack02_F_EPC","BackgroundTrack03_F_EPC","BackgroundTrack04_F_EPC","LeadTrack01_F_Bootcamp","LeadTrack01b_F_Bootcamp","LeadTrack02_F_Bootcamp","LeadTrack03_F_Bootcamp","LeadTrack01_F_Heli","LeadTrack01_F_Mark","LeadTrack02_F_Mark","LeadTrack03_F_Mark","LeadTrack01_F_EXP","LeadTrack01a_F_EXP","LeadTrack01b_F_EXP","LeadTrack01c_F_EXP","LeadTrack02_F_EXP","LeadTrack03_F_EXP","LeadTrack04_F_EXP","AmbientTrack01_F_EXP","AmbientTrack01a_F_EXP","AmbientTrack01b_F_EXP","AmbientTrack02_F_EXP","AmbientTrack02a_F_EXP","AmbientTrack02b_F_EXP","AmbientTrack02c_F_EXP","AmbientTrack02d_F_EXP","LeadTrack01_F_Jets","LeadTrack02_F_Jets","EventTrack01_F_Jets","LeadTrack01_F_Malden","LeadTrack02_F_Malden","LeadTrack01_F_Orange","AmbientTrack02_F_Orange","EventTrack01_F_Orange","EventTrack02_F_Orange","AmbientTrack01_F_Orange","LeadTrack01_F_Tacops","LeadTrack02_F_Tacops","LeadTrack03_F_Tacops","LeadTrack04_F_Tacops","AmbientTrack01a_F_Tacops","AmbientTrack01b_F_Tacops","AmbientTrack02a_F_Tacops","AmbientTrack02b_F_Tacops","AmbientTrack03a_F_Tacops","AmbientTrack03b_F_Tacops","AmbientTrack04a_F_Tacops","AmbientTrack04b_F_Tacops","EventTrack01a_F_Tacops","EventTrack01b_F_Tacops","EventTrack02a_F_Tacops","EventTrack02b_F_Tacops","EventTrack03a_F_Tacops","EventTrack03b_F_Tacops","Defcon","SkyNet","MAD","AmbientTrack03_F","BackgroundTrack01_F","Track01_Proteus","MainTheme_F_Tank","LeadTrack01_F_Tank","LeadTrack02_F_Tank","LeadTrack03_F_Tank","LeadTrack04_F_Tank","LeadTrack05_F_Tank","LeadTrack06_F_Tank","AmbientTrack01_F_Tank"];
if (1227700 in (getDLCs 1)) then {
	TREND_ThemeAndIntroMusic = ["vn_blues_for_suzy", "vn_dont_cry_baby", "vn_drafted", "vn_fire_in_the_sky_demo", "vn_freedom_bird", "vn_jungle_boots", "vn_kitty_bar_blues", "vn_route9", "vn_tequila_highway", "vn_there_it_is", "vn_trippin", "vn_unsung_heroes", "vn_up_here_looking_down", "vn_voodoo_girl"];
	if (getNumber(configfile >> "CfgPatches" >> "theace" >> "appId") isEqualTo 1161041) then {
		TREND_ThemeAndIntroMusic = TREND_ThemeAndIntroMusic + ["fortunate_son"];
	};
};
publicVariable "TREND_ThemeAndIntroMusic";

if (isNil "TREND_AreasBlackList") then { TREND_AreasBlackList =  []; publicVariable "TREND_AreasBlackList"; };
if (!isNil "TREND_TopLeftPos")    then {
	TREND_AreaLeft       = [[(TREND_TopLeftPos select 0)-5000,TREND_TopLeftPos select 1,0],[TREND_TopLeftPos select 0,TREND_BotRightPos select 1,0]];
	TREND_AreaRight      = [[TREND_BotRightPos select 0,TREND_TopLeftPos select 1,0],[(TREND_BotRightPos select 0) +5000,TREND_BotRightPos select 1,0]];
	TREND_AreaTop        = [[(TREND_TopLeftPos select 0)-5000,(TREND_TopLeftPos select 1)+5000,0],[(TREND_BotRightPos select 0) +5000,TREND_TopLeftPos select 1,0]];
	TREND_AreaBottom     = [[(TREND_TopLeftPos select 0)-5000,TREND_BotRightPos select 1,0],[(TREND_BotRightPos select 0) +5000,(TREND_BotRightPos select 1)-5000,0]];
	TREND_AreasBlackList = [TREND_AreaLeft,TREND_AreaRight,TREND_AreaTop,TREND_AreaBottom]; publicVariable "TREND_AreasBlackList";
};

true;