bDebugMode = false;

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


BasicBuildings = ["Land_LightHouse_F","Land_Lighthouse_small_F","Land_Metal_Shed_F","Land_Offices_01_V1_F","Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_Unfinished_Building_01_F","Land_Unfinished_Building_02_F","Land_d_House_Big_01_V1_F","Land_d_House_Big_02_V1_F","Land_d_House_Small_01_V1_F","Land_d_House_Small_02_V1_F","Land_d_Stone_HouseBig_V1_F","Land_d_Stone_HouseSmall_V1_F","Land_d_Stone_Shed_V1_F","Land_dp_mainFactory_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_i_House_Small_01_V3_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_i_House_Small_03_V1_F","Land_i_Stone_HouseBig_V1_F","Land_i_Stone_HouseBig_V2_F","Land_i_Stone_HouseBig_V3_F","Land_i_Stone_HouseSmall_V1_F","Land_i_Stone_HouseSmall_V2_F","Land_i_Stone_HouseSmall_V3_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_u_House_Small_01_V1_F","Land_u_House_Small_02_V1_F","Land_cargo_house_slum_F","Land_jbad_House_1_old","Land_jbad_House_3_old","Land_jbad_House_4_old","Land_jbad_House_6_old","Land_jbad_House_7_old","Land_jbad_House_8_old","Land_jbad_House_9_old","Land_lbad_House_c_1_v2","Land_jbad_House_c_11","Land_jbad_House_c_1","Land_jbad_House_c_2","Land_jbad_House_c_3","Land_jbad_House_c_4","Land_jbad_House_c_5","Land_jbad_House_c_5_v1","Land_jbad_House_c_5_v2","Land_jbad_House_c_5_v3","Land_jbad_House_1","Land_jbad_House_3","Land_jbad_House_5","Land_jbad_House_6","Land_jbad_House_7","Land_jbad_House_8","Land_jbad_House2_basehide","Land_House_C_5_EP1","Land_House_C_5_V1_EP1","Land_House_C_5_V2_EP1","Land_House_C_5_V3_EP1","Land_House_C_12_EP1","Land_House_K_1_EP1","Land_House_K_3_EP1","Land_House_K_5_EP1","Land_House_L_8_EP1","Land_House_K_6_EP1","Land_House_K_7_EP1","Land_House_K_8_EP1","Land_House_L_1_EP1","Land_House_L_4_EP1","Land_House_L_6_EP1","Land_House_L_7_EP1","Land_House_L_8_EP1","Land_jbad_House_1_old","Land_jbad_House_3_old","Land_jbad_House_4_old","Land_jbad_House_6_old","Land_jbad_House_7_old","Land_jbad_House_8_old","Land_jbad_House_9_old","Land_lbad_House_c_1_v2","Land_jbad_House_c_11","Land_jbad_House_c_1","Land_jbad_House_c_2","Land_jbad_House_c_3","Land_jbad_House_c_4","Land_jbad_House_c_5","Land_jbad_House_c_5_v1","Land_jbad_House_c_5_v2","Land_jbad_House_c_5_v3","Land_jbad_House_1","Land_jbad_House_3","Land_jbad_House_5","Land_jbad_House_6","Land_jbad_House_7","Land_jbad_House_8","Land_jbad_House2_basehide","Land_Shed_02_F","Land_House_Small_02_F","Land_House_Small_03_F","Land_House_Small_04_F","Land_House_Small_05_F","Land_House_Small_06_F","Land_House_Big_01_F","Land_House_Big_02_F","Land_House_Big_03_F","Land_House_Big_05_F","Land_Shed_05_F","Land_Shed_06_F","Land_Shed_07_F","Land_Addon_04_F","Land_Shop_City_03_F","Land_Shop_City_05_F","Land_Shop_City_06_F","Land_Shop_City_07_F","Land_House_Big_04_F","Land_House_Native_01_F","Land_House_Native_02_F","Land_House_Native_03_F","Land_House_Native_04_F","Land_House_Native_05_F","Land_House_Native_06_F","Land_blud_hut1","Land_blud_hut2","Land_blud_hut3","Land_blud_hut4","Land_blud_hut5","Land_blud_hut6","Land_blud_hut7","Land_blud_hut8","Land_MBG_GER_RHUS_5","Land_MBG_ATC_Base","Land_MBG_GER_RHUS_2","Land_MBG_GER_HUS_1","Land_MBG_ATC_Segment","Land_MBG_GER_RHUS_1","Land_MBG_GER_HUS_2","Land_MBG_GER_RHUS_3","Land_MBG_GER_RHUS_4","Objects17","Objects18","Objects19","Objects21","Objects22","Objects23","Land_deox_House_A1","Land_deox_House_A2","Land_deox_House_B1","Land_deox_House_B2","Land_deox_House_C1","Land_deox_House_C2","Land_deox_House_D_L1","Land_deox_House_D_L2","Land_deox_House_D_L3","Land_deox_House_D_L4","Land_deox_House_D_M1","Land_deox_House_D_M2","Land_deox_House_D_M3","Land_deox_House_D_M4","Land_deox_House_D_R1","Land_deox_House_D_R3","MBG_Killhouse_3_InEditor","MBG_Killhouse_4_InEditor","MBG_Killhouse_5_InEditor","MBG_Killhouse_2_InEditor","MBG_Killhouse_5_InEditor","MBG_Killhouse_1_InEditor","land_Objects101","land_Objects77","jbad_House_c_1","jbad_House_c_1_v2","jbad_House_c_10","jbad_House_c_11","jbad_House_c_12","jbad_House_c_2","jbad_House_c_3","jbad_House_c_4","jbad_House_c_5","jbad_House_c_5_v1","jbad_House_c_5_v2","jbad_House_c_5_v3","jbad_House_c_9","jbad_dum_istan2","jbad_dum_istan4","Jbad_A_Villa","jbad_House_3_old_h","Jbad_A_BuildingWIP","Jbad_Ind_Workshop01_L","Jbad_A_Stationhouse","Jbad_Mil_Barracks","Jbad_Mil_ControlTower","Jbad_Mil_Guardhouse","Jbad_Mil_House","jbad_mosque_big_addon","jbad_mosque_big_hq","Jbad_A_Mosque_small_1","Land_Jbad_A_Mosque_small_1","Jbad_A_Mosque_small_2"];	
MilBuildings = ["Land_Cargo_Patrol_V1_F", "Land_Cargo_Patrol_V3_F", "Land_Cargo_HQ_V3_F", "Land_Cargo_HQ_V1_F","Land_Cargo_House_V3_F","Land_Cargo_House_V1_F", "Land_Cargo_Tower_V3_F", "Land_Cargo_Tower_V1_F", "Land_MilOfficers_V1_F","Land_PillboxBunker_01_big_F","Land_PillboxBunker_01_hex_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_BagBunker_Tower_F","Land_Bunker_01_big_F","Land_Bunker_01_HQ_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F","Land_BagBunker_01_large_green_F","Land_BagBunker_01_small_green_F","Land_HBarrier_01_tower_green_F","Land_fortified_nest_big","Land_fortified_nest_small","Fort_Nest","Land_Fort_Watchtower","Land_fortified_nest_big_EP1","Land_fortified_nest_small_EP1","Land_Fort_Watchtower_EP1"];	
TowerBuildings = ["Land_TTowerBig_2_F","land_Objects96","Land_TTowerSmall_2_F","Land_TTowerSmall_1_F"];

