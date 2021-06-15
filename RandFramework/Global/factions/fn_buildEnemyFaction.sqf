format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

private _enemyFactionIndex = TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_ENEMY_FACTIONS_IDX;
(TRGM_VAR_AllFactionData select _enemyFactionIndex) params ["_eastClassName", "_eastDisplayName"];

private _baseEastUnitData = [_eastClassName, _eastDisplayName] call TRGM_GLOBAL_fnc_getUnitDataByFaction;
private _baseEastVehData = [_eastClassName, _eastDisplayName] call TRGM_GLOBAL_fnc_getVehicleDataByFaction;

private _eastAppendedData = [_baseEastUnitData, _baseEastVehData, _eastClassName, _eastDisplayName] call TRGM_GLOBAL_fnc_appendAdditonalFactionData;
_eastAppendedData params ["_eastUnitData", "_eastVehData"];

private _eastUnitArray = [_eastUnitData] call TRGM_GLOBAL_fnc_getUnitArraysFromUnitData;
_eastUnitArray params ["_eastriflemen", "_eastleaders", "_eastatsoldiers", "_eastaasoldiers", "_eastengineers", "_eastgrenadiers", "_eastmedics", "_eastautoriflemen", "_eastsnipers", "_eastexplosiveSpecs", "_eastpilots", "_eastuavOperators"];

private _eastVehArray = [_eastVehData] call TRGM_GLOBAL_fnc_getVehicleArraysFromVehData;
_eastVehArray params ["_eastunarmedcars", "_eastarmedcars", "_easttrucks", "_eastapcs", "_easttanks", "_eastartillery", "_eastantiair", "_eastturrets", "_eastunarmedhelicopters", "_eastarmedhelicopters", "_eastplanes", "_eastboats", "_eastmortars"];

TRGM_VAR_EastRiflemen =  _eastriflemen; publicVariable "TRGM_VAR_EastRiflemen";
TRGM_VAR_EastLeaders =  _eastleaders; publicVariable "TRGM_VAR_EastLeaders";
TRGM_VAR_EastATSoldiers =  _eastatsoldiers; publicVariable "TRGM_VAR_EastATSoldiers";
TRGM_VAR_EastAASoldiers =  _eastaasoldiers; publicVariable "TRGM_VAR_EastAASoldiers";
TRGM_VAR_EastEngineers =  _eastengineers; publicVariable "TRGM_VAR_EastEngineers";
TRGM_VAR_EastGrenadiers =  _eastgrenadiers; publicVariable "TRGM_VAR_EastGrenadiers";
TRGM_VAR_EastMedics =  _eastmedics; publicVariable "TRGM_VAR_EastMedics";
TRGM_VAR_EastAutoriflemen =  _eastautoriflemen; publicVariable "TRGM_VAR_EastAutoriflemen";
TRGM_VAR_EastSnipers =  _eastsnipers; publicVariable "TRGM_VAR_EastSnipers";
TRGM_VAR_EastExpSpecs =  _eastexplosiveSpecs; publicVariable "TRGM_VAR_EastExpSpecs";
TRGM_VAR_EastPilots =  _eastpilots; publicVariable "TRGM_VAR_EastPilots";
TRGM_VAR_EastUAVOps = _eastuavOperators; publicVariable "TRGM_VAR_EastUAVOps";

TRGM_VAR_EastUnarmedCars =  _eastunarmedcars + _easttrucks; publicVariable "TRGM_VAR_EastUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TRGM_VAR_EastArmedCars =  _eastarmedcars; publicVariable "TRGM_VAR_EastArmedCars";
TRGM_VAR_EastAPCs =  _eastapcs; publicVariable "TRGM_VAR_EastAPCs";
TRGM_VAR_EastTanks =  _easttanks; publicVariable "TRGM_VAR_EastTanks";
TRGM_VAR_EastArtillery =  _eastartillery; publicVariable "TRGM_VAR_EastArtillery";
TRGM_VAR_EastAntiAir =  _eastantiair; publicVariable "TRGM_VAR_EastAntiAir";
TRGM_VAR_EastTurrets =  _eastturrets; publicVariable "TRGM_VAR_EastTurrets";
TRGM_VAR_EastUnarmedHelos =  _eastunarmedhelicopters; publicVariable "TRGM_VAR_EastUnarmedHelos";
TRGM_VAR_EastArmedHelos =  _eastarmedhelicopters; publicVariable "TRGM_VAR_EastArmedHelos";
TRGM_VAR_EastHelos =  (_eastunarmedhelicopters + _eastarmedhelicopters); publicVariable "TRGM_VAR_EastHelos";
TRGM_VAR_EastPlanes =  _eastplanes; publicVariable "TRGM_VAR_EastPlanes";
TRGM_VAR_EastBoats =  _eastboats; publicVariable "TRGM_VAR_EastBoats";
TRGM_VAR_EastMortars = _eastmortars; publicVariable "TRGM_VAR_EastMortars";

