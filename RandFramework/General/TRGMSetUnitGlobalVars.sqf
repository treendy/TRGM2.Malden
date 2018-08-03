//#include "RandFramework\CustomMission\customMission.sqf";

_CustomMissionEnabled = false;
_MissionTitle = "";
call compile preprocessFileLineNumbers  "RandFramework\CustomMission\customMission.sqf";
call fnc_CustomVars;

bDebugMode = false;

DefaultEnemyFactionArray = [1,2,3];
DefaultEnemyFactionArrayText = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Enemy1",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Enemy2",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Enemy3"];
DefaultFriendlyFactionArray = [1,2];
DefaultFriendlyFactionArrayText = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Friend1",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Friend2"];

publicVariable "DefaultEnemyFactionArray";
publicVariable "DefaultEnemyFactionArrayText";

publicVariable "DefaultFriendlyFactionArray";
publicVariable "DefaultFriendlyFactionArrayText";

//[(configFile >> "CfgPatches"),1, true, true ] call BIS_fnc_returnChildren;
if ((isClass(configFile >> "CfgPatches" >> "rhs_main")) &&
		isClass(configFile >> "CfgPatches" >> "rhsusf_main") &&
		isClass(configFile >> "CfgPatches" >> "rhsgref_main")) then {
	//IF RHSAFRF, RHSUSAF, RHSGREF are active
	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [4];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["RHS - Russia MSV"];

	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [8];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["RHS - ChDKZ Insurgents"];

	DefaultFriendlyFactionArray = DefaultFriendlyFactionArray + [6];
	DefaultFriendlyFactionArrayText = DefaultFriendlyFactionArrayText + ["RHS Chernarus Ground Forces"];
};
if (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) then {
	//IF RHSUSAF is active
	DefaultFriendlyFactionArray = DefaultFriendlyFactionArray + [3];
	DefaultFriendlyFactionArrayText = DefaultFriendlyFactionArrayText + ["RHS USMC-F"];


};
if (isClass(configFile >> "CfgPatches" >> "CUP_Creatures_People_Core") &&
		isClass(configFile >> "CfgPatches" >> "CUP_AirVehicles_Core") &&
		isClass(configFile >> "CfgPatches" >> "CUP_Weapons_WeaponsCore") &&
		isClass(configFile >> "CfgPatches" >> "CUP_TrackedVehicles_Core") &&
		isClass(configFile >> "CfgPatches" >> "CUP_WaterVehicles_Core") &&
		isClass(configFile >> "CfgPatches" >> "CUP_WheeledVehicles_Core")) then {
	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [5];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["CUP - Takistan Army/Milita"];

	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [6];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["CUP - Takistan Army Only"];

	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [7];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["CUP - Takistan Milita Only"];

	DefaultFriendlyFactionArray = DefaultFriendlyFactionArray + [4];
	DefaultFriendlyFactionArrayText = DefaultFriendlyFactionArrayText + ["CUP UK MTP"];
	DefaultFriendlyFactionArray = DefaultFriendlyFactionArray + [5];
	DefaultFriendlyFactionArrayText = DefaultFriendlyFactionArrayText + ["CUP UK DDPM"];
	
};
if (isClass(configFile >> "CfgPatches" >> "UNS_Patches")) then {
	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [9];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["Unsung - VC 40th Battalion"];

	DefaultFriendlyFactionArray = DefaultFriendlyFactionArray + [7];
	DefaultFriendlyFactionArrayText = DefaultFriendlyFactionArrayText + ["Unsung US 25th 1968"];

};
if (isClass(configFile >> "CfgPatches" >> "UK3CB_BAF_Equipment") &&
		isClass(configFile >> "CfgPatches" >> "UK3CB_BAF_Vehicles") &&
		isClass(configFile >> "CfgPatches" >> "UK3CB_BAF_Weapons") &&
		isClass(configFile >> "CfgPatches" >> "UK3CB_BAF_Units_Common")) then {
	DefaultFriendlyFactionArray = DefaultFriendlyFactionArray + [8];
	DefaultFriendlyFactionArrayText = DefaultFriendlyFactionArrayText + ["3CB MTP"];

};


//example: AdvancedSettings select ADVSET_ENEMY_FACTIONS_IDX
ADVSET_VIRTUAL_ARSENAL_IDX = 0;
ADVSET_GROUP_NAME_IDX = 1;
ADVSET_SUPPORT_OPTION_IDX = 2;
ADVSET_RESPAWN_TICKET_COUNT_IDX = 3;
ADVSET_MAP_DRAW_DIRECT_ONLY_IDX = 4;
ADVSET_RESPAWN_TIMER_IDX = 5;
ADVSET_ENEMY_FACTIONS_IDX = 6;
ADVSET_FRIENDLY_LOADOUT_IDX = 7;
ADVSET_SANDSTORM_IDX = 8;
ADVSET_GROUP_MANAGE_IDX = 9;

