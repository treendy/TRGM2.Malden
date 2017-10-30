#include "RandFramework\General\TRGMSetUnitGlobalVars.sqf";


sFriendlyNVClassName = "NVGoggles";	
sEnemyNVClassName = "NVGoggles_tna_F";  //"NVGoggles_OPFOR"	
FriendlySide = West;
EnemySide = East;
FriendlySideString = "West";
EnemySideString = "East";
sArmaGroup = "TCF"; //use this to customise code for specific group requiments

sTargetLeader = "O_officer_F";
sRifleman = "O_T_Soldier_F";
sATMan = "O_T_Soldier_LAT_F";
sAAMan = "O_T_Soldier_AA_F";
sAAAVeh = "O_T_APC_Tracked_02_AA_ghex_F";
//sAirSup1 = "O_Plane_CAS_02_F";
//sAirSup2 = "O_T_VTOL_02_infantry_F"; //This would normally be a chopper
sSniper = "O_T_Sniper_F";
sMachineGunMan = "O_T_Soldier_AR_F";
sCivilian = "C_man_polo_1_F";
sArtilleryVeh = "O_T_MBT_02_arty_ghex_F";
sTank1ArmedCar = "O_T_LSV_02_armed_F";
sTank2APC = "O_T_APC_Wheeled_02_rcws_ghex_F";
sTank3Tank = "O_T_MBT_02_cannon_ghex_F";
sBoatUnit = "O_T_Boat_Armed_01_hmg_F";
sTeamleader = "O_T_Soldier_TL_F";
sAmmobearer = "O_T_Soldier_A_F";
sGrenadier = "O_T_Soldier_GL_F";
sMedic = "O_T_Medic_F";
sExpSpec = "O_T_Soldier_Exp_F"; 
sTeamleaderUrban = "O_T_Soldier_TL_F";
sAAManUrban = "O_T_Soldier_AA_F";
sATManUrban = "O_T_Soldier_LAT_F";
sMachineGunManUrban = "O_T_Soldier_AR_F";
sRiflemanUrban = "O_T_Soldier_F";
sAmmobearerUrban = "O_T_Soldier_A_F";
sGrenadierUrban = "O_T_Soldier_GL_F";
sMedicUrban = "O_T_Medic_F";
sEnemyHeliPilot = "O_helipilot_F";
sWarloadSideMission = "O_G_officer_F";

sTeamleaderFriendInsurg = "O_G_Soldier_TL_F";
sRiflemanFriendInsurg = "O_G_Soldier_F";
sTank1ArmedCarFriendInsurg = "O_G_Offroad_01_armed_F";
sTank2APCFriendInsurg = "O_G_Offroad_01_armed_F";
sTank3TankFriendInsurg = "O_G_Offroad_01_armed_F";
sAAAVehFriendInsurg = "";
sAmmobearerFriendInsurg = "O_G_Soldier_A_F";
sGrenadierFriendInsurg = "O_G_Soldier_GL_F";
sMedicFriendInsurg = "O_G_medic_F";
sAAManFriendInsurg = "O_G_Soldier_LAT_F";
sATManFriendInsurg = "O_G_Soldier_LAT_F";


InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
civUniformClasses = ["U_C_Poloshirt_stripped","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poloshirt_redwhite"];
SideRadioClassNames = ["Land_PortableGenerator_01_F"];
UrbanIEDClassNames = ["IEDUrbanBig_F","ACE_IEDUrbanBig_Range","IEDUrbanSmall_F"];
IEDClassNames = ["IEDUrbanBig_F","IEDLandBig_F","ACE_IEDUrbanBig_Range","IEDUrbanSmall_F"];
IEDFakeClassNames = ["Land_GarbagePallet_F","Land_JunkPile_F"];
ATMinesClassNames = ["ATMine"];
WreckCarClasses = ["Land_Wreck_Slammer_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Offroad2_F","Land_Wreck_Car3_F","Land_Wreck_Truck_F"];

bNoVNChance = [false];

ReinforceVehicle = "O_T_VTOL_02_infantry_F";
ReinforceStartPos1 = [200,200,0];
ReinforceStartPos2 = [100,100,0];

SideMissionMinDistFromBase = 3000;
KilledZoneRadius = 1500;
KilledZoneInnerRadius = 1450;
SaveZoneRadius = 1000; //if 0 will be no safezone


WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
ChopperWrecks = ["Land_Wreck_Heli_Attack_01_F"];

sideResarchTruck = ["O_Truck_03_device_F"];
sideAmmoTruck = ["O_Truck_03_ammo_F"];
EnemyAirToAirSupports = ["O_Plane_Fighter_02_F"];
EnemyAirToGroundSupports = ["O_Plane_CAS_02_dynamicLoadout_F","O_Plane_CAS_02_F","O_T_VTOL_02_infantry_F","O_Heli_Attack_02_dynamicLoadout_F"]; //This would normally be a chopper
EnemyAirScout = ["O_UAV_02_dynamicLoadout_F"];
sMortar = ["O_Mortar_01_F"];
sMortarFriendInsurg = ["O_G_Mortar_01_F"];






UnarmedScoutVehicles = ["O_MRAP_02_F","O_G_Offroad_01_F","O_G_Van_01_transport_F","O_G_Van_02_vehicle_F"];
FriendlyScoutVehicles = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F"];
sMachineGunManFriendInsurg = "O_G_Soldier_AR_F";
EnemyBaseChoppers = ["O_T_VTOL_02_infantry_F"];








