
TREND_WestFactionData =  [WEST] call TREND_fnc_getFactionDataBySide; publicVariable "TREND_WestFactionData";
TREND_EastFactionData =  [EAST] call TREND_fnc_getFactionDataBySide; publicVariable "TREND_EastFactionData";
TREND_GuerFactionData =  [INDEPENDENT] call TREND_fnc_getFactionDataBySide; publicVariable "TREND_GuerFactionData";
// _unitData = [faction_className, faction_displayName] call TREND_fnc_getUnitDataByFaction;



//hardcoded for now... see notes in root setunitglobalvars.sqf (main git/malden version of this sqf!)
TREND_DefaultEnemyFactionValue = [2]; publicVariable "TREND_DefaultEnemyFactionValue"; //default to FIA
TREND_DefaultMilitiaFactionValue = [1]; publicVariable "TREND_DefaultMilitiaFactionValue"; //default to AAF
TREND_DefaultFriendlyFactionValue = [1]; publicVariable "TREND_DefaultFriendlyFactionValue"; //default to NATO

/////// Custom Mission Init ///////
_CustomMissionEnabled = false;
_MissionTitle = "";
// call compile preprocessFileLineNumbers  "RandFramework\CustomMission\customMission.sqf";
// call fnc_CustomVars;

/////// Debug Mode ///////
TREND_bDebugMode = false; publicVariable "TREND_bDebugMode";

/////// Set up faction arrays ///////
// TREND_WestFactionData;
// TREND_EastFactionData;
// _unitData = [faction_className, faction_displayName] call TREND_fnc_getUnitDataByFaction;
// [unit1_className, unit1_dispName, unit1_role, unit1_isMedic, unit1_isEngineer, unit1_isExpSpecialist, unit1_isUAVHacker]

TREND_DefaultEnemyFactionArray = []; publicVariable "TREND_DefaultEnemyFactionArray";
TREND_DefaultEnemyFactionArrayText = []; publicVariable "TREND_DefaultEnemyFactionArrayText";
TREND_DefaultMilitiaFactionArray = []; publicVariable "TREND_DefaultMilitiaFactionArray";
TREND_DefaultMilitiaFactionArrayText = []; publicVariable "TREND_DefaultMilitiaFactionArrayText";
TREND_DefaultFriendlyFactionArray = []; publicVariable "TREND_DefaultFriendlyFactionArray";
TREND_DefaultFriendlyFactionArrayText = []; publicVariable "TREND_DefaultFriendlyFactionArrayText";

for "_i" from 0 to (count TREND_WestFactionData - 1) do {
	(TREND_WestFactionData select _i) params ["_className", "_displayName"];
	TREND_DefaultFriendlyFactionArrayText pushBack _displayName;
	TREND_DefaultFriendlyFactionArray pushBack _i;
	if (_className == "BLU_F") then {
		TREND_DefaultFriendlyFactionValue = [_i]; publicVariable "TREND_DefaultFriendlyFactionValue";
	};
};

for "_i" from 0 to (count TREND_EastFactionData - 1) do {
	(TREND_EastFactionData select _i) params ["_className", "_displayName"];
	TREND_DefaultEnemyFactionArrayText pushBack _displayName;
	TREND_DefaultEnemyFactionArray pushBack _i;
	if (_className == "OPF_G_F") then {
		TREND_DefaultEnemyFactionValue = [_i]; publicVariable "TREND_DefaultEnemyFactionValue";
	};
};

for "_i" from 0 to (count TREND_GuerFactionData - 1) do {
	(TREND_GuerFactionData select _i) params ["_className", "_displayName"];
	TREND_DefaultMilitiaFactionArrayText pushBack _displayName;
	TREND_DefaultMilitiaFactionArray pushBack _i;
	if (_className == "IND_F") then {
		TREND_DefaultMilitiaFactionValue = [_i]; publicVariable "TREND_DefaultMilitiaFactionValue";
	};
};

publicVariable "TREND_DefaultFriendlyFactionArrayText";
publicVariable "TREND_DefaultFriendlyFactionArray";
publicVariable "TREND_DefaultEnemyFactionArrayText";
publicVariable "TREND_DefaultEnemyFactionArray";
publicVariable "TREND_DefaultMilitiaFactionArrayText";
publicVariable "TREND_DefaultMilitiaFactionArray";

/////// Patrol settings ///////
if (isNil "TREND_iAllowLargePat") then { TREND_iAllowLargePat =  1; publicVariable "TREND_iAllowLargePat"; }; //("OUT_par_AllowLargePatrols" call BIS_fnc_getParamValue);
if (TREND_iAllowLargePat == 0) then {TREND_bAllowLargerPatrols = True; publicVariable "TREND_bAllowLargerPatrols";};
if (TREND_iAllowLargePat == 1) then {TREND_bAllowLargerPatrols = False; publicVariable "TREND_bAllowLargerPatrols";};
if (TREND_iAllowLargePat == 2) then {TREND_bAllowLargerPatrols = selectRandom[False,True]; publicVariable "TREND_bAllowLargerPatrols";};

/////// Advanced Settings Set up ///////

