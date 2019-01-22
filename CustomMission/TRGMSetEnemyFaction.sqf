
_useCustomEnemyFaction = false;
if (isServer && _useCustomEnemyFaction) then {
		
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
	sCivilian = ["C_man_polo_1_F"];
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

	CivCars = ["C_Hatchback_01_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Truck_02_transport_F"];
	sCivilian = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
	HVTCars = ["C_SUV_01_F","C_Hatchback_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Hatchback_01_sport_F"];
	HVTVans = ["C_Van_02_vehicle_F","C_Van_02_transport_F","C_Truck_02_covered_F","C_Van_01_box_F"];
	HVTChoppers = ["C_Heli_Light_01_civil_F"];
	HVTPlanes = ["C_Plane_Civil_01_F"];
	BombToDefuse = ["Land_SatellitePhone_F"];

}