//NOTE the id's must go up in twos!
AdvControls = [ //IDX,Title,Type,Options,OptionValues,DefaultOptionIndex(zero based index)
	[6001, localize "STR_TRGM2_TRGMSetUnitGlobalVars_VirtualArsenal","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1],
	[6003, localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupName","RscEdit",[""],"",1],
	[6005, localize "STR_TRGM2_TRGMSetUnitGlobalVars_SupportOptions","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0],
	[6007, localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTickets","RscCombo",["1","2","3","4","5","6","7","8","9","10",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Unlimited"],[1,2,3,4,5,6,7,8,9,10,99999],0],
	[6009, localize "STR_TRGM2_TRGMSetUnitGlobalVars_Mapdraw","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],0],
	[6011, localize "STR_TRGM2_TRGMSetUnitGlobalVars_RespawnTimer","RscCombo",["0 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","30 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sec","1 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","5 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","10 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min","20 " + localize "STR_TRGM2_TRGMSetUnitGlobalVars_Min"],[0,10,30,60,300,600,1200],1],
	[6013, localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFactions","RscCombo",DefaultEnemyFactionArrayText,DefaultEnemyFactionArray,DefaultEnemyFactionValue select 0],
	[6015, localize "STR_TRGM2_TRGMSetUnitGlobalVars_FriendlyFactions","RscCombo",DefaultFriendlyFactionArrayText,DefaultFriendlyFactionArray,DefaultFriendlyFactionValue select 0],
	[6017, localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm","RscCombo",[localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_Always",localize "STR_TRGM2_TRGMSetUnitGlobalVars_Never",localize "STR_TRGM2_TRGMSetUnitGlobalVars_SandStorm_5Hours"],[0,1,2,3],DefaultSandStormOption],
	[6019, localize "STR_TRGM2_TRGMSetUnitGlobalVars_GroupManagement","RscCombo",[localize "STR_TRGM2_TRGMInitPlayerLocal_Enable",localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"],[1,0],1]
];
DefaultAdvancedSettings = [0,"Tactical Cannon Fodder",1,1,1,10,DefaultEnemyFactionValue select 0,DefaultFriendlyFactionValue select 0,DefaultSandStormOption,0];


//0 = no, 1 = guarantee revive, 2 = realistic revive, 3 = realistic revive (only medics can revive)

//iUseRevive = ("OUT_par_UseRevive" call BIS_fnc_getParamValue);
if (isNil "iUseRevive") then {
	iUseRevive = 0;
	publicVariable "iUseRevive";
};
if (iUseRevive == 0) then {
	bUseRevive = false;
}
else
{
	bUseRevive = true;
};


BasicBuildings = ["Land_LightHouse_F","Land_Lighthouse_small_F","Land_Metal_Shed_F","Land_Offices_01_V1_F","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_Unfinished_Building_01_F","Land_Unfinished_Building_02_F","Land_d_House_Big_01_V1_F","Land_d_House_Big_02_V1_F","Land_d_House_Small_02_V1_F","Land_d_Stone_HouseBig_V1_F","Land_d_Stone_HouseSmall_V1_F","Land_d_Stone_Shed_V1_F","Land_dp_mainFactory_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V2_F","Land_i_Stone_HouseBig_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_u_House_Small_01_V1_F","Land_u_House_Small_02_V1_F","Land_cargo_house_slum_F","Land_jbad_House_1_old","Land_jbad_House_3_old","Land_jbad_House_4_old","Land_jbad_House_6_old","Land_jbad_House_7_old","Land_jbad_House_8_old","Land_jbad_House_9_old","Land_lbad_House_c_1_v2","Land_jbad_House_c_11","Land_jbad_House_c_1","Land_jbad_House_c_2","Land_jbad_House_c_3","Land_jbad_House_c_4","Land_jbad_House_c_5","Land_jbad_House_c_5_v1","Land_jbad_House_c_5_v2","Land_jbad_House_c_5_v3","Land_jbad_House_1","Land_jbad_House_3","Land_jbad_House_5","Land_jbad_House_6","Land_jbad_House_7","Land_jbad_House_8","Land_jbad_House2_basehide","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_12_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_L_8_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_L_1_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_jbad_House_1_old","Land_jbad_House_3_old","Land_jbad_House_4_old","Land_jbad_House_6_old","Land_jbad_House_7_old","Land_jbad_House_8_old","Land_jbad_House_9_old","Land_lbad_House_c_1_v2","Land_jbad_House_c_11","Land_jbad_House_c_1","Land_jbad_House_c_2","Land_jbad_House_c_3","Land_jbad_House_c_4","Land_jbad_House_c_5","Land_jbad_House_c_5_v1","Land_jbad_House_c_5_v2","Land_jbad_House_c_5_v3","Land_jbad_House_1","Land_jbad_House_3","Land_jbad_House_5","Land_jbad_House_6","Land_jbad_House_7","Land_jbad_House_8","Land_jbad_House2_basehide","Land_Shed_02_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_House_Small_04_F","Land_House_Small_05_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_House_Big_02_F","Land_House_Big_03_F","Land_House_Big_05_F","Land_Shed_05_F","Land_Shed_06_F","Land_Shed_07_F","Land_Addon_04_F","Land_Shop_City_03_F","Land_Shop_City_05_F","Land_Shop_City_06_F","Land_Shop_City_07_F","Land_House_Big_04_F","Land_House_Native_01_F","Land_House_Native_02_F","Land_House_Native_03_F","Land_House_Native_04_F","Land_House_Native_05_F","Land_House_Native_06_F","Land_blud_hut1","Land_blud_hut2","Land_blud_hut3","Land_blud_hut4","Land_blud_hut5","Land_blud_hut6","Land_blud_hut7","Land_blud_hut8","Land_MBG_GER_RHUS_5","Land_MBG_ATC_Base","Land_MBG_GER_RHUS_2","Land_MBG_GER_HUS_1","Land_MBG_ATC_Segment","Land_MBG_GER_RHUS_1","Land_MBG_GER_HUS_2","Land_MBG_GER_RHUS_3","Land_MBG_GER_RHUS_4","Objects17","Objects18","Objects19","Objects21","Objects22","Objects23","Land_deox_House_A1","Land_deox_House_A2","Land_deox_House_B1","Land_deox_House_B2","Land_deox_House_C1","Land_deox_House_C2","Land_deox_House_D_L1","Land_deox_House_D_L2","Land_deox_House_D_L3","Land_deox_House_D_L4","Land_deox_House_D_M1","Land_deox_House_D_M2","Land_deox_House_D_M3","Land_deox_House_D_M4","Land_deox_House_D_R1","Land_deox_House_D_R3","MBG_Killhouse_3_InEditor","MBG_Killhouse_4_InEditor","MBG_Killhouse_5_InEditor","MBG_Killhouse_2_InEditor","MBG_Killhouse_5_InEditor","MBG_Killhouse_1_InEditor","land_Objects101","land_Objects77","jbad_House_c_1","jbad_House_c_1_v2","jbad_House_c_10","jbad_House_c_11","jbad_House_c_12","jbad_House_c_2","jbad_House_c_3","jbad_House_c_4","jbad_House_c_5","jbad_House_c_5_v1","jbad_House_c_5_v2","jbad_House_c_5_v3","jbad_House_c_9","jbad_dum_istan2","jbad_dum_istan4","Jbad_A_Villa","jbad_House_3_old_h","Jbad_A_BuildingWIP","Jbad_Ind_Workshop01_L","Jbad_A_Stationhouse","Jbad_Mil_Barracks","Jbad_Mil_ControlTower","Jbad_Mil_Guardhouse","Jbad_Mil_House","jbad_mosque_big_addon","jbad_mosque_big_hq","Jbad_A_Mosque_small_1","Land_Jbad_A_Mosque_small_1","Jbad_A_Mosque_small_2","Land_HouseV_1I4","Land_HouseV2_02_Interier","Land_HouseV2_02_Interier_dam","Land_HouseV2_04_interier","Land_HouseV2_04_interier_dam","Land_Farm_Cowshed_a","Land_Farm_Cowshed_a_dam","Land_Farm_Cowshed_b","Land_Farm_Cowshed_b_dam","Land_Farm_Cowshed_c","Land_Farm_Cowshed_c_dam","Land_Barn_W_01","Land_Barn_W_01_dam","Land_Barn_W_02","Land_Shed_wooden","Land_Church_05R","Land_Church_03","Land_Church_03_dam","Land_Ind_Vysypka","Land_A_Castle_Bergfrit","Land_A_Castle_Bergfrit_dam","Land_A_Castle_Donjon","Land_A_Castle_Donjon_dam","Land_R_HouseV2_02","Land_R_HouseV2_04","Land_A_Office01","Land_A_Office02","Land_A_Pub_01","Land_HouseB_Tenement","Land_raz_hut04","Land_raz_hut07","LAND_uns_hut12","Land_raz_hut06","Land_raz_hut05","Land_raz_hut02","Land_raz_hut01","land_indo_hut_2","land_indo_hut_1","LAND_uns_covering2","Land_raz_hut08","Land_raz_hut03","LAND_uns_covering1","csj_temple1","LAND_CSJ_village6","LAND_CSJ_village5","LAND_csj_village8","LAND_CSJ_riverhut4","LAND_CSJ_riverhut3","LAND_CSJ_village7","LAND_CSJ_village4","LAND_CSJ_village1","LAND_CSJ_village2","LAND_CSJ_village3","LAND_CSJ_riverhut1","LAND_CSJ_riverhut1","LAND_CSJ_hut06","LAND_CSJ_hut05","Land_MBG_Hut_C","Land_MBG_Hut_B","LAND_csj_hut02","LAND_CSJ_hut07","LAND_csj_hut01","LAND_uns_hut08","Land_MBG_Hut_A","LAND_CSJ_Yard5","LAND_CSJ_Yard3","LAND_CSJ_Yard2","LAND_CSJ_Yard1","LAND_CSJ_Yard_pen1","LAND_CSJ_Yard_penGate","LAND_CSJ_Yard4","csj_shelter01","LAND_uns_hut2","LAND_uns_hut1","LAND_uns_hutraised1","LAND_uns_hutraised2","LAND_uns_platform1","LAND_uns_platform1fishnets","LAND_uns_platform1shelter2","LAND_uns_platform1shelter1","LAND_uns_villstorage_shelter","Land_WX_building001","Land_WX_building002","Land_wx_jap_headquarters","concretecover","Land_A_Office01_EP1","Land_dum_istan3_hromada2","Land_Farm_Cowshed_a","Land_Farm_Cowshed_b","Land_Farm_Cowshed_c","Land_Ind_Garage01","Land_House_C_10_dam_EP1","Land_House_C_10_EP1","Land_House_C_11_EP1_base","Land_House_C_11_EP1","Land_House_C_12_EP1","Land_House_C_12_EP1_base","Land_House_C_2_EP1","Land_House_C_4_EP1","Land_House_C_5_V1_EP1","Land_Shed_M01","Land_Shed_M03","Land_Shed_W01","Land_Shed_W02","Land_Shed_W03","Land_Shed_W4","Land_Shed_wooden","Land_i_Stone_Shed_01_b_raw_F","Land_i_Stone_Shed_01_b_raw_F","Land_House_K_2_basehide_EP1"];
MilBuildings = ["Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F","Land_Cargo_House_V3_F","Land_Cargo_House_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V1_F", "Land_MilOfficers_V1_F","Land_PillboxBunker_01_big_F","Land_PillboxBunker_01_hex_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_BagBunker_Tower_F","Land_Bunker_01_big_F","Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_BagBunker_01_large_green_F","Land_BagBunker_01_small_green_F","Land_HBarrier_01_tower_green_F","Land_fortified_nest_big","Land_fortified_nest_small","Fort_Nest","Land_Fort_Watchtower","Land_fortified_nest_big_EP1","Land_fortified_nest_small_EP1","Land_Fort_Watchtower_EP1","Land_Vil_Tower","LAND_uns_village_tower","LAND_uns_vctower1","LAND_uns_vctower2"];
TowerBuildings = ["Land_TTowerBig_2_F","Land_TTowerBig_1_F (towertest)","land_Objects96","Land_wx_radiomast","LAND_uns_signaltower"];//,"Land_TTowerSmall_2_F","Land_TTowerSmall_1_F"];  //these small towers are too small for Altis or Malden.. looks strange if this is the comms tower and nearby is a massive unused tower








sBreifing = "";
sAltisRegainEngine = "";
sScriptsUsed = localize "STR_TRGM2_TRGMSetUnitGlobalVars_ScriptsUsed";


//iWeather = ("OUT_par_WeatherAndTimeConditions" call BIS_fnc_getParamValue);
if (isNil "iWeather") then {
	iWeather = 1;
	publicVariable "iWeather";
};
if (iWeather == 1) then {WeatherOptions = [1,1,1,2,2,2,3,3,3,4,5,6,7,7,8,9,10];};
if (iWeather == 2) then {WeatherOptions = [1];};
if (iWeather == 3) then {WeatherOptions = [2];};
if (iWeather == 4) then {WeatherOptions = [3];};
if (iWeather == 5) then {WeatherOptions = [4]};
if (iWeather == 6) then {WeatherOptions = [5]};
if (iWeather == 7) then {WeatherOptions = [6]};
if (iWeather == 8) then {WeatherOptions = [7]};
if (iWeather == 9) then {WeatherOptions = [8]};
if (iWeather == 10) then {WeatherOptions = [9]};
if (iWeather == 11) then {WeatherOptions = [10]};
if (iWeather == 12) then {WeatherOptions = [11]};

iAllowMineField = 0; //("TREND_par_AllowMineField" call BIS_fnc_getParamValue);
if (iAllowMineField == 1) then {AllowMineField = True;};
if (iAllowMineField == 0) then {AllowMineField = False;};

iBuildingCountToAllowCivsAndFriendlyInformants = 10;
bFriendlyInsurgents = [false,true,false,false];
bCivsOnly = [false,false,false,false,false,false]; //all false at the moment... may never use this, but keep incase have idea!

PunishmentTimer = 1200;
PunishmentRadius = 1000; //if 0 will be no safezone


iAllowLargePat = 2; //("OUT_par_AllowLargePatrols" call BIS_fnc_getParamValue);
if (iAllowLargePat == 1) then {bAllowLargerPatrols = True;};
if (iAllowLargePat == 2) then {bAllowLargerPatrols = False;};
if (iAllowLargePat == 3) then {bAllowLargerPatrols = selectRandom[False,True];};

//1=Laptop  2=Steal data from research vehicle   3=Destroy Ammo Trucks
//4=Speak with informant    5=interrogate officer    6=Bug Radio
//7=Eliminate Officer     8=Assasinate weapon dealer    9=Destroy AAA vehicles
//10=Destroy Artillery vehicles 	11=Resue POW  12=Resue Reporter
//SideMissionTasks = [7];
SideMissionTasks = [1,2,3,4,5,6,7,8,9,10,11,12,99999];
//MainMissionTasks = [8];
MainMissionTasks = [1,2,6,7,8,11,12,99999];
MissionsThatHaveIntel = [1,4,5,6];


ChanceOfOccurance = [true,false,false,false];  //downed chopper,medical emergancy, downed convoy

//[year.month,day,hour,min]
Sunny = [2035, 1, 14, 12, 0];
DarkNight = [2035, 1, 15, 0, 0];
MoonNight = [2035, 11, 09, 23, 0];
EarlyMorning = [2035, 1, 14, 8, 15];

IntelShownType = [1,2,3,4];  //1=Mortar  2=AAA   3=commsTower	4=checkpoints
TowerRadius = 3500;

GridXOffSet = 0;  //to work this out, get vector21, mark pos at [0,0], the number for the X or Y is the offset, as it should be zero, so if not, we need to use this as an offset
GridYOffSet = 0;

MissionTypeDescriptions =[
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions1", //Heavy Mission (with two optional sides)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions1b", //Heavy Mission (two hidden optional sides)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions2", //Heavy Mission (Intel required for AO Location)
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions3", //Heavy Mission Only
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions4", //Single Mission
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions5", //Three Missions
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions5b", //Three Hidden Missions
localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeDescriptions6" //Campaign
];

MissionParamTypes = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName1",localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName1b",localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName2",localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName3",localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName4", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName5", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName5b", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MissionTypeName6"];
MissionParamTypesValues = [0,6,1,2,3,4,7,5];

MissionParamObjectives = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random",localize "STR_TRGM2_startInfMission_MissionTitle1",localize "STR_TRGM2_startInfMission_MissionTitle2",localize "STR_TRGM2_startInfMission_MissionTitle3",localize "STR_TRGM2_startInfMission_MissionTitle4",localize "STR_TRGM2_startInfMission_MissionTitle5",localize "STR_TRGM2_startInfMission_MissionTitle6",localize "STR_TRGM2_startInfMission_MissionTitle7",localize "STR_TRGM2_startInfMission_MissionTitle8",localize "STR_TRGM2_startInfMission_MissionTitle9",localize "STR_TRGM2_startInfMission_MissionTitle10",localize "STR_TRGM2_startInfMission_MissionTitle11",localize "STR_TRGM2_startInfMission_MissionTitle12"];
MissionParamObjectivesValues = [0,1,2,3,4,5,6,7,8,9,10,11,12];
if (_CustomMissionEnabled) then {
	MissionParamObjectives pushBack _MissionTitle; 
	MissionParamObjectivesValues pushBack 99999; 
};

MissionParamRepOptions = [localize "STR_TRGM2_TRGMInitPlayerLocal_Enable", localize "STR_TRGM2_TRGMInitPlayerLocal_Disable"];
MissionParamRepOptionsValues = [1, 0];

MissionParamWeatherOptions = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Sunny", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DaytimeHeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DaytimeAverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightClear", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightHeavyOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightAverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_EarlyMorning", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightClear", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightAverageOvercast", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightHeavyOvercast"];
MissionParamWeatherOptionsValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

MissionParamNVGOptions = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Real", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Allow", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NVG_NoAllow"];
MissionParamNVGOptionsValues = [2,1,0];

MissionParamReviveOptions = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_No", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Guarantee", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real1", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real2", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real3", localize "STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real4"];
MissionParamReviveOptionsValues = [0,1,2,3,4,5];

MissionParamLocationOptions = [localize "STR_TRGM2_TRGMSetUnitGlobalVars_Random", localize "STR_TRGM2_TRGMSetUnitGlobalVars_NearAO", localize "STR_TRGM2_TRGMSetUnitGlobalVars_MainHQ"];
MissionParamLocationOptionsValues = [2,1,0];

FastResponseCarItems=[[[["arifle_SDAR_F"],[10]],[["20Rnd_556x45_UW_mag"],[20]],[["G_B_Diving","V_RebreatherB","U_B_Wetsuit"],[10,10,10]],[[],[]]],false];

ThemeAndIntroMusic=["LeadTrack01_F_Curator","Fallout","Wasteland","AmbientTrack01_F","AmbientTrack01b_F","Track02_SolarPower","Track03_OnTheRoad","Track04_Underwater1","Track05_Underwater2","Track06_CarnHeli","Track07_ActionDark","Track08_Night_ambient","Track09_Night_percussions","Track10_StageB_action","Track11_StageB_stealth","Track12_StageC_action","Track13_StageC_negative","Track14_MainMenu","Track15_MainTheme","LeadTrack01_F_EPA","LeadTrack02_F_EPA","LeadTrack02a_F_EPA","LeadTrack02b_F_EPA","LeadTrack03_F_EPA","LeadTrack03a_F_EPA","EventTrack01_F_EPA","EventTrack01a_F_EPA","EventTrack02_F_EPA","EventTrack02a_F_EPA","EventTrack03_F_EPA","EventTrack03a_F_EPA","LeadTrack01_F_EPB","LeadTrack01a_F_EPB","LeadTrack02_F_EPB","LeadTrack02a_F_EPB","LeadTrack02b_F_EPB","LeadTrack03_F_EPB","LeadTrack03a_F_EPB","LeadTrack04_F_EPB","EventTrack01_F_EPB","EventTrack01a_F_EPB","EventTrack02_F_EPB","EventTrack02a_F_EPB","EventTrack03_F_EPB","EventTrack04_F_EPB","EventTrack04a_F_EPB","EventTrack03a_F_EPB","AmbientTrack01_F_EPB","BackgroundTrack01_F_EPB","LeadTrack01_F_EPC","LeadTrack02_F_EPC","LeadTrack03_F_EPC","LeadTrack04_F_EPC","LeadTrack05_F_EPC","LeadTrack06_F_EPC","LeadTrack06b_F_EPC","EventTrack01_F_EPC","EventTrack02_F_EPC","EventTrack02b_F_EPC","EventTrack03_F_EPC","BackgroundTrack01_F_EPC","BackgroundTrack02_F_EPC","BackgroundTrack03_F_EPC","BackgroundTrack04_F_EPC"
,"LeadTrack01_F_Bootcamp","LeadTrack01b_F_Bootcamp","LeadTrack02_F_Bootcamp","LeadTrack03_F_Bootcamp","LeadTrack01_F_Heli","LeadTrack01_F_Mark","LeadTrack02_F_Mark","LeadTrack03_F_Mark","LeadTrack01_F_EXP","LeadTrack01a_F_EXP","LeadTrack01b_F_EXP","LeadTrack01c_F_EXP","LeadTrack02_F_EXP","LeadTrack03_F_EXP","LeadTrack04_F_EXP","AmbientTrack01_F_EXP","AmbientTrack01a_F_EXP","AmbientTrack01b_F_EXP","AmbientTrack02_F_EXP","AmbientTrack02a_F_EXP","AmbientTrack02b_F_EXP","AmbientTrack02c_F_EXP","AmbientTrack02d_F_EXP","LeadTrack01_F_Jets","LeadTrack02_F_Jets","EventTrack01_F_Jets","LeadTrack01_F_Malden","LeadTrack02_F_Malden","LeadTrack01_F_Orange","AmbientTrack02_F_Orange","EventTrack01_F_Orange","EventTrack02_F_Orange","AmbientTrack01_F_Orange","LeadTrack01_F_Tacops","LeadTrack02_F_Tacops","LeadTrack03_F_Tacops","LeadTrack04_F_Tacops","AmbientTrack01a_F_Tacops","AmbientTrack01b_F_Tacops","AmbientTrack02a_F_Tacops","AmbientTrack02b_F_Tacops","AmbientTrack03a_F_Tacops","AmbientTrack03b_F_Tacops","AmbientTrack04a_F_Tacops","AmbientTrack04b_F_Tacops","EventTrack01a_F_Tacops","EventTrack01b_F_Tacops","EventTrack02a_F_Tacops","EventTrack02b_F_Tacops","EventTrack03a_F_Tacops","EventTrack03b_F_Tacops","Defcon","SkyNet","MAD","AmbientTrack03_F","BackgroundTrack01_F","Track01_Proteus","MainTheme_F_Tank","LeadTrack01_F_Tank","LeadTrack02_F_Tank","LeadTrack03_F_Tank","LeadTrack04_F_Tank","LeadTrack05_F_Tank","LeadTrack06_F_Tank","AmbientTrack01_F_Tank"];














/*=================================================================================================================================================================*/
/*==============================NOTE : all below are better to set in mission unique gobalVars file, they are only here as default=================================*/
/*=================================================================================================================================================================*/




EnemyRadioSounds = ["ambient_radio2","ambient_radio8","ambient_radio10","ambient_radio11","ambient_radio12","ambient_radio13","ambient_radio15","ambient_radio16","ambient_radio18","ambient_radio20","ambient_radio24"];
FriendlyRadioSounds = ["ambient_radio3","ambient_radio4","ambient_radio5","ambient_radio6","ambient_radio7","ambient_radio9","ambient_radio14","ambient_radio17","ambient_radio19","ambient_radio21","ambient_radio22","ambient_radio23","ambient_radio25","ambient_radio26","ambient_radio27","ambient_radio28","ambient_radio29","ambient_radio30"];



MedicalMessItems = ["MedicalGarbage_01_1x1_v1_F","MedicalGarbage_01_1x1_v2_F","MedicalGarbage_01_1x1_v3_F","MedicalGarbage_01_3x3_v1_F","MedicalGarbage_01_3x3_v2_F","MedicalGarbage_01_5x5_v1_F"];
MedicalBoxes = ["Land_PaperBox_01_small_closed_white_med_F","Land_FirstAidKit_01_open_F"];
ConesWithLight = ["RoadCone_L_F"];
Cones = ["RoadCone_F"];


	sFriendlyNVClassName = "NVGoggles";	
	sEnemyNVClassName = "NVGoggles_tna_F";  //"NVGoggles_OPFOR"	

	FriendlySide = West;
	EnemySide = East;
	FriendlySideString = "West";
	EnemySideString = "East";
	sArmaGroup = "TCF"; //use this to customise code for specific group requiments
	bNoVNChance = [false];

	civUniformClasses = ["U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poloshirt_redwhite"];

	UrbanIEDClassNames = ["IEDUrbanBig_F","ACE_IEDUrbanBig_Range","IEDUrbanSmall_F"];
	IEDClassNames = ["IEDUrbanBig_F","IEDLandBig_F","ACE_IEDUrbanBig_Range","IEDUrbanSmall_F"];
	IEDFakeClassNames = ["Land_GarbagePallet_F","Land_JunkPile_F"];
	ATMinesClassNames = ["ATMine"];
	WreckCarClasses = ["Land_Wreck_Slammer_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Offroad2_F","Land_Wreck_Car3_F","Land_Wreck_Truck_F"];
	ChopperWrecks = ["Land_Wreck_Heli_Attack_01_F"];

	ReinforceStartPos1 = [200,200,0];
	ReinforceStartPos2 = [100,100,0];

	SideMissionMinDistFromBase = 3000; //for min distached to have AO from base... BaseAreaRange is more for patrols and events (thees need to be seperate variables, because if we had main HQ on an island and an AO spawned on the small island away from main land... hen will cause issues spawning in everything else)
	KilledZoneRadius = 1500;
	KilledZoneInnerRadius = 1450;
	SaveZoneRadius = 1000; //if 0 will be no safezone

	GraveYardPos = [799.305,12129.2,1.90735e-006];
	GraveYardDirection = 90;
	TombStones = ["Land_Tombstone_01_F","Land_Tombstone_03_F","Land_Tombstone_02_F"];
	InformantImage = "<img image='RandFramework\Media\Informants2.jpg' size='1' />";
	OfficerImage = "<img image='RandFramework\Media\Officer2.jpg' size='1' />";
	WeaponDealerImage = "<img image='RandFramework\Media\WeaponDealers2.jpg' size='1' />";


	/*Consider thees three variables...allow set content of crate!!!*/
	//InitialBoxItems=[[[["hgun_P07_F","hgun_P07_khk_F","hgun_P07_snds_F","arifle_MX_F","arifle_MX_khk_F","arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_MXM_Black_F","arifle_MXM_khk_F"],[50,50,50,50,50,50,50,50,50,50,50]],[["APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag","200Rnd_556x45_Box_Tracer_F","20Rnd_650x39_Cased_Mag_F","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","150Rnd_762x54_Box_Tracer","10Rnd_762x54_Mag","150Rnd_762x54_Box","20Rnd_762x51_Mag","10Rnd_9x21_Mag","16Rnd_9x21_green_Mag","10Rnd_93x64_DMR_05_Mag","150Rnd_93x64_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","RPG7_F","RPG32_HE_F","RPG32_F","Titan_AA","Titan_AP","Titan_AT"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["ItemCompass","ItemMap","ItemWatch","optic_Hamr","optic_Hamr_khk_F"],[50,50,50,50,50]],[[],[]]],false];
	//InitialBoxItemsWithAce=[[[["ACE_VMH3","ACE_VMM3","hgun_P07_F","hgun_P07_khk_F","hgun_P07_snds_F","arifle_MX_F","arifle_MX_khk_F","arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_MXM_Black_F","arifle_MXM_khk_F"],[50,50,50,50,50,50,50,50,50,50,50,50,50]],[["APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ACE_10Rnd_338_300gr_HPBT_Mag","ACE_10Rnd_338_API526_Mag","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag","150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","200Rnd_556x45_Box_Red_F","200Rnd_556x45_Box_F","200Rnd_556x45_Box_Tracer_Red_F","200Rnd_556x45_Box_Tracer_F","20Rnd_650x39_Cased_Mag_F","100Rnd_65x39_caseless_mag","ACE_100Rnd_65x39_caseless_mag_Tracer_Dim","100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","ACE_200Rnd_65x39_cased_Box_Tracer_Dim","30Rnd_65x39_caseless_mag","ACE_30Rnd_65x39_caseless_mag_Tracer_Dim","30Rnd_65x39_caseless_mag_Tracer","ACE_20Rnd_65_Creedmor_mag","ACE_20Rnd_65x47_Scenar_mag","150Rnd_762x54_Box_Tracer","10Rnd_762x54_Mag","150Rnd_762x54_Box","20Rnd_762x51_Mag","ACE_20Rnd_762x67_Berger_Hybrid_OTM_Mag","ACE_20Rnd_762x51_M118LR_Mag","ACE_20Rnd_762x51_M993_AP_Mag","ACE_20Rnd_762x67_Mk248_Mod_0_Mag","ACE_20Rnd_762x67_Mk248_Mod_1_Mag","ACE_20Rnd_762x51_Mk316_Mod_0_Mag","ACE_20Rnd_762x51_Mk319_Mod_0_Mag","ACE_20Rnd_762x51_Mag_SD","ACE_20Rnd_762x51_Mag_Tracer_Dim","ACE_20Rnd_762x51_Mag_Tracer","ACE_10Rnd_762x54_Tracer_mag","10Rnd_9x21_Mag","16Rnd_9x21_green_Mag","10Rnd_93x64_DMR_05_Mag","150Rnd_93x64_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","RPG7_F","RPG32_HE_F","RPG32_F","Titan_AA","Titan_AP","Titan_AT"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["ACE_RangeTable_82mm","ACE_adenosine","ACE_ATragMX","ACE_atropine","ACE_Banana","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bodyBag","ACE_CableTie","ItemCompass","ACE_DAGR","ACE_DefusalKit","ACE_EarPlugs","ACE_EntrenchingTool","ACE_epinephrine","ACE_Flashlight_MX991","ACE_Kestrel4500","ACE_Flashlight_KSF1","ACE_M26_Clacker","ACE_Clacker","ACE_Flashlight_XL50","ItemMap","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_RangeCard","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_Sandbag_empty","ACE_Tripod","ACE_surgicalKit","ACE_tourniquet","ACE_VectorDay","ItemWatch","ACE_wirecutter","optic_Hamr","ACE_optic_Hamr_2D","optic_Hamr_khk_F","ACE_optic_Hamr_PIP","tf_anprc152","tf_anprc154"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["tf_rt1523g","tf_rt1523g_big"],[50,50]]],false];

	InitialBoxItems=[[[[],[]],[["SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShell"],[20,20,20,20,20]],[["ItemCompass","ItemMap","ItemWatch"],[5,5,5]],[[],[]]],false];
	InitialBoxItemsWithAce=[[[["ACE_VMH3","ACE_VMM3"],[5,5]],[["DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShell"],[5,5,20,20,20,20,20]],[["ACE_RangeTable_82mm","ACE_adenosine","ACE_ATragMX","ACE_atropine","ACE_Banana","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bodyBag","ACE_CableTie","ItemCompass","ACE_DAGR","ACE_DefusalKit","ACE_EarPlugs","ACE_EntrenchingTool","ACE_epinephrine","ACE_Flashlight_MX991","ACE_Kestrel4500","ACE_Flashlight_KSF1","ACE_M26_Clacker","ACE_Clacker","ACE_Flashlight_XL50","ItemMap","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_RangeCard","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_Sandbag_empty","ACE_Tripod","ACE_surgicalKit","ACE_tourniquet","ACE_VectorDay","ItemWatch","ACE_wirecutter","tf_anprc152","tf_anprc154"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["tf_rt1523g","tf_rt1523g_big"],[3,3]]],false];
	
	/*Unit class names*/

	CampaignRecruitUnitRifleman = "B_Soldier_F";
	CampaignRecruitUnitAT = "B_soldier_AT_F";
	CampaignRecruitUnitAA = "B_soldier_AA_F";
	CampaignRecruitUnitExplosiveSpecialist = "B_soldier_exp_F";
	CampaignRecruitUnitMedic = "B_medic_F";
	CampaignRecruitUnitEngineer = "B_engineer_F";
	CampaignRecruitUnitAuto = "B_soldier_AR_F";
	CampaignRecruitUnitSniper = "B_sniper_F";
	CampaignRecruitUnitSpotter = "B_spotter_F";
	CampaignRecruitUnitUAV = "B_soldier_UAV_F";

	SmallTransportVehicle = ["B_Quadbike_01_F"]; //used for AO camp, just incase no vehicles near, or too built up in jungle for cars
	FriendlyFastResponseDingy = ["B_Boat_Transport_01_F"];

	BaseAreaRange = 1500; //used to make sure enemy events, patrols etc... doesnt spawn too close to base
/*=================================================================================================================================================================*/
/*=================================================================================================================================================================*/
/*=================================================================================================================================================================*/
