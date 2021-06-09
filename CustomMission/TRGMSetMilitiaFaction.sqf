
TREND_useCustomMilitiaFaction = (["CustomMilitiaFaction", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TREND_useCustomMilitiaFaction";

if (isServer && TREND_useCustomMilitiaFaction) then {
	TREND_GuerUnarmedCars  =  ["I_MRAP_03_F", "I_G_Offroad_01_F", "I_Truck_02_covered_F"]; publicVariable "TREND_GuerUnarmedCars";
	TREND_GuerArmedCars    =  ["I_MRAP_03_hmg_F", "I_G_Offroad_01_armed_F"]; publicVariable "TREND_GuerArmedCars";
	TREND_GuerAPCs         =  ["I_APC_Wheeled_03_cannon_F"]; publicVariable "TREND_GuerAPCs";
	TREND_GuerTanks        =  ["I_LT_01_AT_F"]; publicVariable "TREND_GuerTanks";
	TREND_GuerArtillery    =  ["I_Truck_02_MRL_F"]; publicVariable "TREND_GuerArtillery";
	TREND_GuerAntiAir      =  ["I_LT_01_AA_F"]; publicVariable "TREND_GuerAntiAir";
	TREND_GuerTurrets      =  ["I_HMG_01_F", "I_HMG_01_high_F"]; publicVariable "TREND_GuerTurrets";
	TREND_GuerUnarmedHelos =  ["I_Heli_Transport_02_F"]; publicVariable "TREND_GuerUnarmedHelos";
	TREND_GuerArmedHelos   =  ["I_Heli_light_03_F"]; publicVariable "TREND_GuerArmedHelos";
	TREND_GuerHelos        =  (TREND_GuerUnarmedHelos + TREND_GuerArmedHelos); publicVariable "TREND_GuerHelos";
	TREND_GuerPlanes       =  ["I_Plane_Fighter_04_F"]; publicVariable "TREND_GuerPlanes";
	TREND_GuerBoats        =  ["I_C_Boat_Transport_02_F"]; publicVariable "TREND_GuerBoats";
	TREND_GuerMortars      =  ["I_Mortar_01_F"]; publicVariable "TREND_GuerMortars";
};