sRifleman 		= { _unit = "O_T_Soldier_F"; if (count TRGM_VAR_EastRiflemen > 0) then { _unit = selectRandom TRGM_VAR_EastRiflemen; }; _unit; };
sTeamleader 	= { _unit = "O_T_Soldier_TL_F"; if (count TRGM_VAR_EastLeaders > 0) then { _unit = selectRandom TRGM_VAR_EastLeaders; }; _unit; };
sATMan 			= { _unit = "O_T_Soldier_LAT_F"; if (count TRGM_VAR_EastATSoldiers > 0) then { _unit = selectRandom TRGM_VAR_EastATSoldiers; }; _unit; };
sAAMan 			= { _unit = "O_T_Soldier_AA_F"; if (count TRGM_VAR_EastAASoldiers > 0) then { _unit = selectRandom TRGM_VAR_EastAASoldiers; }; _unit; };
sEngineer 		= { _unit = "O_T_Engineer_F"; if (count TRGM_VAR_EastEngineers > 0) then { _unit = selectRandom TRGM_VAR_EastEngineers; }; _unit; };
sGrenadier 		= { _unit = "O_T_Soldier_GL_F"; if (count TRGM_VAR_EastGrenadiers > 0) then { _unit = selectRandom TRGM_VAR_EastGrenadiers; }; _unit; };
sMedic 			= { _unit = "O_T_Medic_F"; if (count TRGM_VAR_EastMedics > 0) then { _unit = selectRandom TRGM_VAR_EastMedics; }; _unit; };
sMachineGunMan 	= { _unit = "O_T_Soldier_AR_F"; if (count TRGM_VAR_EastAutoriflemen > 0) then { _unit = selectRandom TRGM_VAR_EastAutoriflemen; }; _unit; };
sSniper 		= { _unit = "O_T_Sniper_F"; if (count TRGM_VAR_EastSnipers > 0) then { _unit = selectRandom TRGM_VAR_EastSnipers; }; _unit; };
sExpSpec 		= { _unit = "O_T_Soldier_Exp_F"; if (count TRGM_VAR_EastExpSpecs > 0) then { _unit = selectRandom TRGM_VAR_EastExpSpecs; }; _unit; };
sEnemyHeliPilot = { _unit = "O_T_Helipilot_F"; if (count TRGM_VAR_EastPilots > 0) then { _unit = selectRandom TRGM_VAR_EastPilots; }; _unit; };

