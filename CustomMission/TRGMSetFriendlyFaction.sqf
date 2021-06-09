
TREND_useCustomFriendlyFaction = (["CustomFriendlyFaction", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TREND_useCustomFriendlyFaction";

if (isServer && TREND_useCustomFriendlyFaction) then {
	TREND_WestUnarmedCars  =  ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F", "B_Truck_01_transport_F"]; publicVariable "TREND_WestUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
	TREND_WestArmedCars    =  ["B_T_MRAP_01_F"]; publicVariable "TREND_WestArmedCars";
	TREND_WestAPCs         =  ["B_APC_Tracked_01_rcws_F"]; publicVariable "TREND_WestAPCs";
	TREND_WestTanks        =  ["B_MBT_01_cannon_F"]; publicVariable "TREND_WestTanks";
	TREND_WestArtillery    =  ["B_MBT_01_arty_F"]; publicVariable "TREND_WestArtillery";
	TREND_WestAntiAir      =  ["B_APC_Tracked_01_AA_F"]; publicVariable "TREND_WestAntiAir";
	TREND_WestTurrets      =  ["B_HMG_01_F", "B_HMG_01_high_F"]; publicVariable "TREND_WestTurrets";
	TREND_WestUnarmedHelos =  ["B_Heli_Transport_01_F", "B_Heli_Transport_03_unarmed_F"]; publicVariable "TREND_WestUnarmedHelos";
	TREND_WestArmedHelos   =  ["B_Heli_Attack_01_dynamicLoadout_F"]; publicVariable "TREND_WestArmedHelos";
	TREND_WestHelos        =  (TREND_WestArmedHelos + TREND_WestUnarmedHelos); publicVariable "TREND_WestHelos";
	TREND_WestPlanes       =  ["B_Plane_Fighter_01_F"]; publicVariable "TREND_WestPlanes";
	TREND_WestBoats        =  ["B_T_Boat_Transport_01_F"]; publicVariable "TREND_WestBoats";
	TREND_WestMortars      =  ["B_Mortar_01_F"]; publicVariable "TREND_WestMortars";
};