
WoundedSounds = ["WoundedGuyA_01","WoundedGuyA_02","WoundedGuyA_03","WoundedGuyA_04","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_07","WoundedGuyA_08","WoundedGuyB_01","WoundedGuyB_02","WoundedGuyB_03","WoundedGuyB_04","WoundedGuyB_05","WoundedGuyB_06","WoundedGuyB_07","WoundedGuyB_08","WoundedGuyC_01","WoundedGuyC_02","WoundedGuyC_03","WoundedGuyC_04","WoundedGuyC_05"];
CivCars = ["C_Hatchback_01_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Truck_02_transport_F"];
sCivilian = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
HVTCars = ["C_SUV_01_F","C_Hatchback_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Hatchback_01_sport_F"];
HVTVans = ["C_Van_02_vehicle_F","C_Van_02_transport_F","C_Truck_02_covered_F","C_Van_01_box_F"];
HVTChoppers = ["C_Heli_Light_01_civil_F"];
HVTPlanes = ["C_Plane_Civil_01_F"];




//DEFAULTS (over written below)






switch (AdvancedSettings select ADVSET_ENEMY_FACTIONS_IDX) do {
	case 1 : {

sTeamleader = "O_T_Soldier_TL_F";
sRifleman = "O_T_Soldier_F";
sATMan = "O_T_Soldier_LAT_F";
sAAMan = "O_T_Soldier_AA_F";
sAmmobearer = "O_T_Soldier_A_F";
sGrenadier = "O_T_Soldier_GL_F";
sMedic = "O_T_Medic_F";
sMachineGunMan = "O_T_Soldier_AR_F";
sTank1ArmedCar = "O_T_LSV_02_armed_F";
sTank2APC = "O_T_APC_Wheeled_02_rcws_ghex_F";
sTank3Tank = "O_T_MBT_02_cannon_ghex_F";
sAAAVeh = "O_T_APC_Tracked_02_AA_ghex_F";
sMortar = ["O_Mortar_01_F"];
sSniper = "O_T_Sniper_F";
//sCivilian = ["C_man_polo_1_F"];
sArtilleryVeh = "O_T_MBT_02_arty_ghex_F";
sBoatUnit = "O_T_Boat_Armed_01_hmg_F";		
sExpSpec = "O_T_Soldier_Exp_F"; 		

sTeamleaderMilitia = "O_G_Soldier_TL_F";
sRiflemanMilitia = "O_G_Soldier_F";
sATManMilitia = "O_G_Soldier_LAT_F";
sAAManMilitia = "O_G_Soldier_LAT_F";	
sAmmobearerMilitia = "O_G_Soldier_A_F";
sGrenadierMilitia = "O_G_Soldier_GL_F";
sMedicMilitia = "O_G_medic_F";
sMachineGunManMilitia = "O_G_Soldier_AR_F";
sTank1ArmedCarMilitia = "O_G_Offroad_01_armed_F";
sTank2APCMilitia = "O_G_Offroad_01_armed_F";
sTank3TankMilitia = "O_G_Offroad_01_armed_F";
sAAAVehMilitia = "";
sMortarMilitia = ["O_G_Mortar_01_F"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["O_Truck_03_device_F"];
SideRadioClassNames = ["Land_PortableGenerator_01_F"];
sideAmmoTruck = ["O_Truck_03_ammo_F"];
DestroyAAAVeh = ["O_T_APC_Tracked_02_AA_ghex_F"];

sRiflemanFriendInsurg = "B_G_Soldier_F";

ReinforceVehicle = "O_T_VTOL_02_infantry_F";
EnemyAirToAirSupports = ["O_Plane_Fighter_02_F"];
EnemyAirToGroundSupports = ["O_Plane_CAS_02_dynamicLoadout_F","O_Plane_CAS_02_F","O_T_VTOL_02_infantry_F","O_Heli_Attack_02_dynamicLoadout_F"]; //This would normally be a chopper
EnemyAirScout = ["O_UAV_02_dynamicLoadout_F"];

UnarmedScoutVehicles = ["O_MRAP_02_F","O_G_Offroad_01_F","O_G_Van_01_transport_F","O_G_Van_02_vehicle_F"];
EnemyBaseChoppers = ["O_T_VTOL_02_infantry_F"];
sEnemyHeliPilot = "O_helipilot_F";
	};
	case 2 : {

		sTeamleader = "O_T_Soldier_TL_F";
		sRifleman = "O_T_Soldier_F";
		sATMan = "O_T_Soldier_LAT_F";
		sAAMan = "O_T_Soldier_AA_F";
		sAmmobearer = "O_T_Soldier_A_F";
		sGrenadier = "O_T_Soldier_GL_F";
		sMedic = "O_T_Medic_F";
		sMachineGunMan = "O_T_Soldier_AR_F";
		sTank1ArmedCar = "O_T_LSV_02_armed_F";
		sTank2APC = "O_T_APC_Wheeled_02_rcws_ghex_F";
		sTank3Tank = "O_T_MBT_02_cannon_ghex_F";
		sAAAVeh = "O_T_APC_Tracked_02_AA_ghex_F";
		sMortar = ["O_Mortar_01_F"];
		sSniper = "O_T_Sniper_F";
		//sCivilian = ["C_man_polo_1_F"];
		sArtilleryVeh = "O_T_MBT_02_arty_ghex_F";
		sBoatUnit = "O_T_Boat_Armed_01_hmg_F";		
		sExpSpec = "O_T_Soldier_Exp_F"; 		

		sTeamleaderMilitia = "O_T_Soldier_TL_F";
		sRiflemanMilitia = "O_T_Soldier_F";
		sATManMilitia = "O_T_Soldier_LAT_F";
		sAAManMilitia = "O_T_Soldier_AA_F";	
		sAmmobearerMilitia = "O_T_Soldier_A_F";
		sGrenadierMilitia = "O_T_Soldier_GL_F";
		sMedicMilitia = "O_T_Medic_F";
		sMachineGunManMilitia = "O_T_Soldier_AR_F";
		sTank1ArmedCarMilitia = "O_T_LSV_02_armed_F";
		sTank2APCMilitia = "O_T_APC_Wheeled_02_rcws_ghex_F";
		sTank3TankMilitia = "O_T_MBT_02_cannon_ghex_F";
		sAAAVehMilitia = "O_T_APC_Tracked_02_AA_ghex_F";
		sMortarMilitia = ["O_Mortar_01_F"];
		
		InformantClasses = ["C_Orestes","C_Nikos"];
		InterogateOfficerClasses = ["O_T_Officer_F"];
		WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
		sideResarchTruck = ["O_Truck_03_device_F"];
		SideRadioClassNames = ["Land_PortableGenerator_01_F"];
		sideAmmoTruck = ["O_Truck_03_ammo_F"];
		DestroyAAAVeh = ["O_T_APC_Tracked_02_AA_ghex_F"];

		sRiflemanFriendInsurg = "B_G_Soldier_F";

		ReinforceVehicle = "O_T_VTOL_02_infantry_F";
		EnemyAirToAirSupports = ["O_Plane_Fighter_02_F"];
		EnemyAirToGroundSupports = ["O_Plane_CAS_02_dynamicLoadout_F","O_Plane_CAS_02_F","O_T_VTOL_02_infantry_F","O_Heli_Attack_02_dynamicLoadout_F"]; //This would normally be a chopper
		EnemyAirScout = ["O_UAV_02_dynamicLoadout_F"];
		
		UnarmedScoutVehicles = ["O_MRAP_02_F","O_G_Offroad_01_F","O_G_Van_01_transport_F","O_G_Van_02_vehicle_F"];
		EnemyBaseChoppers = ["O_T_VTOL_02_infantry_F"];
		sEnemyHeliPilot = "O_helipilot_F";
	};
	case 3 : {

		sTeamleader = "O_G_Soldier_TL_F";
		sRifleman = "O_G_Soldier_F";
		sATMan = "O_G_Soldier_LAT_F";
		sAAMan = "O_G_Soldier_LAT_F";
		sAmmobearer = "O_G_Soldier_A_F";
		sGrenadier = "O_G_Soldier_GL_F";
		sMedic = "O_G_medic_F";
		sMachineGunMan = "O_G_Soldier_AR_F";
		sTank1ArmedCar = "O_G_Offroad_01_armed_F";
		sTank2APC = "O_G_Offroad_01_armed_F";
		sTank3Tank = "O_G_Offroad_01_armed_F";
		sAAAVeh = "";
		sMortar = ["O_G_Mortar_01_F"];
		sSniper = "O_G_Soldier_F";
		//sCivilian = ["C_man_polo_1_F"];
		sArtilleryVeh = "O_T_MBT_02_arty_ghex_F";
		sBoatUnit = "Land_HelipadEmpty_F";		
		sExpSpec = "O_G_Soldier_F"; 		

		sTeamleaderMilitia = "O_G_Soldier_TL_F";
		sRiflemanMilitia = "O_G_Soldier_F";
		sATManMilitia = "O_G_Soldier_LAT_F";
		sAAManMilitia = "O_G_Soldier_LAT_F";	
		sAmmobearerMilitia = "O_G_Soldier_A_F";
		sGrenadierMilitia = "O_G_Soldier_GL_F";
		sMedicMilitia = "O_G_medic_F";
		sMachineGunManMilitia = "O_G_Soldier_AR_F";
		sTank1ArmedCarMilitia = "O_G_Offroad_01_armed_F";
		sTank2APCMilitia = "O_G_Offroad_01_armed_F";
		sTank3TankMilitia = "O_G_Offroad_01_armed_F";
		sAAAVehMilitia = "";
		sMortarMilitia = ["O_G_Mortar_01_F"];
		
		InformantClasses = ["C_Orestes","C_Nikos"];
		InterogateOfficerClasses = ["O_T_Officer_F"];
		WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
		sideResarchTruck = ["O_Truck_03_device_F"];
		SideRadioClassNames = ["Land_PortableGenerator_01_F"];
		sideAmmoTruck = ["O_Truck_03_ammo_F"];
		DestroyAAAVeh = ["O_T_APC_Tracked_02_AA_ghex_F"];

		sRiflemanFriendInsurg = "B_G_Soldier_F";

		ReinforceVehicle = "Land_HelipadEmpty_F";
		EnemyAirToAirSupports = ["Land_HelipadEmpty_F"];
		EnemyAirToGroundSupports = ["Land_HelipadEmpty_F"]; //This would normally be a chopper
		EnemyAirScout = ["Land_HelipadEmpty_F"];
		
		UnarmedScoutVehicles = ["O_G_Offroad_01_F","O_G_Van_01_transport_F","O_G_Van_02_vehicle_F"];
		EnemyBaseChoppers = ["Land_HelipadEmpty_F"];
		sEnemyHeliPilot = "Land_HelipadEmpty_F";


		
	};
	case 4 : {

sTeamleader = "rhs_msv_emr_sergeant";
sRifleman = "rhs_msv_emr_rifleman";
sATMan = "rhs_msv_emr_strelok_rpg_assist";
sAAMan = "rhs_msv_emr_at";
sAmmobearer = "rhs_msv_emr_rifleman";
sGrenadier = "rhs_msv_emr_grenadier_rpg";
sMedic = "rhs_msv_emr_medic";
sMachineGunMan = "rhs_msv_emr_arifleman";
sTank1ArmedCar = "rhs_tigr_sts_msv";
sTank2APC = "rhs_btr60_msv";
sTank3Tank = "rhs_t72ba_tv";
sAAAVeh = "rhs_zsu234_aa";    
sMortar = ["rhs_2b14_82mm_msv"];
sSniper = "rhs_mvd_izlom_marksman";
//sCivilian = ["C_man_polo_1_F"];
sArtilleryVeh = "RHS_BM21_MSV_01";
sBoatUnit = "Land_HelipadEmpty_F";		
sExpSpec = "rhs_msv_emr_engineer"; 		

sTeamleaderMilitia = "rhs_msv_emr_sergeant";
sRiflemanMilitia = "rhs_msv_emr_rifleman";
sATManMilitia = "rhs_msv_emr_strelok_rpg_assist";
sAAManMilitia = "rhs_msv_emr_at";	
sAmmobearerMilitia = "rhs_msv_emr_rifleman";
sGrenadierMilitia = "rhs_msv_emr_grenadier_rpg";
sMedicMilitia = "rhs_msv_emr_medic";
sMachineGunManMilitia = "rhs_msv_emr_arifleman";
sTank1ArmedCarMilitia = "rhs_tigr_sts_msv";
sTank2APCMilitia = "rhs_btr60_msv";
sTank3TankMilitia = "rhs_btr60_msv";
sAAAVehMilitia = "rhs_zsu234_aa";
sMortarMilitia = ["rhs_2b14_82mm_msv"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["RHS_Ural_Repair_MSV_01"];
SideRadioClassNames = ["Land_PortableGenerator_01_F"];
sideAmmoTruck = ["rhs_gaz66_ammo_msv"];
DestroyAAAVeh = ["rhs_zsu234_aa"];

sRiflemanFriendInsurg = "B_G_Soldier_F";

ReinforceVehicle = "RHS_Mi8mt_Cargo_vdv";
EnemyAirToAirSupports = ["rhs_mig29s_vmf"];
EnemyAirToGroundSupports = ["RHS_Su25SM_CAS_vvsc","RHS_Mi24P_CAS_vvsc"]; //This would normally be a chopper
EnemyAirScout = ["rhs_ka60_grey"];

UnarmedScoutVehicles = ["rhs_tigr_msv","rhs_uaz_open_MSV_01","RHS_UAZ_MSV_01"];

EnemyBaseChoppers = ["RHS_Ka52_vvs"];
sEnemyHeliPilot = "rhs_pilot_combat_heli";
//HVTChoppers = ["C_Heli_Light_01_civil_F","RHS_Mi8amt_civilian"];

	};	

case 5 : {

sTeamleader = "CUP_O_TK_Soldier_SL";
sRifleman = "CUP_O_TK_Soldier";
sATMan = "CUP_O_TK_Soldier_HAT";
sAAMan = "CUP_O_TK_Soldier_AA";
sAmmobearer = "CUP_O_TK_Soldier_GL";
sGrenadier = "CUP_O_TK_Soldier_GL";
sMedic = "CUP_O_TK_Medic";
sMachineGunMan = "CUP_O_TK_Soldier_MG";
sTank1ArmedCar = "CUP_O_T34_TKA";
sTank2APC = "CUP_O_T72_TKA";
sTank3Tank = "CUP_O_BTR40_MG_TKA";
sAAAVeh = "CUP_O_ZSU23_TK";    
sMortar = ["CUP_O_2b14_82mm_TK"];
sSniper = "CUP_O_TK_Sniper";
sCivilian = ["CUP_C_TK_Man_04","CUP_C_TK_Man_04_Jack","CUP_C_TK_Man_04_Waist","CUP_C_TK_Man_07","CUP_C_TK_Man_07_Coat","CUP_C_TK_Man_07_Waist","CUP_C_TK_Man_08","CUP_C_TK_Man_08_Jack","CUP_C_TK_Man_08_Waist","CUP_C_TK_Man_05_Coat","CUP_C_TK_Man_05_Jack","CUP_C_TK_Man_05_Waist","CUP_C_TK_Man_06_Coat","CUP_C_TK_Man_06_Jack","CUP_C_TK_Man_06_Waist","CUP_C_TK_Man_02","CUP_C_TK_Man_02_Jack","CUP_C_TK_Man_02_Waist","CUP_C_TK_Man_01_Waist","CUP_C_TK_Man_01_Coat","CUP_C_TK_Man_01_Jack","CUP_C_TK_Man_03_Coat","CUP_C_TK_Man_03_Jack","CUP_C_TK_Man_03_Waist"];

sArtilleryVeh = "CUP_O_BM21_TKA";
sBoatUnit = "Land_HelipadEmpty_F";		
sExpSpec = "CUP_O_TK_Soldier_GL"; 		

sTeamleaderMilitia = "CUP_O_TK_INS_Soldier_TL";
sRiflemanMilitia = "CUP_O_TK_INS_Soldier";
sATManMilitia = "CUP_O_TK_INS_Soldier_AT";
sAAManMilitia = "CUP_O_TK_INS_Soldier_AA";	
sAmmobearerMilitia = "CUP_O_TK_INS_Bomber";
sGrenadierMilitia = "CUP_O_TK_INS_Soldier_GL";
sMedicMilitia = "CUP_O_TK_INS_Guerilla_Medic";
sMachineGunManMilitia = "CUP_O_TK_INS_Soldier_MG";
sTank1ArmedCarMilitia = "CUP_O_LR_MG_TKM";
sTank2APCMilitia = "CUP_O_BTR40_MG_TKM";
sTank3TankMilitia = "CUP_O_LR_SPG9_TKM";
sAAAVehMilitia = "CUP_O_Ural_ZU23_TKA";
sMortarMilitia = ["CUP_O_2b14_82mm_TK_INS"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["CUP_O_Ural_Repair_TKA"];
SideRadioClassNames = ["Vysilacka"];
sideAmmoTruck = ["CUP_O_Ural_Reammo_TKA"];
DestroyAAAVeh = ["CUP_O_Ural_ZU23_TKA"];

sRiflemanFriendInsurg = "CUP_O_TK_INS_Soldier";

ReinforceVehicle = "CUP_O_UH1H_slick_TKA";
EnemyAirToAirSupports = ["CUP_O_L39_TK"];
EnemyAirToGroundSupports = ["CUP_O_Su25_Dyn_TKA","CUP_O_Mi24_D_Dynamic_TK"]; //This would normally be a chopper
EnemyAirScout = ["CUP_O_AN2_TK"];

UnarmedScoutVehicles = ["CUP_O_LR_Transport_TKM","CUP_O_V3S_Open_TKM"];

EnemyBaseChoppers = ["CUP_O_Mi24_D_Dynamic_TK"];
sEnemyHeliPilot = "CUP_O_TK_Pilot";

CivCars = ["CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_GreenTK_CIV","CUP_C_S1203_CIV","CUP_C_Ikarus_TKC"];
HVTCars = ["CUP_C_SUV_TK","CUP_C_SUV_TK","CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_TK2_CIV","CUP_C_SUV_CIV","CUP_C_Golf4_kitty_Civ"];
//HVTChoppers = ["C_Heli_Light_01_civil_F","CUP_C_Mi17_Civilian_RU"];




	};	


case 6 : {

sTeamleader = "CUP_O_TK_Soldier_SL";
sRifleman = "CUP_O_TK_Soldier";
sATMan = "CUP_O_TK_Soldier_HAT";
sAAMan = "CUP_O_TK_Soldier_AA";
sAmmobearer = "CUP_O_TK_Soldier_GL";
sGrenadier = "CUP_O_TK_Soldier_GL";
sMedic = "CUP_O_TK_Medic";
sMachineGunMan = "CUP_O_TK_Soldier_MG";
sTank1ArmedCar = "CUP_O_T34_TKA";
sTank2APC = "CUP_O_T72_TKA";
sTank3Tank = "CUP_O_BTR40_MG_TKA";
sAAAVeh = "CUP_O_ZSU23_TK";    
sMortar = ["CUP_O_2b14_82mm_TK"];
sSniper = "CUP_O_TK_Sniper";
sCivilian = ["CUP_C_TK_Man_04","CUP_C_TK_Man_04_Jack","CUP_C_TK_Man_04_Waist","CUP_C_TK_Man_07","CUP_C_TK_Man_07_Coat","CUP_C_TK_Man_07_Waist","CUP_C_TK_Man_08","CUP_C_TK_Man_08_Jack","CUP_C_TK_Man_08_Waist","CUP_C_TK_Man_05_Coat","CUP_C_TK_Man_05_Jack","CUP_C_TK_Man_05_Waist","CUP_C_TK_Man_06_Coat","CUP_C_TK_Man_06_Jack","CUP_C_TK_Man_06_Waist","CUP_C_TK_Man_02","CUP_C_TK_Man_02_Jack","CUP_C_TK_Man_02_Waist","CUP_C_TK_Man_01_Waist","CUP_C_TK_Man_01_Coat","CUP_C_TK_Man_01_Jack","CUP_C_TK_Man_03_Coat","CUP_C_TK_Man_03_Jack","CUP_C_TK_Man_03_Waist"];
sArtilleryVeh = "CUP_O_BM21_TKA";
sBoatUnit = "Land_HelipadEmpty_F";		
sExpSpec = "CUP_O_TK_Soldier_GL"; 		

sTeamleaderMilitia = "CUP_O_TK_Soldier_SL";
sRiflemanMilitia = "CUP_O_TK_Soldier";
sATManMilitia = "CUP_O_TK_Soldier_HAT";
sAAManMilitia = "CUP_O_TK_Soldier_AA";	
sAmmobearerMilitia = "CUP_O_TK_Soldier_GL";
sGrenadierMilitia = "CUP_O_TK_Soldier_GL";
sMedicMilitia = "CUP_O_TK_Medic";
sMachineGunManMilitia = "CUP_O_TK_Soldier_MG";
sTank1ArmedCarMilitia = "CUP_O_T34_TKA";
sTank2APCMilitia = "CUP_O_T72_TKA";
sTank3TankMilitia = "CUP_O_BTR40_MG_TKA";
sAAAVehMilitia = "CUP_O_ZSU23_TK";
sMortarMilitia = ["CUP_O_2b14_82mm_TK"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["CUP_O_Ural_Repair_TKA"];
SideRadioClassNames = ["Vysilacka"];
sideAmmoTruck = ["CUP_O_Ural_Reammo_TKA"];
DestroyAAAVeh = ["CUP_O_Ural_ZU23_TKA"];

sRiflemanFriendInsurg = "CUP_O_TK_INS_Soldier";

ReinforceVehicle = "CUP_O_UH1H_slick_TKA";
EnemyAirToAirSupports = ["CUP_O_L39_TK"];
EnemyAirToGroundSupports = ["CUP_O_Su25_Dyn_TKA","CUP_O_Mi24_D_Dynamic_TK"]; //This would normally be a chopper
EnemyAirScout = ["CUP_O_AN2_TK"];

UnarmedScoutVehicles = ["CUP_O_LR_Transport_TKM","CUP_O_V3S_Open_TKM"];

EnemyBaseChoppers = ["CUP_O_Mi24_D_Dynamic_TK"];
sEnemyHeliPilot = "CUP_O_TK_Pilot";

CivCars = ["CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_GreenTK_CIV","CUP_C_S1203_CIV","CUP_C_Ikarus_TKC"];
HVTCars = ["CUP_C_SUV_TK","CUP_C_SUV_TK","CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_TK2_CIV","CUP_C_SUV_CIV","CUP_C_Golf4_kitty_Civ"];
//HVTChoppers = ["C_Heli_Light_01_civil_F","CUP_C_Mi17_Civilian_RU"];

	};	


case 7 : {

sTeamleader = "CUP_O_TK_INS_Soldier_TL";
sRifleman = "CUP_O_TK_INS_Soldier";
sATMan = "CUP_O_TK_INS_Soldier_AT";
sAAMan = "CUP_O_TK_INS_Soldier_AA";
sAmmobearer = "CUP_O_TK_INS_Bomber";
sGrenadier = "CUP_O_TK_INS_Soldier_GL";
sMedic = "CUP_O_TK_INS_Guerilla_Medic";
sMachineGunMan = "CUP_O_TK_INS_Soldier_MG";
sTank1ArmedCar = "CUP_O_LR_MG_TKM";
sTank2APC = "CUP_O_BTR40_MG_TKM";
sTank3Tank = "CUP_O_LR_SPG9_TKM";
sAAAVeh = "CUP_O_Ural_ZU23_TKA";    
sMortar = ["CUP_O_2b14_82mm_TK_INS"];
sSniper = "CUP_O_TK_INS_Soldier";
sCivilian = ["CUP_C_TK_Man_04","CUP_C_TK_Man_04_Jack","CUP_C_TK_Man_04_Waist","CUP_C_TK_Man_07","CUP_C_TK_Man_07_Coat","CUP_C_TK_Man_07_Waist","CUP_C_TK_Man_08","CUP_C_TK_Man_08_Jack","CUP_C_TK_Man_08_Waist","CUP_C_TK_Man_05_Coat","CUP_C_TK_Man_05_Jack","CUP_C_TK_Man_05_Waist","CUP_C_TK_Man_06_Coat","CUP_C_TK_Man_06_Jack","CUP_C_TK_Man_06_Waist","CUP_C_TK_Man_02","CUP_C_TK_Man_02_Jack","CUP_C_TK_Man_02_Waist","CUP_C_TK_Man_01_Waist","CUP_C_TK_Man_01_Coat","CUP_C_TK_Man_01_Jack","CUP_C_TK_Man_03_Coat","CUP_C_TK_Man_03_Jack","CUP_C_TK_Man_03_Waist"];
sArtilleryVeh = "CUP_O_BM21_TKA";
sBoatUnit = "Land_HelipadEmpty_F";		
sExpSpec = "CUP_O_TK_INS_Soldier"; 		

sTeamleaderMilitia = "CUP_O_TK_INS_Soldier_TL";
sRiflemanMilitia = "CUP_O_TK_INS_Soldier";
sATManMilitia = "CUP_O_TK_INS_Soldier_AT";
sAAManMilitia = "CUP_O_TK_INS_Soldier_AA";	
sAmmobearerMilitia = "CUP_O_TK_INS_Bomber";
sGrenadierMilitia = "CUP_O_TK_INS_Soldier_GL";
sMedicMilitia = "CUP_O_TK_INS_Guerilla_Medic";
sMachineGunManMilitia = "CUP_O_TK_INS_Soldier_MG";
sTank1ArmedCarMilitia = "CUP_O_LR_MG_TKM";
sTank2APCMilitia = "CUP_O_BTR40_MG_TKM";
sTank3TankMilitia = "CUP_O_LR_SPG9_TKM";
sAAAVehMilitia = "CUP_O_Ural_ZU23_TKA";
sMortarMilitia = ["CUP_O_2b14_82mm_TK_INS"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["CUP_O_Ural_Repair_TKA"];
SideRadioClassNames = ["Vysilacka"];
sideAmmoTruck = ["CUP_O_Ural_Reammo_TKA"];
DestroyAAAVeh = ["CUP_O_Ural_ZU23_TKA"];

sRiflemanFriendInsurg = "CUP_O_TK_INS_Soldier";

ReinforceVehicle = "CUP_O_LR_Transport_TKM";
EnemyAirToAirSupports = ["Land_HelipadEmpty_F"];
EnemyAirToGroundSupports = ["Land_HelipadEmpty_F"]; //This would normally be a chopper
EnemyAirScout = ["CUP_O_AN2_TK"];

UnarmedScoutVehicles = ["CUP_O_LR_Transport_TKM","CUP_O_V3S_Open_TKM"];

EnemyBaseChoppers = ["Land_HelipadEmpty_F"];
sEnemyHeliPilot = "CUP_O_TK_Pilot";

CivCars = ["CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_GreenTK_CIV","CUP_C_S1203_CIV","CUP_C_Ikarus_TKC"];
HVTCars = ["CUP_C_SUV_TK","CUP_C_SUV_TK","CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_TK2_CIV","CUP_C_SUV_CIV","CUP_C_Golf4_kitty_Civ"];
//HVTChoppers = ["C_Heli_Light_01_civil_F","CUP_C_Mi17_Civilian_RU"];

	};	


case 8 : {

sTeamleader = "rhsgref_ins_squadleader";
sRifleman = "rhsgref_ins_rifleman";
sATMan = "rhsgref_ins_grenadier_rpg";
sAAMan = "rhsgref_ins_specialist_aa";
sAmmobearer = "rhsgref_ins_militiaman_mosin";
sGrenadier = "rhsgref_ins_engineer";
sMedic = "rhsgref_ins_medic";
sMachineGunMan = "rhsgref_ins_machinegunner";
sTank1ArmedCar = "rhsgref_ins_uaz_spg9";
sTank2APC = "rhsgref_ins_btr70";
sTank3Tank = "rhsgref_ins_t72bc";
sAAAVeh = "rhsgref_ins_zsu234";    
sMortar = ["rhsgref_ins_2b14"];
sSniper = "rhsgref_ins_sniper";
sArtilleryVeh = "rhsgref_ins_BM21";
sBoatUnit = "Land_HelipadEmpty_F";		
sExpSpec = "rhsgref_ins_saboteur"; 		

sTeamleaderMilitia = "rhsgref_ins_squadleader";
sRiflemanMilitia = "rhsgref_ins_rifleman";
sATManMilitia = "rhsgref_ins_grenadier_rpg";
sAAManMilitia = "rhsgref_ins_specialist_aa";	
sAmmobearerMilitia = "rhsgref_ins_militiaman_mosin";
sGrenadierMilitia = "rhsgref_ins_engineer";
sMedicMilitia = "rhsgref_ins_medic";
sMachineGunManMilitia = "rhsgref_ins_machinegunner";
sTank1ArmedCarMilitia = "rhsgref_ins_uaz_spg9";
sTank2APCMilitia = "rhsgref_ins_uaz_spg9";
sTank3TankMilitia = "rhsgref_ins_uaz_spg9";
sAAAVehMilitia = "rhsgref_ins_ural_Zu23";
sMortarMilitia = ["rhsgref_ins_2b14"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["rhsgref_ins_commander"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["rhsgref_ins_ural"];
SideRadioClassNames = ["Land_PortableGenerator_01_F"];
sideAmmoTruck = ["rhsgref_ins_gaz66_ammo"];
DestroyAAAVeh = ["rhsgref_ins_zsu234"];

sRiflemanFriendInsurg = "rhsgref_hidf_rifleman";

ReinforceVehicle = "rhsgref_ins_Mi8amt";
EnemyAirToAirSupports = ["rhs_mig29s_vvs"];
EnemyAirToGroundSupports = ["RHS_Ka52_vvs"]; //This would normally be a chopper
EnemyAirScout = ["rhs_pchela1t_vvs"];

UnarmedScoutVehicles = ["rhsgref_ins_uaz","rhsgref_ins_uaz_open"];

EnemyBaseChoppers = ["RHS_Ka52_vvs"];
sEnemyHeliPilot = "rhsgref_ins_pilot";
//HVTChoppers = ["C_Heli_Light_01_civil_F","RHS_Mi8amt_civilian"];

//CivCars = ["CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_GreenTK_CIV","CUP_C_S1203_CIV","CUP_C_Ikarus_TKC"];

	};	




case 9 : { //Unsung : VC 40th Battalion only

sTeamleader = "uns_men_VC_mainforce_COM";
sRifleman = "uns_men_VC_mainforce_RF3";
sATMan = "uns_men_VC_mainforce_AT";
sAAMan = "uns_men_VC_mainforce_AT2";
sAmmobearer = "uns_men_VC_mainforce_RF4";
sGrenadier = "uns_men_VC_mainforce_SAP";
sMedic = "uns_men_VC_mainforce_MED";
sMachineGunMan = "uns_men_VC_mainforce_LMG";
sTank1ArmedCar = "uns_dshk_armoured_VC";
sTank2APC = "uns_dshk_wheeled_VC";
sTank3Tank = "uns_spiderhole_VC";
sAAAVeh = "uns_Type74_VC";    
sMortar = ["uns_m1941_82mm_mortarVC"];
sSniper = "uns_men_VC_mainforce_Rmrk";
sCivilian = ["uns_civilian1","uns_civilian1_b1","uns_civilian1_b2","uns_civilian2","uns_civilian2_b1","uns_civilian3","uns_civilian3_b1","uns_civilian4","uns_civilian4_b1"];
sArtilleryVeh = "Uns_D30_artillery";
sBoatUnit = "UNS_PATROL_BOAT_VC";		
sExpSpec = "uns_men_VC_mainforce_MTS"; 		


sTeamleaderMilitia = "uns_men_VC_mainforce_COM";
sRiflemanMilitia = "uns_men_VC_mainforce_RF3";
sATManMilitia = "uns_men_VC_mainforce_AT";
sAAManMilitia = "uns_men_VC_mainforce_AT2";	
sAmmobearerMilitia = "uns_men_VC_mainforce_RF4";
sGrenadierMilitia = "uns_men_VC_mainforce_SAP";
sMedicMilitia = "uns_men_VC_mainforce_MED";
sMachineGunManMilitia = "uns_men_VC_mainforce_LMG";
sTank1ArmedCarMilitia = "uns_dshk_armoured_VC";
sTank2APCMilitia = "uns_dshk_wheeled_VC";
sTank3TankMilitia = "uns_spiderhole_VC";
sAAAVehMilitia = "uns_Type74_VC";
sMortarMilitia = ["uns_m1941_82mm_mortarVC"];

InformantClasses = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["uns_men_NVA_65_COM"];
WeaponDealerClasses = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck = ["uns_nvatruck_camo"];
SideRadioClassNames = ["Land_PortableGenerator_01_F"];
sideAmmoTruck = ["uns_nvatruck_reammo"];
DestroyAAAVeh = ["pook_SA2_static_NVA"];

sRiflemanFriendInsurg = "uns_men_ARVN_RF1";

ReinforceVehicle = "uns_nvatruck_open";
EnemyAirToAirSupports = ["uns_Type55_twinMG"];
EnemyAirToGroundSupports = ["uns_Type55_twinMG"]; //This would normally be a chopper
EnemyAirScout = ["uns_men_VC_mainforce_RTO"];

UnarmedScoutVehicles = ["uns_nvatruck_open","uns_nvatruck_open"];

EnemyBaseChoppers = ["uns_Mi8TV_VPAF_MG"];
sEnemyHeliPilot = "uns_nvaf_pilot2";

//CivCars = ["CUP_C_Volha_Limo_TKCIV","CUP_C_Lada_GreenTK_CIV","CUP_C_S1203_CIV","CUP_C_Ikarus_TKC"];

	};	


};

