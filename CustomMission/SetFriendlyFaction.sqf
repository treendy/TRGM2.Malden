
TRGM_VAR_useCustomFriendlyFaction = (["CustomFriendlyFaction", 0] call BIS_fnc_getParamValue) isEqualTo 1;
publicVariable "TRGM_VAR_useCustomFriendlyFaction";

if (isServer && TRGM_VAR_useCustomFriendlyFaction) then {
    TRGM_VAR_WestUnarmedCars  =  ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F", "B_Truck_01_transport_F"]; publicVariable "TRGM_VAR_WestUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
    TRGM_VAR_WestArmedCars    =  ["B_T_MRAP_01_F"]; publicVariable "TRGM_VAR_WestArmedCars";
    TRGM_VAR_WestAPCs         =  ["B_APC_Tracked_01_rcws_F"]; publicVariable "TRGM_VAR_WestAPCs";
    TRGM_VAR_WestTanks        =  ["B_MBT_01_cannon_F"]; publicVariable "TRGM_VAR_WestTanks";
    TRGM_VAR_WestArtillery    =  ["B_MBT_01_arty_F"]; publicVariable "TRGM_VAR_WestArtillery";
    TRGM_VAR_WestAntiAir      =  ["B_APC_Tracked_01_AA_F"]; publicVariable "TRGM_VAR_WestAntiAir";
    TRGM_VAR_WestTurrets      =  ["B_HMG_01_F", "B_HMG_01_high_F"]; publicVariable "TRGM_VAR_WestTurrets";
    TRGM_VAR_WestUnarmedHelos =  ["B_Heli_Transport_01_F", "B_Heli_Transport_03_unarmed_F"]; publicVariable "TRGM_VAR_WestUnarmedHelos";
    TRGM_VAR_WestArmedHelos   =  ["B_Heli_Attack_01_dynamicLoadout_F"]; publicVariable "TRGM_VAR_WestArmedHelos";
    TRGM_VAR_WestHelos        =  (TRGM_VAR_WestArmedHelos + TRGM_VAR_WestUnarmedHelos); publicVariable "TRGM_VAR_WestHelos";
    TRGM_VAR_WestPlanes       =  ["B_Plane_Fighter_01_F"]; publicVariable "TRGM_VAR_WestPlanes";
    TRGM_VAR_WestBoats        =  ["B_T_Boat_Transport_01_F"]; publicVariable "TRGM_VAR_WestBoats";
    TRGM_VAR_WestMortars      =  ["B_Mortar_01_F"]; publicVariable "TRGM_VAR_WestMortars";
};