sBreifing = "Point system (check notice board at base for point limit for current mission): <br /> 0.10 - Fire Arti<br /> 0.20 - Lose littlebirds<br /> 2.00 - Lose Comanche<br /> 2.00 - Lose jets<br /> 2.00 - Lose wipeout<br /> 1.50 - Lose armed ghost hawlks<br /> 1.00 - Lose Huron (unarmed)<br /> 1.50 - Lose pawnee<br /> 0.80 - Lose armed prowler<br /> 1.00 - APC<br /> 1.80 - Lose tank<br /> 2.50 - Lose Arti<br /> 1.00 - Lose armed boat";
sAltisRegainEngine = "";
sScriptsUsed = "";


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
bFriendlyInsurgents = [false,true,false];
bCivsOnly = [true,false,false,false,false,false];

PunishmentTimer = 1200;
PunishmentRadius = 3000; //if 0 will be no safezone


iAllowLargePat = 2; //("OUT_par_AllowLargePatrols" call BIS_fnc_getParamValue);
if (iAllowLargePat == 1) then {bAllowLargerPatrols = True;};
if (iAllowLargePat == 2) then {bAllowLargerPatrols = False;};
if (iAllowLargePat == 3) then {bAllowLargerPatrols = selectRandom[False,True];};

//1=Laptop  2=Steal data from research vehicle   3=Destroy Ammo Trucks   
//4=Speak with informant    5=interrogate officer    6=Bug Radio
//7=Eliminate Officer     8=Assasinate weapon dealer    9=Destroy AAA vehicles
//10=Destroy Artillery vehicles
//SideMissionTasks = [7];
SideMissionTasks = [1,2,3,4,5,6,7,8,9,10];
//MainMissionTasks = [8];
MainMissionTasks = [1,2,4,6,7,8];
MissionsThatHaveIntel = [1,4,5,6];