sTank1ArmedCar			 = { _veh = "O_T_LSV_02_armed_F"; if (count TRGM_VAR_EastArmedCars > 0) then { _veh = selectRandom TRGM_VAR_EastArmedCars; }; _veh; };
sTank2APC				 = { _veh = "O_APC_Wheeled_02_rcws_v2_F"; if (count TRGM_VAR_EastAPCs > 0) then { _veh = selectRandom TRGM_VAR_EastAPCs; }; _veh; };
sTank3Tank				 = { _veh = "O_MBT_02_cannon_F"; if (count TRGM_VAR_EastTanks > 0) then { _veh = selectRandom TRGM_VAR_EastTanks; }; _veh; };
sAAAVeh					 = { _veh = "O_APC_Tracked_02_AA_F"; if (count TRGM_VAR_EastAntiAir > 0) then { _veh = selectRandom TRGM_VAR_EastAntiAir; }; _veh; };
sMortar					 = { _veh = ["O_Mortar_01_F"]; if (count TRGM_VAR_EastMortars > 0) then { _veh = TRGM_VAR_EastMortars; }; _veh; };
sArtilleryVeh			 = { _veh = ["O_MBT_02_arty_F"]; if (count TRGM_VAR_EastArtillery > 0) then { _veh = TRGM_VAR_EastArtillery; }; _veh; };
sBoatUnit				 = { _veh = "O_Boat_Armed_01_hmg_F"; if (count TRGM_VAR_EastBoats > 0) then { _veh = selectRandom TRGM_VAR_EastBoats; }; _veh; };
ReinforceVehicle		 = { _veh = "O_Heli_Light_02_unarmed_F"; if (count (TRGM_VAR_EastHelos select {_x call TRGM_GLOBAL_fnc_isTransport;}) > 0) then { _veh = selectRandom (TRGM_VAR_EastHelos select {_x call TRGM_GLOBAL_fnc_isTransport;}); }; _veh; };
EnemyAirToAirSupports	 = { _veh = ["O_Plane_Fighter_02_F"]; if (count TRGM_VAR_EastPlanes > 0) then { _veh = TRGM_VAR_EastPlanes; }; _veh; };
EnemyAirToGroundSupports = { _veh = ["O_Heli_Light_02_dynamicLoadout_F"]; if (count TRGM_VAR_EastArmedHelos > 0) then { _veh = TRGM_VAR_EastArmedHelos; }; _veh; };
EnemyAirScout			 = { _veh = ["O_Heli_Light_02_dynamicLoadout_F"]; if (count TRGM_VAR_EastArmedHelos > 0) then { _veh = TRGM_VAR_EastArmedHelos; }; _veh; };
UnarmedScoutVehicles	 = { _veh = ["O_Truck_02_covered_F"]; if (count TRGM_VAR_EastUnarmedCars > 0) then { _veh = TRGM_VAR_EastUnarmedCars; }; _veh; };
EnemyBaseChoppers		 = { _veh = ["O_Heli_Light_02_unarmed_F"]; if (count TRGM_VAR_EastUnarmedHelos > 0) then { _veh = TRGM_VAR_EastUnarmedHelos; }; _veh; };




private _guerFactionIndex = TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_MILITIA_FACTIONS_IDX;
(TRGM_VAR_AllFactionData select _guerFactionIndex) params ["_guerClassName", "_guerDisplayName"];

private _baseGuerUnitData = [_guerClassName, _guerDisplayName] call TRGM_GLOBAL_fnc_getUnitDataByFaction;
private _baseGuerVehData = [_guerClassName, _guerDisplayName] call TRGM_GLOBAL_fnc_getVehicleDataByFaction;

private _guerAppendedData = [_baseGuerUnitData, _baseGuerVehData, _guerClassName, _guerDisplayName] call TRGM_GLOBAL_fnc_appendAdditonalFactionData;
_guerAppendedData params ["_guerUnitData", "_guerVehData"];

private _guerUnitArray = [_guerUnitData] call TRGM_GLOBAL_fnc_getUnitArraysFromUnitData;
_guerUnitArray params ["_guerriflemen", "_guerleaders", "_gueratsoldiers", "_gueraasoldiers", "_guerengineers", "_guergrenadiers", "_guermedics", "_guerautoriflemen", "_guersnipers", "_guerexplosiveSpecs", "_guerpilots", "_gueruavOperators"];

private _guerVehArray = [_guerVehData] call TRGM_GLOBAL_fnc_getVehicleArraysFromVehData;
_guerVehArray params ["_guerunarmedcars", "_guerarmedcars", "_guertrucks", "_guerapcs", "_guertanks", "_guerartillery", "_guerantiair", "_guerturrets", "_guerunarmedhelicopters", "_guerarmedhelicopters", "_guerplanes", "_guerboats", "_guermortars"];

TRGM_VAR_GuerRiflemen =  _guerriflemen; publicVariable "TRGM_VAR_GuerRiflemen";
TRGM_VAR_GuerLeaders =  _guerleaders; publicVariable "TRGM_VAR_GuerLeaders";
TRGM_VAR_GuerATSoldiers =  _gueratsoldiers; publicVariable "TRGM_VAR_GuerATSoldiers";
TRGM_VAR_GuerAASoldiers =  _gueraasoldiers; publicVariable "TRGM_VAR_GuerAASoldiers";
TRGM_VAR_GuerEngineers =  _guerengineers; publicVariable "TRGM_VAR_GuerEngineers";
TRGM_VAR_GuerGrenadiers =  _guergrenadiers; publicVariable "TRGM_VAR_GuerGrenadiers";
TRGM_VAR_GuerMedics =  _guermedics; publicVariable "TRGM_VAR_GuerMedics";
TRGM_VAR_GuerAutoriflemen =  _guerautoriflemen; publicVariable "TRGM_VAR_GuerAutoriflemen";
TRGM_VAR_GuerSnipers =  _guersnipers; publicVariable "TRGM_VAR_GuerSnipers";
TRGM_VAR_GuerExpSpecs =  _guerexplosiveSpecs; publicVariable "TRGM_VAR_GuerExpSpecs";
TRGM_VAR_GuerPilots =  _guerpilots; publicVariable "TRGM_VAR_GuerPilots";
TRGM_VAR_GuerUAVOps = _gueruavOperators; publicVariable "TRGM_VAR_GuerUAVOps";

