
TRGM_VAR_useCustomMilitiaFaction = (["CustomMilitiaFaction", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TRGM_VAR_useCustomMilitiaFaction";

if (isServer && TRGM_VAR_useCustomMilitiaFaction) then {
    TRGM_VAR_GuerUnarmedCars  =  ["I_MRAP_03_F", "I_G_Offroad_01_F", "I_Truck_02_covered_F"]; publicVariable "TRGM_VAR_GuerUnarmedCars";
    TRGM_VAR_GuerArmedCars    =  ["I_MRAP_03_hmg_F", "I_G_Offroad_01_armed_F"]; publicVariable "TRGM_VAR_GuerArmedCars";
    TRGM_VAR_GuerAPCs         =  ["I_APC_Wheeled_03_cannon_F"]; publicVariable "TRGM_VAR_GuerAPCs";
    TRGM_VAR_GuerTanks        =  ["I_LT_01_AT_F"]; publicVariable "TRGM_VAR_GuerTanks";
    TRGM_VAR_GuerArtillery    =  ["I_Truck_02_MRL_F"]; publicVariable "TRGM_VAR_GuerArtillery";
    TRGM_VAR_GuerAntiAir      =  ["I_LT_01_AA_F"]; publicVariable "TRGM_VAR_GuerAntiAir";
    TRGM_VAR_GuerTurrets      =  ["I_HMG_01_F", "I_HMG_01_high_F"]; publicVariable "TRGM_VAR_GuerTurrets";
    TRGM_VAR_GuerUnarmedHelos =  ["I_Heli_Transport_02_F"]; publicVariable "TRGM_VAR_GuerUnarmedHelos";
    TRGM_VAR_GuerArmedHelos   =  ["I_Heli_light_03_F"]; publicVariable "TRGM_VAR_GuerArmedHelos";
    TRGM_VAR_GuerHelos        =  (TRGM_VAR_GuerUnarmedHelos + TRGM_VAR_GuerArmedHelos); publicVariable "TRGM_VAR_GuerHelos";
    TRGM_VAR_GuerPlanes       =  ["I_Plane_Fighter_04_F"]; publicVariable "TRGM_VAR_GuerPlanes";
    TRGM_VAR_GuerBoats        =  ["I_C_Boat_Transport_02_F"]; publicVariable "TRGM_VAR_GuerBoats";
    TRGM_VAR_GuerMortars      =  ["I_Mortar_01_F"]; publicVariable "TRGM_VAR_GuerMortars";
};