ChanceOfOccurance = [true,false];  //camp, downed chopper

//[year.month,day,hour,min]
Sunny = [2035, 1, 14, 12, 0];
DarkNight = [2035, 1, 15, 0, 0];
MoonNight = [2035, 11, 09, 23, 0];
EarlyMorning = [2035, 1, 14, 8, 15];

IntelShownType = [1,2,3];  //1=Mortar  2=AAA   3=commsTower
TowerRadius = 3500;

GridXOffSet = 0;  //to work this out, get vector21, mark pos at [0,0], the number for the X or Y is the offset, as it should be zero, so if not, we need to use this as an offset
GridYOffSet = 0;

MissionTypeDescriptions = 
[
"This is the default mission type.  There will be one main objective that is occupied by a heavy enemy army.\n\nYou will also have two optional mini missions, these mini missions will either give you intel on the main AO, or will help increase your reputation depending on the mission type.", 
"One main objective that is occupied by a heavy enemy army\n\nThere will be two mini missions, one will give you intel on the main location of the AO, be careful, as there is always a possiblity that the objective could be in the middle of the main AO!.\n\nThe other mini mission could be intel or may increase your reputation.",
"One main objective that is occupied by a heavy enemy army, no mini missions or intel required",
"A single mini mission.\n\nThese mini missions could be very low enemy, high enemy, be aware that the area may be occupied by friendly rebels! or jsut a large civilian population (watch out though, some civs may be enemy undercover, or a freindly rebel may also be an enemy undercover!).",
"Three mini missions.\n\nIf you select the type of mission below, all three will be the same, could be ideal for practicing the mini mission types, or you may want to have three HVTs to takeout.\n\nThese mini missions could be very low enemy, high enemy, be aware that the area may be occupied by friendly rebels! or jsut a large civilian population (watch out though, some civs may be enemy undercover, or a freindly rebel may also be an enemy undercover!).",
"!Under construction!! You will start with 5 reputation, your aim is to work hard and become a highly reputable unit.  The higher your reputation the better equipment high command will allow you to use, however, losing these in battle will lower your reputation, also killing civs, losing units and other assets, killing friendly rebels and any other mistake will lower your reputation.\n\nIf you manage to get a high enough reputation(15 points), high command will assign a final heavy objective!"
];

MissionParamTypes = ["Main Mission (with two optional sides)","Main Mission (Intel required for AO Location)","Main Mission Only","Single Mini Mission", "Three Mini Missions", "Campaign"];
MissionParamTypesValues = [0,1,2,3,4,5];

MissionParamObjectives = ["Random","Hack Data","Steal data from research vehicle","Destroy Ammo Trucks","Speak with informant","interrogate officer","Transmit Enemy Comms to HQ","Eliminate Officer","Assasinate weapon dealer","Destroy AAA vehicles","Destroy Artillery vehicles"];
MissionParamObjectivesValues = [0,1,2,3,4,5,6,7,8,9,10];

MissionParamRepOptions = ["Enabled", "Disabled"];
MissionParamRepOptionsValues = [1, 0];

MissionParamWeatherOptions = ["Random", "Sunny Clear", "Daytime Heavy Overcast", "Day average Overcast", "Dark Night Clear", "Dark Night Heavy Overcast", "Dark Night Average overcast", "Early Morning", "Moon Night Clear", "Moon Night slight overcast", "Moon Night heavy overcast"];
MissionParamWeatherOptionsValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

MissionParamNVGOptions = ["Realistic NVG", "Allowed", "No NVG"];
MissionParamNVGOptionsValues = [2,1,0]; 

MissionParamReviveOptions = ["No revive", "Guarantee revive", "Realistic revive (critical hits will kill you instantly)", "Realistic revive (only medics can revive with a medkit)"];
MissionParamReviveOptionsValues = [0,1,2,3];