//example: TREND_AdvancedSettings select TREND_ADVSET_ENEMY_FACTIONS_IDX
TREND_ADVSET_VIRTUAL_ARSENAL_IDX = 0; publicVariable "TREND_ADVSET_VIRTUAL_ARSENAL_IDX";
TREND_ADVSET_GROUP_NAME_IDX = 1; publicVariable "TREND_ADVSET_GROUP_NAME_IDX";
TREND_ADVSET_SUPPORT_OPTION_IDX = 2; publicVariable "TREND_ADVSET_SUPPORT_OPTION_IDX";
TREND_ADVSET_RESPAWN_TICKET_COUNT_IDX = 3; publicVariable "TREND_ADVSET_RESPAWN_TICKET_COUNT_IDX";
TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX = 4; publicVariable "TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX";
TREND_ADVSET_RESPAWN_TIMER_IDX = 5; publicVariable "TREND_ADVSET_RESPAWN_TIMER_IDX";
TREND_ADVSET_ENEMY_FACTIONS_IDX = 6; publicVariable "TREND_ADVSET_ENEMY_FACTIONS_IDX";
TREND_ADVSET_MILITIA_FACTIONS_IDX = 7; publicVariable "TREND_ADVSET_MILITIA_FACTIONS_IDX";
TREND_ADVSET_FRIENDLY_FACTIONS_IDX = 8; publicVariable "TREND_ADVSET_FRIENDLY_FACTIONS_IDX";
TREND_ADVSET_SANDSTORM_IDX = 9; publicVariable "TREND_ADVSET_SANDSTORM_IDX";
TREND_ADVSET_GROUP_MANAGE_IDX = 10; publicVariable "TREND_ADVSET_GROUP_MANAGE_IDX";
TREND_ADVSET_SELECT_AO_IDX = 11; publicVariable "TREND_ADVSET_SELECT_AO_IDX";
TREND_ADVSET_SELECT_AO_CAMP_IDX = 12; publicVariable "TREND_ADVSET_SELECT_AO_CAMP_IDX";
TREND_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX = 13; publicVariable "TREND_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX";
TREND_ADVSET_MINIMISSIONS_IDX = 14; publicVariable "TREND_ADVSET_MINIMISSIONS_IDX";
TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX = 15; publicVariable "TREND_ADVSET_IEDTARGET_COMPACT_SPACING_IDX";
TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX = 16; publicVariable "TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX";