TRGM_VAR_GuerUnarmedCars =  _guerunarmedcars + _guertrucks; publicVariable "TRGM_VAR_GuerUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TRGM_VAR_GuerArmedCars =  _guerarmedcars; publicVariable "TRGM_VAR_GuerArmedCars";
TRGM_VAR_GuerAPCs =  _guerapcs; publicVariable "TRGM_VAR_GuerAPCs";
TRGM_VAR_GuerTanks =  _guertanks; publicVariable "TRGM_VAR_GuerTanks";
TRGM_VAR_GuerArtillery =  _guerartillery; publicVariable "TRGM_VAR_GuerArtillery";
TRGM_VAR_GuerAntiAir =  _guerantiair; publicVariable "TRGM_VAR_GuerAntiAir";
TRGM_VAR_GuerTurrets =  _guerturrets; publicVariable "TRGM_VAR_GuerTurrets";
TRGM_VAR_GuerUnarmedHelos =  _guerunarmedhelicopters; publicVariable "TRGM_VAR_GuerUnarmedHelos";
TRGM_VAR_GuerArmedHelos =  _guerarmedhelicopters; publicVariable "TRGM_VAR_GuerArmedHelos";
TRGM_VAR_GuerHelos =  (_guerunarmedhelicopters + _guerarmedhelicopters); publicVariable "TRGM_VAR_GuerHelos";
TRGM_VAR_GuerPlanes =  _guerplanes; publicVariable "TRGM_VAR_GuerPlanes";
TRGM_VAR_GuerBoats =  _guerboats; publicVariable "TRGM_VAR_GuerBoats";
TRGM_VAR_GuerMortars = _guermortars; publicVariable "TRGM_VAR_GuerMortars";

sRiflemanMilitia 		= { _unit = "I_G_Soldier_F"; if (count TRGM_VAR_GuerRiflemen > 0) then { _unit = selectRandom TRGM_VAR_GuerRiflemen; }; _unit; };
sTeamleaderMilitia 		= { _unit = "I_G_Soldier_SL_F"; if (count TRGM_VAR_GuerLeaders > 0) then { _unit = selectRandom TRGM_VAR_GuerLeaders; }; _unit; };
sATManMilitia 			= { _unit = "I_G_Soldier_LAT_F"; if (count TRGM_VAR_GuerATSoldiers > 0) then { _unit = selectRandom TRGM_VAR_GuerATSoldiers; }; _unit; };
sAAManMilitia 			= { _unit = "I_G_Soldier_LAT_F"; if (count TRGM_VAR_GuerAASoldiers > 0) then { _unit = selectRandom TRGM_VAR_GuerAASoldiers; }; _unit; };
sEngineerMilitia 		= { _unit = "I_G_Engineer_F"; if (count TRGM_VAR_GuerEngineers > 0) then { _unit = selectRandom TRGM_VAR_GuerEngineers; }; _unit; };
sGrenadierMilitia 		= { _unit = "I_G_Soldier_GL_F"; if (count TRGM_VAR_GuerGrenadiers > 0) then { _unit = selectRandom TRGM_VAR_GuerGrenadiers; }; _unit; };
sMedicMilitia 			= { _unit = "I_G_Medic_F"; if (count TRGM_VAR_GuerMedics > 0) then { _unit = selectRandom TRGM_VAR_GuerMedics; }; _unit; };
sMachineGunManMilitia 	= { _unit = "I_G_Soldier_AR_F"; if (count TRGM_VAR_GuerAutoriflemen > 0) then { _unit = selectRandom TRGM_VAR_GuerAutoriflemen; }; _unit; };
sSniperMilitia 			= { _unit = "I_G_Soldier_M_F"; if (count TRGM_VAR_GuerSnipers > 0) then { _unit = selectRandom TRGM_VAR_GuerSnipers; }; _unit; };
sExpSpecMilitia 		= { _unit = "I_G_Soldier_Exp_F"; if (count TRGM_VAR_GuerExpSpecs > 0) then { _unit = selectRandom TRGM_VAR_GuerExpSpecs; }; _unit; };
sEnemyHeliPilotMilitia 	= { _unit = "I_helipilot_F"; if (count TRGM_VAR_GuerPilots > 0) then { _unit = selectRandom TRGM_VAR_GuerPilots; }; _unit; };

