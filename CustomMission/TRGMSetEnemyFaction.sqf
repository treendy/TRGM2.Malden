
TREND_useCustomEnemyFaction = (["CustomEnemyFaction", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TREND_useCustomEnemyFaction";

if (isServer && TREND_useCustomEnemyFaction) then {
	TREND_EastUnarmedCars  =  ["O_MRAP_02_F", "O_G_Offroad_01_F", "O_Truck_02_transport_F"]; publicVariable "TREND_EastUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
	TREND_EastArmedCars    =  ["O_MRAP_02_hmg_F", "O_G_Offroad_01_armed_F"]; publicVariable "TREND_EastArmedCars";
	TREND_EastAPCs         =  ["O_APC_Tracked_02_cannon_F"]; publicVariable "TREND_EastAPCs";
	TREND_EastTanks        =  ["O_MBT_02_cannon_F"]; publicVariable "TREND_EastTanks";
	TREND_EastArtillery    =  ["O_T_MBT_02_arty_ghex_F"]; publicVariable "TREND_EastArtillery";
	TREND_EastAntiAir      =  ["O_APC_Tracked_02_AA_F"]; publicVariable "TREND_EastAntiAir";
	TREND_EastTurrets      =  ["O_HMG_01_F", "O_HMG_01_high_F"]; publicVariable "TREND_EastTurrets";
	TREND_EastUnarmedHelos =  ["O_Heli_Light_02_unarmed_F", "O_Heli_Transport_04_bench_F"]; publicVariable "TREND_EastUnarmedHelos";
	TREND_EastArmedHelos   =  ["O_Heli_Attack_02_dynamicLoadout_F"]; publicVariable "TREND_EastArmedHelos";
	TREND_EastHelos        =  (TREND_EastUnarmedHelos + TREND_EastArmedHelos); publicVariable "TREND_EastHelos";
	TREND_EastPlanes       =  ["O_Plane_CAS_02_dynamicLoadout_F", "O_Plane_Fighter_02_F"]; publicVariable "TREND_EastPlanes";
	TREND_EastBoats        =  ["O_T_Boat_Armed_01_hmg_F"]; publicVariable "TREND_EastBoats";
	TREND_EastMortars      =  ["O_Mortar_01_F"]; publicVariable "TREND_EastMortars";
};