//NOTE the id's must go up in twos!
TREND_AdvControls = [ //IDX,Title,Type,Options,OptionValues,DefaultOptionIndex(zero based index)
	[6001, localize "STR_TRGM2_TRGMSetUnitGlobalVars_VirtualArsenal","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvVirtualArsenal"],
	[6003, localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupName","RscEdit",[""],"",1,localize "STR_TRGM2_Tooltip_AdvGroupName"],
	[6005, localize "STR_TRGM2_TRGMSetUnitGlobalVars_SupportOptions","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0,""],
	[6007, localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTickets","RscCombo",["1","2","3","4","5","6","7","8","9","10",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Unlimited"],[1,2,3,4,5,6,7,8,9,10,99999],0,""],
	[6009, localize "STR_TRGM2_TRGMSetUnitGlobalVars_Mapdraw","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0,localize "STR_TRGM2_Tooltip_AdvMapDraw"],
	[6011, localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTimer","RscCombo",["5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","30 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","1 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","20 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min"],[5,10,30,60,300,600,1200],1,""],
	[6013, localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFactions","RscCombo",TREND_DefaultEnemyFactionArrayText,TREND_DefaultEnemyFactionArray,TREND_DefaultEnemyFactionValue select 0,""],
	[6015, localize "STR_TRGM2_TRGMSetUnitGlobalVars_MilitiaFactions","RscCombo",TREND_DefaultMilitiaFactionArrayText,TREND_DefaultMilitiaFactionArray,TREND_DefaultMilitiaFactionValue select 0,""],
	[6017, localize "STR_TRGM2_TRGMSetUnitGlobalVars_FriendlyFactions","RscCombo",TREND_DefaultFriendlyFactionArrayText,TREND_DefaultFriendlyFactionArray,TREND_DefaultFriendlyFactionValue select 0,""],
	[6019, localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_Always",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Never",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_5Hours"],[0,1,2,3],TREND_DefaultSandStormOption,""],
	[6021, localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupManagement","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvGroupManagement"],
	[6023, localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainAOSelect","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvAoSelect"],
	[6025, localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainAO_CAMP_Select","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1,localize "STR_TRGM2_Tooltip_AdvCampStart"],
	[6027, localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFlashLights","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],0,""],
	[6029, localize "STR_TRGM2_TRGMSetUnitGlobalVars_MiniMissions","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvMinimission"],
	[6031, localize "STR_TRGM2_TRGMSetUnitGlobalVars_IedTargetCompact","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvIedTargetCompact"],
	[6033, localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoreEnemies","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],2,localize "STR_TRGM2_Tooltip_AdvMoreEnemies"],
	[6035, localize "STR_TRGM2_TRGMSetUnitGlobalVars_LargePatrols","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[0,1,2],TREND_iAllowLargePat,""]
];
publicVariable "TREND_AdvControls";

TREND_DefaultAdvancedSettings = [];
{
	_defaultValue = _x select 5;
	TREND_DefaultAdvancedSettings pushBack _defaultValue;
} forEach TREND_AdvControls;
publicVariable "TREND_DefaultAdvancedSettings";


/*DONT FORGET TO ADD THIS TO openDialogMissionselection.sqf
if (count TREND_AdvControls < 14) then {
	TREND_AdvControls pushBack (TREND_DefaultAdvancedSettings select 13);
};
*/


/////// Revive Settings Set up ///////
//0 = no, 1 = guarantee revive, 2 = realistic revive, 3 = realistic revive (only medics can revive)

if (isNil "TREND_iUseRevive") then { TREND_iUseRevive =  0; publicVariable "TREND_iUseRevive"; };
if (TREND_iUseRevive == 0) then {
	TREND_bUseRevive = false; publicVariable "TREND_bUseRevive";
}
else
{
	TREND_bUseRevive = true; publicVariable "TREND_bUseRevive";
};


/////// Building arrays init ///////

TREND_BasicBuildings = ["Land_LightHouse_F","Land_Lighthouse_small_F","Land_Metal_Shed_F","Land_Offices_01_V1_F","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_Unfinished_Building_01_F","Land_Unfinished_Building_02_F","Land_d_House_Big_01_V1_F","Land_d_House_Big_02_V1_F","Land_d_House_Small_02_V1_F","Land_d_Stone_HouseBig_V1_F","Land_d_Stone_HouseSmall_V1_F","Land_d_Stone_Shed_V1_F","Land_dp_mainFactory_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V2_F","Land_i_Stone_HouseBig_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_u_House_Small_01_V1_F","Land_u_House_Small_02_V1_F","Land_cargo_house_slum_F","Land_jbad_House_1_old","Land_jbad_House_3_old","Land_jbad_House_4_old","Land_jbad_House_6_old","Land_jbad_House_7_old","Land_jbad_House_8_old","Land_jbad_House_9_old","Land_lbad_House_c_1_v2","Land_jbad_House_c_11","Land_jbad_House_c_1","Land_jbad_House_c_2","Land_jbad_House_c_3","Land_jbad_House_c_4","Land_jbad_House_c_5","Land_jbad_House_c_5_v1","Land_jbad_House_c_5_v2","Land_jbad_House_c_5_v3","Land_jbad_House_1","Land_jbad_House_3","Land_jbad_House_5","Land_jbad_House_6","Land_jbad_House_7","Land_jbad_House_8","Land_jbad_House2_basehide","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_12_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_L_8_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_L_1_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_jbad_House_1_old","Land_jbad_House_3_old","Land_jbad_House_4_old","Land_jbad_House_6_old","Land_jbad_House_7_old","Land_jbad_House_8_old","Land_jbad_House_9_old","Land_lbad_House_c_1_v2","Land_jbad_House_c_11","Land_jbad_House_c_1","Land_jbad_House_c_2","Land_jbad_House_c_3","Land_jbad_House_c_4","Land_jbad_House_c_5","Land_jbad_House_c_5_v1","Land_jbad_House_c_5_v2","Land_jbad_House_c_5_v3","Land_jbad_House_1","Land_jbad_House_3","Land_jbad_House_5","Land_jbad_House_6","Land_jbad_House_7","Land_jbad_House_8","Land_jbad_House2_basehide","Land_Shed_02_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_House_Small_04_F","Land_House_Small_05_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_House_Big_02_F","Land_House_Big_03_F","Land_House_Big_05_F","Land_Shed_05_F","Land_Shed_06_F","Land_Shed_07_F","Land_Addon_04_F","Land_Shop_City_03_F","Land_Shop_City_05_F","Land_Shop_City_06_F","Land_Shop_City_07_F","Land_House_Big_04_F","Land_House_Native_01_F","Land_House_Native_02_F","Land_House_Native_03_F","Land_House_Native_04_F","Land_House_Native_05_F","Land_House_Native_06_F","Land_blud_hut1","Land_blud_hut2","Land_blud_hut3","Land_blud_hut4","Land_blud_hut5","Land_blud_hut6","Land_blud_hut7","Land_blud_hut8","Land_MBG_GER_RHUS_5","Land_MBG_ATC_Base","Land_MBG_GER_RHUS_2","Land_MBG_GER_HUS_1","Land_MBG_ATC_Segment","Land_MBG_GER_RHUS_1","Land_MBG_GER_HUS_2","Land_MBG_GER_RHUS_3","Land_MBG_GER_RHUS_4","Objects17","Objects18","Objects19","Objects21","Objects22","Objects23","Land_deox_House_A1","Land_deox_House_A2","Land_deox_House_B1","Land_deox_House_B2","Land_deox_House_C1","Land_deox_House_C2","Land_deox_House_D_L1","Land_deox_House_D_L2","Land_deox_House_D_L3","Land_deox_House_D_L4","Land_deox_House_D_M1","Land_deox_House_D_M2","Land_deox_House_D_M3","Land_deox_House_D_M4","Land_deox_House_D_R1","Land_deox_House_D_R3","MBG_Killhouse_3_InEditor","MBG_Killhouse_4_InEditor","MBG_Killhouse_5_InEditor","MBG_Killhouse_2_InEditor","MBG_Killhouse_5_InEditor","MBG_Killhouse_1_InEditor","land_Objects101","land_Objects77","jbad_House_c_1","jbad_House_c_1_v2","jbad_House_c_10","jbad_House_c_11","jbad_House_c_12","jbad_House_c_2","jbad_House_c_3","jbad_House_c_4","jbad_House_c_5","jbad_House_c_5_v1","jbad_House_c_5_v2","jbad_House_c_5_v3","jbad_House_c_9","jbad_dum_istan2","jbad_dum_istan4","Jbad_A_Villa","jbad_House_3_old_h","Jbad_A_BuildingWIP","Jbad_Ind_Workshop01_L","Jbad_A_Stationhouse","Jbad_Mil_Barracks","Jbad_Mil_ControlTower","Jbad_Mil_Guardhouse","Jbad_Mil_House","jbad_mosque_big_addon","jbad_mosque_big_hq","Jbad_A_Mosque_small_1","Land_Jbad_A_Mosque_small_1","Jbad_A_Mosque_small_2","Land_HouseV_1I4","Land_HouseV2_02_Interier","Land_HouseV2_02_Interier_dam","Land_HouseV2_04_interier","Land_HouseV2_04_interier_dam","Land_Farm_Cowshed_a","Land_Farm_Cowshed_a_dam","Land_Farm_Cowshed_b","Land_Farm_Cowshed_b_dam","Land_Farm_Cowshed_c","Land_Farm_Cowshed_c_dam","Land_Barn_W_01","Land_Barn_W_01_dam","Land_Barn_W_02","Land_Shed_wooden","Land_Church_05R","Land_Church_03","Land_Church_03_dam","Land_Ind_Vysypka","Land_A_Castle_Bergfrit","Land_A_Castle_Bergfrit_dam","Land_A_Castle_Donjon","Land_A_Castle_Donjon_dam","Land_R_HouseV2_02","Land_R_HouseV2_04","Land_A_Office01","Land_A_Office02","Land_A_Pub_01","Land_HouseB_Tenement","Land_raz_hut04","Land_raz_hut07","LAND_uns_hut12","Land_raz_hut06","Land_raz_hut05","Land_raz_hut02","Land_raz_hut01","land_indo_hut_2","land_indo_hut_1","LAND_uns_covering2","Land_raz_hut08","Land_raz_hut03","LAND_uns_covering1","csj_temple1","LAND_CSJ_village6","LAND_CSJ_village5","LAND_csj_village8","LAND_CSJ_riverhut4","LAND_CSJ_riverhut3","LAND_CSJ_village7","LAND_CSJ_village4","LAND_CSJ_village1","LAND_CSJ_village2","LAND_CSJ_village3","LAND_CSJ_riverhut1","LAND_CSJ_riverhut1","LAND_CSJ_hut06","LAND_CSJ_hut05","Land_MBG_Hut_C","Land_MBG_Hut_B","LAND_csj_hut02","LAND_CSJ_hut07","LAND_csj_hut01","LAND_uns_hut08","Land_MBG_Hut_A","LAND_CSJ_Yard5","LAND_CSJ_Yard3","LAND_CSJ_Yard2","LAND_CSJ_Yard1","LAND_CSJ_Yard_pen1","LAND_CSJ_Yard_penGate","LAND_CSJ_Yard4","csj_shelter01","LAND_uns_hut2","LAND_uns_hut1","LAND_uns_hutraised1","LAND_uns_hutraised2","LAND_uns_platform1","LAND_uns_platform1fishnets","LAND_uns_platform1shelter2","LAND_uns_platform1shelter1","LAND_uns_villstorage_shelter","Land_WX_building001","Land_WX_building002","Land_wx_jap_headquarters","concretecover","Land_A_Office01_EP1","Land_dum_istan3_hromada2","Land_Farm_Cowshed_a","Land_Farm_Cowshed_b","Land_Farm_Cowshed_c","Land_Ind_Garage01","Land_House_C_10_dam_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1_base","Land_House_C_11_EP1","Land_House_C_12_EP1","Land_House_C_12_EP1_base","Land_House_C_2_EP1","Land_House_C_4_EP1","Land_House_C_5_V1_EP1","Land_Shed_M01","Land_Shed_M03","Land_Shed_W01","Land_Shed_W02","Land_Shed_W03","Land_Shed_W4","Land_Shed_wooden","Land_i_Stone_Shed_01_b_raw_F","Land_i_Stone_Shed_01_b_raw_F","Land_House_K_2_basehide_EP1","Land_WW2_Countryside_House_2_Damaged","Land_WW2_Corner_House_2e_4_Damaged","Land_WW2_Central_3e_1_Damaged","Land_WW2_Admin_Damaged","Land_WW2_Dlc1_House_1floor_Pol","Land_i_House_Big_02_b_blue_F","Land_i_House_Big_02_b_pink_F","Land_i_House_Big_02_b_whiteblue_F","Land_i_House_Big_02_b_white_F","Land_i_House_Big_02_b_brown_F","Land_i_House_Big_02_b_yellow_F","Land_i_House_Big_01_b_blue_F","Land_i_House_Big_01_b_pink_F","Land_i_House_Big_01_b_whiteblue_F","Land_i_House_Big_01_b_white_F","Land_i_House_Big_01_b_brown_F","Land_i_House_Big_01_b_yellow_F","Land_i_Shop_02_b_blue_F","Land_i_Shop_02_b_pink_F","Land_i_Shop_02_b_whiteblue_F","Land_i_Shop_02_b_white_F","Land_i_Shop_02_b_brown_F","Land_i_Shop_02_b_yellow_F","Land_Barn_01_brown_F","Land_Barn_01_grey_F","Land_i_House_Small_01_b_blue_F","Land_i_House_Small_01_b_pink_F","Land_i_House_Small_02_b_blue_F","Land_i_House_Small_02_b_pink_F","Land_i_House_Small_02_b_whiteblue_F","Land_i_House_Small_02_b_white_F","Land_i_House_Small_02_b_brown_F","Land_i_House_Small_02_b_yellow_F","Land_i_House_Small_02_c_blue_F","Land_i_House_Small_02_c_pink_F","Land_i_House_Small_02_c_whiteblue_F","Land_i_House_Small_02_c_white_F","Land_i_House_Small_02_c_brown_F","Land_i_House_Small_02_c_yellow_F","Land_i_House_Small_01_b_whiteblue_F","Land_i_House_Small_01_b_white_F","Land_i_House_Small_01_b_brown_F","Land_i_House_Small_01_b_yellow_F","Land_i_Addon_02_b_white_F","Land_Shed_08_brown_F","Land_Shed_08_grey_F","Land_i_Stone_House_Big_01_b_clay_F","Land_i_Stone_Shed_01_b_clay_F","Land_i_Stone_Shed_01_b_raw_F","Land_i_Stone_Shed_01_b_white_F","Land_i_Stone_Shed_01_c_clay_F","Land_i_Stone_Shed_01_c_raw_F","Land_i_Stone_Shed_01_c_white_F","Land_i_Stone_Shed_V2_F","Land_u_House_Small_02_V1_F","Land_u_Barracks_V2_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","land_gm_euro_office_02_win","land_gm_euro_church_01_win","land_gm_euro_church_02_win","land_gm_euro_fuelstation_01_w_win","land_gm_euro_fuelstation_02_win","land_gm_euro_mine_01_win","land_gm_euro_office_01_win","land_gm_euro_pub_01_win","land_gm_euro_office_03_win","land_gm_euro_pub_02_win","land_gm_euro_shop_01_w_win","land_gm_euro_shop_02_e_win","land_gm_euro_shop_02_w_win","land_gm_euro_house_04_d_win","land_gm_euro_house_04_e_win","land_gm_euro_house_04_w_win","land_gm_euro_house_03_e_win","land_gm_euro_house_03_w_win","land_gm_euro_house_11_d_win","land_gm_euro_house_11_e_win","land_gm_euro_house_11_w_win","land_gm_euro_house_02_d_win","land_gm_euro_house_02_e_win","land_gm_euro_house_02_w_win","land_gm_euro_house_06_w_win","land_gm_euro_house_06_d_win","land_gm_euro_house_06_e_win","land_gm_euro_house_09_d_win","land_gm_euro_house_09_e_win","land_gm_euro_house_09_w_win","land_gm_euro_house_10_w_win","land_gm_euro_house_10_d_win","land_gm_euro_house_10_e_win","land_gm_euro_house_12_d_win","land_gm_euro_house_12_e_win","land_gm_euro_house_12_w_win","land_gm_euro_house_07_d_win","land_gm_euro_house_07_e_win","land_gm_euro_house_07_w_win","land_gm_euro_house_01_w_win","land_gm_euro_house_01_d_win","land_gm_euro_house_01_e_win","land_gm_euro_house_05_d_win","land_gm_euro_house_05_e_win","land_gm_euro_house_05_w_win","land_gm_euro_house_13_w_win","land_gm_euro_house_13_d_win","land_gm_euro_house_13_e_win","land_gm_euro_house_08_w_win","land_gm_euro_house_08_d_win","land_gm_euro_house_08_e_win","land_gm_euro_shed_04_win","land_gm_euro_shed_01_win","land_gm_euro_shed_03_win","land_gm_euro_shed_05_win","land_gm_euro_farmhouse_02_win","land_gm_euro_farmhouse_03_win","land_gm_euro_farmhouse_01_win","land_gm_euro_factory_01_02_win","land_gm_euro_factory_01_01_win","land_gm_euro_barracks_02_win","land_gm_euro_barracks_01_win"];
TREND_BasicBuildings = TREND_BasicBuildings + ["Land_Barn_04_ruins_F","Land_ConnectorTent_01_white_cross_F","Land_DeconTent_01_white_F","Land_DeconTent_01_yellow_F","Land_DeconTent_01_IDAP_F","Land_ConnectorTent_01_AAF_closed_F","Land_ConnectorTent_01_AAF_cross_F","Land_ConnectorTent_01_AAF_open_F","Land_DeconTent_01_AAF_F","Land_Dome_Small_WIP2_F","Land_Dome_Small_WIP_F","Land_MedicalTent_01_aaf_generic_inner_F","Land_Barn_02_F","Land_Barn_04_F","Land_Barn_03_large_F","Land_Barn_03_small_F","Land_Cowshed_01_A_F","Land_Cowshed_01_C_F","Land_CastleRuins_01_bastion_F","Land_CementWorks_01_brick_F","Land_CementWorks_01_grey_F","Land_Factory_02_F","Land_GarageRow_01_large_F","Land_GarageRow_01_small_F","Land_GarageOffice_01_F","Land_Sawmill_01_F","Land_IndustrialShed_01_F","Land_i_Shed_Ind_old_F","Land_Workshop_05_F","Land_Workshop_05_grey_F","Land_Workshop_03_grey_F","Land_Workshop_04_grey_F","Land_Workshop_01_F","Land_Workshop_02_F","Land_ControlTower_02_F","Land_Barracks_06_F","Land_Barracks_02_F","Land_Barracks_03_F","Land_Barracks_04_F","Land_ControlTower_01_F","Land_Radar_01_kitchen_F","Land_Radar_01_HQ_F","Land_Church_04_lightblue_F","Land_Church_04_small_lightblue_F","Land_Church_04_red_F","Land_Church_04_red_damaged_F","Land_OrthodoxChurch_02_F","Land_OrthodoxChurch_03_F","Land_Church_05_F","Land_House_1B01_F","Land_House_2B01_F","Land_House_2B02_F","Land_House_2B03_F","Land_House_2B04_F","Land_Camp_House_01_brown_F","Land_VillageStore_01_F","Land_HealthCenter_01_F","Land_PoliceStation_01_F","Land_House_1W01_F","Land_House_1W10_F","Land_House_1W11_F","Land_House_1W12_F","Land_House_1W13_F","Land_House_1W02_F","Land_House_1W03_F","Land_House_1W04_F","Land_House_1W05_F","Land_House_1W06_F","Land_House_1W07_F","Land_House_1W08_F","Land_House_1W09_F","Land_House_2W01_F","Land_House_2W02_F","Land_House_2W03_F","Land_House_2W04_F","Land_House_2W05_F","Land_Shed_14_F","Land_Shed_10_F","Land_Shed_09_F"];
TREND_BasicBuildings = TREND_BasicBuildings + ["rso_apartmentcomplex","rso_apartmentcomplex_wip","rso_apartmentcomplex4","rso_apartmentcomplex5","rso_big","rso_big_b","rso_big_c","rso_big_d","rso_big_e","rso_big_f","rso_block1","rso_complex1","rso_complex2","rso_complex3","rso_complex4","rso_complex5","rso_complex6","rso_complex7","rso_complex9","rso_construct1","rso_construct2","rso_construct3","rso_construct4","rso_corner1","rso_corner2","rso_cornershop1","rso_h1","rso_h10","rso_h11","rso_h12","rso_h13","rso_h14","rso_h15","rso_h16","rso_h17","rso_h18","rso_h19","rso_h2","rso_h20","rso_h21","rso_h3","rso_h4","rso_h5","rso_h6","rso_h7","rso_h8","rso_h9","rso_house_big1","rso_hut1","rso_hut2","rso_hut3","rso_hut4","rso_hut_invert1","rso_long1","rso_mosque1","rso_shop1","rso_shop2","rso_shop3","rso_shop3b","rso_shop4","rso_store1","rso_stores2","rso_stores3"];
publicVariable "TREND_BasicBuildings";

TREND_MilBuildings = ["Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F","Land_Cargo_House_V3_F","Land_Cargo_House_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V1_F", "Land_MilOfficers_V1_F","Land_PillboxBunker_01_big_F","Land_PillboxBunker_01_hex_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_BagBunker_Tower_F","Land_Bunker_01_big_F","Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_BagBunker_01_large_green_F","Land_BagBunker_01_small_green_F","Land_HBarrier_01_tower_green_F","Land_fortified_nest_big","Land_fortified_nest_small","Fort_Nest","Land_Fort_Watchtower","Land_fortified_nest_big_EP1","Land_fortified_nest_small_EP1","Land_Fort_Watchtower_EP1","Land_Vil_Tower","LAND_uns_village_tower","LAND_uns_vctower1","LAND_uns_vctower2"];
TREND_MilBuildings = TREND_MilBuildings + ["Land_DeerStand_01_F","Land_DeerStand_02_F","Land_GuardHouse_02_F","Land_GuardBox_01_smooth_F","Land_GuardBox_01_brown_F","Land_GuardBox_01_green_F","Land_GuardHouse_02_grey_F","Land_GuardHouse_03_F","Land_GuardTower_01_F","Land_GuardTower_02_F","Land_MobileRadar_01_radar_F"];
publicVariable "TREND_MilBuildings";

TREND_TowerBuildings = ["Land_TTowerBig_2_F","Land_TTowerBig_1_F (towertest)","land_Objects96","Land_wx_radiomast","LAND_uns_signaltower","rso_radiomast"];//,"Land_TTowerSmall_2_F","Land_TTowerSmall_1_F"];  //these small towers are too small for Altis or Malden.. looks strange if this is the comms tower and nearby is a massive unused tower
publicVariable "TREND_TowerBuildings";



/////// Briefing Vars ///////
if (isNil "TREND_sBreifing") then { TREND_sBreifing =  ""; publicVariable "TREND_sBreifing"; };
if (isNil "TREND_sAltisRegainEngine") then { TREND_sAltisRegainEngine =  ""; publicVariable "TREND_sAltisRegainEngine"; };
if (isNil "TREND_sScriptsUsed") then { TREND_sScriptsUsed =  localize "STR_TRGM2_TRGMSetUnitGlobalVars_ScriptsUsed"; publicVariable "TREND_sScriptsUsed"; };


/////// Weather settings set up ///////
if (isNil "TREND_iWeather") then { TREND_iWeather =  1; publicVariable "TREND_iWeather"; };
if (isNil "TREND_UseEditorWeather") then { TREND_UseEditorWeather =  false; publicVariable "TREND_UseEditorWeather"; };

switch (TREND_iWeather) do {
	case 0:  {TREND_WeatherOptions = [1,1,1,2,2,2,3,3,3,4,5,6,7,7,8,9,10]; publicVariable "TREND_WeatherOptions";};
	case 1:  {TREND_WeatherOptions = [1]; publicVariable "TREND_WeatherOptions";};
	case 2:  {TREND_WeatherOptions = [2]; publicVariable "TREND_WeatherOptions";};
	case 3:  {TREND_WeatherOptions = [3]; publicVariable "TREND_WeatherOptions";};
	case 4:  {TREND_WeatherOptions = [4]; publicVariable "TREND_WeatherOptions";};
	case 5:  {TREND_WeatherOptions = [5]; publicVariable "TREND_WeatherOptions";};
	case 6:  {TREND_WeatherOptions = [6]; publicVariable "TREND_WeatherOptions";};
	case 7:  {TREND_WeatherOptions = [7]; publicVariable "TREND_WeatherOptions";};
	case 8:  {TREND_WeatherOptions = [8]; publicVariable "TREND_WeatherOptions";};
	case 9:  {TREND_WeatherOptions = [9]; publicVariable "TREND_WeatherOptions";};
	case 10: {TREND_WeatherOptions = [10]; publicVariable "TREND_WeatherOptions";};
	case 11: {TREND_WeatherOptions = [11]; publicVariable "TREND_WeatherOptions";};
	case 99: {TREND_WeatherOptions = [99]; publicVariable "TREND_WeatherOptions"; TREND_UseEditorWeather =  true; publicVariable "TREND_UseEditorWeather";};
	default  {TREND_WeatherOptions = [1,1,1,2,2,2,3,3,3,4,5,6,7,7,8,9,10]; publicVariable "TREND_WeatherOptions";};
};

/////// Minefield settings ///////
if (isNil "TREND_iAllowMineField") then { TREND_iAllowMineField =  0; publicVariable "TREND_iAllowMineField"; };
TREND_AllowMineField = (TREND_iAllowMineField == 1); publicVariable "TREND_AllowMineField";

/////// Civ/Ins settings ///////
if (isNil "TREND_iBuildingCountToAllowCivsAndFriendlyInformants") then { TREND_iBuildingCountToAllowCivsAndFriendlyInformants =  10; publicVariable "TREND_iBuildingCountToAllowCivsAndFriendlyInformants"; };
if (isNil "TREND_bFriendlyInsurgents") then { TREND_bFriendlyInsurgents =  [false,true,false,false]; publicVariable "TREND_bFriendlyInsurgents"; };
if (isNil "TREND_bCivsOnly") then { TREND_bCivsOnly =  [false,false,false,false,false,false]; publicVariable "TREND_bCivsOnly"; }; //all false at the moment... may never use this, but keep incase have idea!

/////// Punish settings ///////
if (isNil "TREND_PunishmentTimer") then { TREND_PunishmentTimer =  1200; publicVariable "TREND_PunishmentTimer"; };
if (isNil "TREND_PunishmentRadius") then { TREND_PunishmentRadius =  1000; publicVariable "TREND_PunishmentRadius"; }; //if 0 will be no safezone

/////// Mini mission and intel settings ///////
if (isNil "TREND_ChanceOfOccurance") then { TREND_ChanceOfOccurance =  [true,false,false,false,false]; publicVariable "TREND_ChanceOfOccurance"; };  //downed chopper, medical emergancy, downed convoy, etc...
TREND_IntelShownType = [1,2,3,4,5]; publicVariable "TREND_IntelShownType";  // 1=Mortar    2=AAA    3=commsTower    4=checkpoints    5=ATMinefield
if (isNil "TREND_TowerRadius") then { TREND_TowerRadius =  3500; publicVariable "TREND_TowerRadius"; };

/////// Datetime settings set up ///////
//[year.month,day,hour,min]
TREND_Sunny = [2035, 1, 14, 12, 0]; publicVariable "TREND_Sunny";
TREND_DarkNight = [2035, 1, 15, 0, 0]; publicVariable "TREND_DarkNight";
TREND_MoonNight = [2035, 11, 09, 23, 0]; publicVariable "TREND_MoonNight";
TREND_EarlyMorning = [2035, 1, 14, 8, 15]; publicVariable "TREND_EarlyMorning";

/////// Artillery offsets ///////
if (isNil "TREND_GridXOffSet") then { TREND_GridXOffSet =  0; publicVariable "TREND_GridXOffSet"; };  //to work this out, get vector21, mark pos at [0,0], the number for the X or Y is the offset, as it should be zero, so if not, we need to use this as an offset
if (isNil "TREND_GridYOffSet") then { TREND_GridYOffSet =  0; publicVariable "TREND_GridYOffSet"; };


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
	localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName6"
];
publicVariable "TREND_MissionParamTypes";
TREND_MissionParamTypesValues = [0,6,8,1,2,3,9,4,7,10,5]; publicVariable "TREND_MissionParamTypesValues";


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

// TREND_SideMissionTasks = [17]; publicVariable "TREND_SideMissionTasks";
TREND_SideMissionTasks = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,99999]; publicVariable "TREND_SideMissionTasks";
// TREND_MainMissionTasks = [17]; publicVariable "TREND_MainMissionTasks";
TREND_MainMissionTasks = [1,2,3,6,7,8,9,10,11,12,13,14,15,16,17,99999]; publicVariable "TREND_MainMissionTasks";
TREND_MissionsThatHaveIntel = [1,4,5,6]; publicVariable "TREND_MissionsThatHaveIntel";

TREND_MissionParamObjectives = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_startInfMission_MissionTitle1",localize "STR_TRGM2_startInfMission_MissionTitle2",localize "STR_TRGM2_startInfMission_MissionTitle3",localize "STR_TRGM2_startInfMission_MissionTitle4",localize "STR_TRGM2_startInfMission_MissionTitle5",localize "STR_TRGM2_startInfMission_MissionTitle6",localize "STR_TRGM2_startInfMission_MissionTitle7",localize "STR_TRGM2_startInfMission_MissionTitle8",localize "STR_TRGM2_startInfMission_MissionTitle9",localize "STR_TRGM2_startInfMission_MissionTitle10",localize "STR_TRGM2_startInfMission_MissionTitle11",localize "STR_TRGM2_startInfMission_MissionTitle12"];
TREND_MissionParamObjectivesValues = [0,1,2,3,4,5,6,7,8,9,10,11,12];

//add new misions below, but also add to the SideMissionTasks,  MainMissionTasks or MissionsThatHaveIntel above (othrwise, wont be included in random selction or campaign)
/*ALSO,add the below to startInfMission.sqf
	if (_iThisTaskType == 16) then {
		#include "..\RandFramework\CustomMission\Mission16.sqf"; //Search and Destroy
		call fnc_CustomVars;
	};
*/
TREND_MissionParamObjectives pushBack "Defuse IEDs";
TREND_MissionParamObjectivesValues pushBack 13;

TREND_MissionParamObjectives pushBack localize "STR_TRGM2_BombMissionTitle";
TREND_MissionParamObjectivesValues pushBack 14;

TREND_MissionParamObjectives pushBack localize "STR_TRGM2_TargetMissionTitle";
TREND_MissionParamObjectivesValues pushBack 15;

TREND_MissionParamObjectives pushBack localize "STR_TRGM2_CacheMissionTitle";
TREND_MissionParamObjectivesValues pushBack 16;

TREND_MissionParamObjectives pushBack localize "STR_TRGM2_ClearAreaMissionTitle";
TREND_MissionParamObjectivesValues pushBack 17;

if (_CustomMissionEnabled) then {
	TREND_MissionParamObjectives pushBack _MissionTitle;
	TREND_MissionParamObjectivesValues pushBack 99999;
};

publicVariable "TREND_MissionParamObjectives";
publicVariable "TREND_MissionParamObjectivesValues";


TREND_MissionParamRepOptions = [localize "STR_TRGM2_TRGMInitPlayerLocal_Enable", localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"]; publicVariable "TREND_MissionParamRepOptions";
TREND_MissionParamRepOptionsValues = [1, 0]; publicVariable "TREND_MissionParamRepOptionsValues";

TREND_MissionParamWeatherOptions = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sunny", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DaytimeHeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DaytimeAverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightClear", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightHeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightAverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_EarlyMorning", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightClear", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightAverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightHeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Monsoon", localize "STR_TRGM2_TRGMSetUnitGlobalVars_UseEditorWeather"]; publicVariable "TREND_MissionParamWeatherOptions";
TREND_MissionParamWeatherOptionsValues = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 99]; publicVariable "TREND_MissionParamWeatherOptionsValues";

TREND_MissionParamNVGOptions =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Real", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Allow", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_NoAllow"]; publicVariable "TREND_MissionParamNVGOptions";
TREND_MissionParamNVGOptionsValues =  [2,1,0]; publicVariable "TREND_MissionParamNVGOptionsValues";

TREND_MissionParamReviveOptions =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_No", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Guarantee", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real1", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real2", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real3", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real4"]; publicVariable "TREND_MissionParamReviveOptions";
TREND_MissionParamReviveOptionsValues =  [0,1,2,3,4,5]; publicVariable "TREND_MissionParamReviveOptionsValues";

TREND_MissionParamLocationOptions =  [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NearAO", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainHQ"]; publicVariable "TREND_MissionParamLocationOptions";
TREND_MissionParamLocationOptionsValues =  [2,1,0]; publicVariable "TREND_MissionParamLocationOptionsValues";

TREND_FastResponseCarItems = [[[["arifle_SDAR_F"],[10]],[["20Rnd_556x45_UW_mag"],[20]],[["G_B_Diving","V_RebreatherB","U_B_Wetsuit"],[10,10,10]],[[],[]]],false]; publicVariable "TREND_FastResponseCarItems";

TREND_ThemeAndIntroMusic = ["LeadTrack01_F_Curator","Fallout","Wasteland","AmbientTrack01_F","AmbientTrack01b_F","Track02_SolarPower","Track03_OnTheRoad","Track04_Underwater1","Track05_Underwater2","Track06_CarnHeli","Track07_ActionDark","Track08_Night_ambient","Track09_Night_percussions","Track10_StageB_action","Track11_StageB_stealth","Track12_StageC_action","Track13_StageC_negative","Track14_MainMenu","Track15_MainTheme","LeadTrack01_F_EPA","LeadTrack02_F_EPA","LeadTrack02a_F_EPA","LeadTrack02b_F_EPA","LeadTrack03_F_EPA","LeadTrack03a_F_EPA","EventTrack01_F_EPA","EventTrack01a_F_EPA","EventTrack02_F_EPA","EventTrack02a_F_EPA","EventTrack03_F_EPA","EventTrack03a_F_EPA","LeadTrack01_F_EPB","LeadTrack01a_F_EPB","LeadTrack02_F_EPB","LeadTrack02a_F_EPB","LeadTrack02b_F_EPB","LeadTrack03_F_EPB","LeadTrack03a_F_EPB","LeadTrack04_F_EPB","EventTrack01_F_EPB","EventTrack01a_F_EPB","EventTrack02_F_EPB","EventTrack02a_F_EPB","EventTrack03_F_EPB","EventTrack04_F_EPB","EventTrack04a_F_EPB","EventTrack03a_F_EPB","AmbientTrack01_F_EPB","BackgroundTrack01_F_EPB","LeadTrack01_F_EPC","LeadTrack02_F_EPC","LeadTrack03_F_EPC","LeadTrack04_F_EPC","LeadTrack05_F_EPC","LeadTrack06_F_EPC","LeadTrack06b_F_EPC","EventTrack01_F_EPC","EventTrack02_F_EPC","EventTrack02b_F_EPC","EventTrack03_F_EPC","BackgroundTrack01_F_EPC","BackgroundTrack02_F_EPC","BackgroundTrack03_F_EPC","BackgroundTrack04_F_EPC","LeadTrack01_F_Bootcamp","LeadTrack01b_F_Bootcamp","LeadTrack02_F_Bootcamp","LeadTrack03_F_Bootcamp","LeadTrack01_F_Heli","LeadTrack01_F_Mark","LeadTrack02_F_Mark","LeadTrack03_F_Mark","LeadTrack01_F_EXP","LeadTrack01a_F_EXP","LeadTrack01b_F_EXP","LeadTrack01c_F_EXP","LeadTrack02_F_EXP","LeadTrack03_F_EXP","LeadTrack04_F_EXP","AmbientTrack01_F_EXP","AmbientTrack01a_F_EXP","AmbientTrack01b_F_EXP","AmbientTrack02_F_EXP","AmbientTrack02a_F_EXP","AmbientTrack02b_F_EXP","AmbientTrack02c_F_EXP","AmbientTrack02d_F_EXP","LeadTrack01_F_Jets","LeadTrack02_F_Jets","EventTrack01_F_Jets","LeadTrack01_F_Malden","LeadTrack02_F_Malden","LeadTrack01_F_Orange","AmbientTrack02_F_Orange","EventTrack01_F_Orange","EventTrack02_F_Orange","AmbientTrack01_F_Orange","LeadTrack01_F_Tacops","LeadTrack02_F_Tacops","LeadTrack03_F_Tacops","LeadTrack04_F_Tacops","AmbientTrack01a_F_Tacops","AmbientTrack01b_F_Tacops","AmbientTrack02a_F_Tacops","AmbientTrack02b_F_Tacops","AmbientTrack03a_F_Tacops","AmbientTrack03b_F_Tacops","AmbientTrack04a_F_Tacops","AmbientTrack04b_F_Tacops","EventTrack01a_F_Tacops","EventTrack01b_F_Tacops","EventTrack02a_F_Tacops","EventTrack02b_F_Tacops","EventTrack03a_F_Tacops","EventTrack03b_F_Tacops","Defcon","SkyNet","MAD","AmbientTrack03_F","BackgroundTrack01_F","Track01_Proteus","MainTheme_F_Tank","LeadTrack01_F_Tank","LeadTrack02_F_Tank","LeadTrack03_F_Tank","LeadTrack04_F_Tank","LeadTrack05_F_Tank","LeadTrack06_F_Tank","AmbientTrack01_F_Tank"]; publicVariable "TREND_ThemeAndIntroMusic";

if (isNil "TREND_AreasBlackList") then { TREND_AreasBlackList =  []; publicVariable "TREND_AreasBlackList"; };
if (!isNil "TREND_TopLeftPos") then {
	TREND_AreaLeft = [[(TREND_TopLeftPos select 0)-5000,TREND_TopLeftPos select 1,0],[TREND_TopLeftPos select 0,TREND_BotRightPos select 1,0]];
	TREND_AreaRight = [[TREND_BotRightPos select 0,TREND_TopLeftPos select 1,0],[(TREND_BotRightPos select 0) +5000,TREND_BotRightPos select 1,0]];
	TREND_AreaTop = [[(TREND_TopLeftPos select 0)-5000,(TREND_TopLeftPos select 1)+5000,0],[(TREND_BotRightPos select 0) +5000,TREND_TopLeftPos select 1,0]];
	TREND_AreaBottom = [[(TREND_TopLeftPos select 0)-5000,TREND_BotRightPos select 1,0],[(TREND_BotRightPos select 0) +5000,(TREND_BotRightPos select 1)-5000,0]];
	TREND_AreasBlackList = [TREND_AreaLeft,TREND_AreaRight,TREND_AreaTop,TREND_AreaBottom]; publicVariable "TREND_AreasBlackList";
};

true;