sTank1ArmedCarMilitia = { _veh = "I_C_Offroad_02_LMG_F"; if (count TRGM_VAR_GuerArmedCars > 0) then { _veh = selectRandom TRGM_VAR_GuerArmedCars; }; _veh; };
sTank2APCMilitia 	  = { _veh = "I_E_APC_tracked_03_cannon_F"; if (count TRGM_VAR_GuerAPCs > 0) then { _veh = selectRandom TRGM_VAR_GuerAPCs; }; _veh; };
sTank3TankMilitia	  = { _veh = "I_LT_01_AT_F"; if (count TRGM_VAR_GuerTanks > 0) then { _veh = selectRandom TRGM_VAR_GuerTanks; }; _veh; };
sAAAVehMilitia 		  = { _veh = "I_LT_01_AA_F"; if (count TRGM_VAR_GuerAntiAir > 0) then { _veh = selectRandom TRGM_VAR_GuerAntiAir; }; _veh; };
sMortarMilitia		  = { _veh = ["I_Mortar_01_F"]; if (count TRGM_VAR_GuerMortars > 0) then { _veh = TRGM_VAR_GuerMortars; }; _veh; };

ReinforceVehicleMilitia = { _veh = "I_E_Heli_light_03_unarmed_F"; if (count (TRGM_VAR_GuerHelos select {_x call TRGM_GLOBAL_fnc_isTransport;}) > 0) then { _veh = selectRandom (TRGM_VAR_GuerHelos select {_x call TRGM_GLOBAL_fnc_isTransport;}); }; _veh; };



/// Mission Required Vehicles! ///

InformantClasses 		 = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses		 = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck		 = ["O_Truck_03_device_F"];
SideRadioClassNames		 = ["Land_PortableGenerator_01_F"];
sideAmmoTruck			 = { _veh = ["O_Truck_03_ammo_F"]; if (count (TRGM_VAR_EastUnarmedCars select {_x call TRGM_GLOBAL_fnc_isAmmo}) > 0) then { _veh = (TRGM_VAR_EastUnarmedCars select {_x call TRGM_GLOBAL_fnc_isAmmo}); }; _veh; };
DestroyAAAVeh			 = { _veh = ["O_T_APC_Tracked_02_AA_ghex_F"]; if (count TRGM_VAR_EastAntiAir > 0) then { _veh = TRGM_VAR_EastAntiAir; }; _veh; };

sRiflemanFriendInsurg	 = "B_G_Soldier_F";

WoundedSounds	 = ["WoundedGuyA_01","WoundedGuyA_02","WoundedGuyA_03","WoundedGuyA_04","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_07","WoundedGuyA_08","WoundedGuyB_01","WoundedGuyB_02","WoundedGuyB_03","WoundedGuyB_04","WoundedGuyB_05","WoundedGuyB_06","WoundedGuyB_07","WoundedGuyB_08","WoundedGuyC_01","WoundedGuyC_02","WoundedGuyC_03","WoundedGuyC_04","WoundedGuyC_05"];
CivCars			 = ["C_Hatchback_01_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Truck_02_transport_F"];
sCivilian		 = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
HVTCars			 = ["C_SUV_01_F","C_Hatchback_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Hatchback_01_sport_F"];
HVTVans			 = ["C_Van_02_vehicle_F","C_Van_02_transport_F","C_Truck_02_covered_F","C_Van_01_box_F"];
HVTChoppers		 = ["C_Heli_Light_01_civil_F"];
HVTPlanes		 = ["C_Plane_Civil_01_F"];
BombToDefuse	 = ["Land_SatellitePhone_F"];
CheckPointTurret = { _veh = ["O_G_HMG_02_high_F"]; if (count TRGM_VAR_EastTurrets > 0) then { _veh = TRGM_VAR_EastTurrets; }; _veh;};
TargetVehicles	 = ["O_SAM_System_04_F","O_Radar_System_02_F"];
TargetCaches	 = ["Box_FIA_Support_F"];

EnemyFlags = ["Flag_FD_Red_F"];

true;