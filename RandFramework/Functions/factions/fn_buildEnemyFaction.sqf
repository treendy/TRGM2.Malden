format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private _enemyFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_ENEMY_FACTIONS_IDX;
(TREND_AllFactionData select _enemyFactionIndex) params ["_eastClassName", "_eastDisplayName"];

private _baseEastUnitData = [_eastClassName, _eastDisplayName] call TREND_fnc_getUnitDataByFaction;
private _baseEastVehData = [_eastClassName, _eastDisplayName] call TREND_fnc_getVehicleDataByFaction;

private _eastAppendedData = [_baseEastUnitData, _baseEastVehData, _eastClassName, _eastDisplayName] call TREND_fnc_appendAdditonalFactionData;
_eastAppendedData params ["_eastUnitData", "_eastVehData"];

private _eastUnitArray = [_eastUnitData] call TREND_fnc_getUnitArraysFromUnitData;
_eastUnitArray params ["_eastriflemen", "_eastleaders", "_eastatsoldiers", "_eastaasoldiers", "_eastengineers", "_eastgrenadiers", "_eastmedics", "_eastautoriflemen", "_eastsnipers", "_eastexplosiveSpecs", "_eastpilots", "_eastuavOperators"];

private _eastVehArray = [_eastVehData] call TREND_fnc_getVehicleArraysFromVehData;
_eastVehArray params ["_eastunarmedcars", "_eastarmedcars", "_easttrucks", "_eastapcs", "_easttanks", "_eastartillery", "_eastantiair", "_eastturrets", "_eastunarmedhelicopters", "_eastarmedhelicopters", "_eastplanes", "_eastboats", "_eastmortars"];

TREND_EastRiflemen =  _eastriflemen; publicVariable "TREND_EastRiflemen";
TREND_EastLeaders =  _eastleaders; publicVariable "TREND_EastLeaders";
TREND_EastATSoldiers =  _eastatsoldiers; publicVariable "TREND_EastATSoldiers";
TREND_EastAASoldiers =  _eastaasoldiers; publicVariable "TREND_EastAASoldiers";
TREND_EastEngineers =  _eastengineers; publicVariable "TREND_EastEngineers";
TREND_EastGrenadiers =  _eastgrenadiers; publicVariable "TREND_EastGrenadiers";
TREND_EastMedics =  _eastmedics; publicVariable "TREND_EastMedics";
TREND_EastAutoriflemen =  _eastautoriflemen; publicVariable "TREND_EastAutoriflemen";
TREND_EastSnipers =  _eastsnipers; publicVariable "TREND_EastSnipers";
TREND_EastExpSpecs =  _eastexplosiveSpecs; publicVariable "TREND_EastExpSpecs";
TREND_EastPilots =  _eastpilots; publicVariable "TREND_EastPilots";
TREND_EastUAVOps = _eastuavOperators; publicVariable "TREND_EastUAVOps";

TREND_EastUnarmedCars =  _eastunarmedcars + _easttrucks; publicVariable "TREND_EastUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TREND_EastArmedCars =  _eastarmedcars; publicVariable "TREND_EastArmedCars";
TREND_EastAPCs =  _eastapcs; publicVariable "TREND_EastAPCs";
TREND_EastTanks =  _easttanks; publicVariable "TREND_EastTanks";
TREND_EastArtillery =  _eastartillery; publicVariable "TREND_EastArtillery";
TREND_EastAntiAir =  _eastantiair; publicVariable "TREND_EastAntiAir";
TREND_EastTurrets =  _eastturrets; publicVariable "TREND_EastTurrets";
TREND_EastUnarmedHelos =  _eastunarmedhelicopters; publicVariable "TREND_EastUnarmedHelos";
TREND_EastArmedHelos =  _eastarmedhelicopters; publicVariable "TREND_EastArmedHelos";
TREND_EastHelos =  (_eastunarmedhelicopters + _eastarmedhelicopters); publicVariable "TREND_EastHelos";
TREND_EastPlanes =  _eastplanes; publicVariable "TREND_EastPlanes";
TREND_EastBoats =  _eastboats; publicVariable "TREND_EastBoats";
TREND_EastMortars = _eastmortars; publicVariable "TREND_EastMortars";

sRifleman 		= { _unit = "O_T_Soldier_F"; if (count TREND_EastRiflemen > 0) then { _unit = selectRandom TREND_EastRiflemen; }; _unit; };
sTeamleader 	= { _unit = "O_T_Soldier_TL_F"; if (count TREND_EastLeaders > 0) then { _unit = selectRandom TREND_EastLeaders; }; _unit; };
sATMan 			= { _unit = "O_T_Soldier_LAT_F"; if (count TREND_EastATSoldiers > 0) then { _unit = selectRandom TREND_EastATSoldiers; }; _unit; };
sAAMan 			= { _unit = "O_T_Soldier_AA_F"; if (count TREND_EastAASoldiers > 0) then { _unit = selectRandom TREND_EastAASoldiers; }; _unit; };
sEngineer 		= { _unit = "O_T_Engineer_F"; if (count TREND_EastEngineers > 0) then { _unit = selectRandom TREND_EastEngineers; }; _unit; };
sGrenadier 		= { _unit = "O_T_Soldier_GL_F"; if (count TREND_EastGrenadiers > 0) then { _unit = selectRandom TREND_EastGrenadiers; }; _unit; };
sMedic 			= { _unit = "O_T_Medic_F"; if (count TREND_EastMedics > 0) then { _unit = selectRandom TREND_EastMedics; }; _unit; };
sMachineGunMan 	= { _unit = "O_T_Soldier_AR_F"; if (count TREND_EastAutoriflemen > 0) then { _unit = selectRandom TREND_EastAutoriflemen; }; _unit; };
sSniper 		= { _unit = "O_T_Sniper_F"; if (count TREND_EastSnipers > 0) then { _unit = selectRandom TREND_EastSnipers; }; _unit; };
sExpSpec 		= { _unit = "O_T_Soldier_Exp_F"; if (count TREND_EastExpSpecs > 0) then { _unit = selectRandom TREND_EastExpSpecs; }; _unit; };
sEnemyHeliPilot = { _unit = "O_T_Helipilot_F"; if (count TREND_EastPilots > 0) then { _unit = selectRandom TREND_EastPilots; }; _unit; };

sTank1ArmedCar			 = { _veh = "O_T_LSV_02_armed_F"; if (count TREND_EastArmedCars > 0) then { _veh = selectRandom TREND_EastArmedCars; }; _veh; };
sTank2APC				 = { _veh = "O_APC_Wheeled_02_rcws_v2_F"; if (count TREND_EastAPCs > 0) then { _veh = selectRandom TREND_EastAPCs; }; _veh; };
sTank3Tank				 = { _veh = "O_MBT_02_cannon_F"; if (count TREND_EastTanks > 0) then { _veh = selectRandom TREND_EastTanks; }; _veh; };
sAAAVeh					 = { _veh = "O_APC_Tracked_02_AA_F"; if (count TREND_EastAntiAir > 0) then { _veh = selectRandom TREND_EastAntiAir; }; _veh; };
sMortar					 = { _veh = ["O_Mortar_01_F"]; if (count TREND_EastMortars > 0) then { _veh = TREND_EastMortars; }; _veh; };
sArtilleryVeh			 = { _veh = ["O_MBT_02_arty_F"]; if (count TREND_EastArtillery > 0) then { _veh = TREND_EastArtillery; }; _veh; };
sBoatUnit				 = { _veh = "O_Boat_Armed_01_hmg_F"; if (count TREND_EastBoats > 0) then { _veh = selectRandom TREND_EastBoats; }; _veh; };
ReinforceVehicle		 = { _veh = "O_Heli_Light_02_unarmed_F"; if (count (TREND_EastHelos select {_x call TREND_fnc_isTransport;}) > 0) then { _veh = selectRandom (TREND_EastHelos select {_x call TREND_fnc_isTransport;}); }; _veh; };
EnemyAirToAirSupports	 = { _veh = ["O_Plane_Fighter_02_F"]; if (count TREND_EastPlanes > 0) then { _veh = TREND_EastPlanes; }; _veh; };
EnemyAirToGroundSupports = { _veh = ["O_Heli_Light_02_dynamicLoadout_F"]; if (count TREND_EastArmedHelos > 0) then { _veh = TREND_EastArmedHelos; }; _veh; };
EnemyAirScout			 = { _veh = ["O_Heli_Light_02_dynamicLoadout_F"]; if (count TREND_EastArmedHelos > 0) then { _veh = TREND_EastArmedHelos; }; _veh; };
UnarmedScoutVehicles	 = { _veh = ["O_Truck_02_covered_F"]; if (count TREND_EastUnarmedCars > 0) then { _veh = TREND_EastUnarmedCars; }; _veh; };
EnemyBaseChoppers		 = { _veh = ["O_Heli_Light_02_unarmed_F"]; if (count TREND_EastUnarmedHelos > 0) then { _veh = TREND_EastUnarmedHelos; }; _veh; };




private _guerFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_MILITIA_FACTIONS_IDX;
(TREND_AllFactionData select _guerFactionIndex) params ["_guerClassName", "_guerDisplayName"];

private _baseGuerUnitData = [_guerClassName, _guerDisplayName] call TREND_fnc_getUnitDataByFaction;
private _baseGuerVehData = [_guerClassName, _guerDisplayName] call TREND_fnc_getVehicleDataByFaction;

private _guerAppendedData = [_baseGuerUnitData, _baseGuerVehData, _guerClassName, _guerDisplayName] call TREND_fnc_appendAdditonalFactionData;
_guerAppendedData params ["_guerUnitData", "_guerVehData"];

private _guerUnitArray = [_guerUnitData] call TREND_fnc_getUnitArraysFromUnitData;
_guerUnitArray params ["_guerriflemen", "_guerleaders", "_gueratsoldiers", "_gueraasoldiers", "_guerengineers", "_guergrenadiers", "_guermedics", "_guerautoriflemen", "_guersnipers", "_guerexplosiveSpecs", "_guerpilots", "_gueruavOperators"];

private _guerVehArray = [_guerVehData] call TREND_fnc_getVehicleArraysFromVehData;
_guerVehArray params ["_guerunarmedcars", "_guerarmedcars", "_guertrucks", "_guerapcs", "_guertanks", "_guerartillery", "_guerantiair", "_guerturrets", "_guerunarmedhelicopters", "_guerarmedhelicopters", "_guerplanes", "_guerboats", "_guermortars"];

TREND_GuerRiflemen =  _guerriflemen; publicVariable "TREND_GuerRiflemen";
TREND_GuerLeaders =  _guerleaders; publicVariable "TREND_GuerLeaders";
TREND_GuerATSoldiers =  _gueratsoldiers; publicVariable "TREND_GuerATSoldiers";
TREND_GuerAASoldiers =  _gueraasoldiers; publicVariable "TREND_GuerAASoldiers";
TREND_GuerEngineers =  _guerengineers; publicVariable "TREND_GuerEngineers";
TREND_GuerGrenadiers =  _guergrenadiers; publicVariable "TREND_GuerGrenadiers";
TREND_GuerMedics =  _guermedics; publicVariable "TREND_GuerMedics";
TREND_GuerAutoriflemen =  _guerautoriflemen; publicVariable "TREND_GuerAutoriflemen";
TREND_GuerSnipers =  _guersnipers; publicVariable "TREND_GuerSnipers";
TREND_GuerExpSpecs =  _guerexplosiveSpecs; publicVariable "TREND_GuerExpSpecs";
TREND_GuerPilots =  _guerpilots; publicVariable "TREND_GuerPilots";
TREND_GuerUAVOps = _gueruavOperators; publicVariable "TREND_GuerUAVOps";

TREND_GuerUnarmedCars =  _guerunarmedcars + _guertrucks; publicVariable "TREND_GuerUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TREND_GuerArmedCars =  _guerarmedcars; publicVariable "TREND_GuerArmedCars";
TREND_GuerAPCs =  _guerapcs; publicVariable "TREND_GuerAPCs";
TREND_GuerTanks =  _guertanks; publicVariable "TREND_GuerTanks";
TREND_GuerArtillery =  _guerartillery; publicVariable "TREND_GuerArtillery";
TREND_GuerAntiAir =  _guerantiair; publicVariable "TREND_GuerAntiAir";
TREND_GuerTurrets =  _guerturrets; publicVariable "TREND_GuerTurrets";
TREND_GuerUnarmedHelos =  _guerunarmedhelicopters; publicVariable "TREND_GuerUnarmedHelos";
TREND_GuerArmedHelos =  _guerarmedhelicopters; publicVariable "TREND_GuerArmedHelos";
TREND_GuerHelos =  (_guerunarmedhelicopters + _guerarmedhelicopters); publicVariable "TREND_GuerHelos";
TREND_GuerPlanes =  _guerplanes; publicVariable "TREND_GuerPlanes";
TREND_GuerBoats =  _guerboats; publicVariable "TREND_GuerBoats";
TREND_GuerMortars = _guermortars; publicVariable "TREND_GuerMortars";

sRiflemanMilitia 		= { _unit = "I_G_Soldier_F"; if (count TREND_GuerRiflemen > 0) then { _unit = selectRandom TREND_GuerRiflemen; }; _unit; };
sTeamleaderMilitia 		= { _unit = "I_G_Soldier_SL_F"; if (count TREND_GuerLeaders > 0) then { _unit = selectRandom TREND_GuerLeaders; }; _unit; };
sATManMilitia 			= { _unit = "I_G_Soldier_LAT_F"; if (count TREND_GuerATSoldiers > 0) then { _unit = selectRandom TREND_GuerATSoldiers; }; _unit; };
sAAManMilitia 			= { _unit = "I_G_Soldier_LAT_F"; if (count TREND_GuerAASoldiers > 0) then { _unit = selectRandom TREND_GuerAASoldiers; }; _unit; };
sEngineerMilitia 		= { _unit = "I_G_Engineer_F"; if (count TREND_GuerEngineers > 0) then { _unit = selectRandom TREND_GuerEngineers; }; _unit; };
sGrenadierMilitia 		= { _unit = "I_G_Soldier_GL_F"; if (count TREND_GuerGrenadiers > 0) then { _unit = selectRandom TREND_GuerGrenadiers; }; _unit; };
sMedicMilitia 			= { _unit = "I_G_Medic_F"; if (count TREND_GuerMedics > 0) then { _unit = selectRandom TREND_GuerMedics; }; _unit; };
sMachineGunManMilitia 	= { _unit = "I_G_Soldier_AR_F"; if (count TREND_GuerAutoriflemen > 0) then { _unit = selectRandom TREND_GuerAutoriflemen; }; _unit; };
sSniperMilitia 			= { _unit = "I_G_Soldier_M_F"; if (count TREND_GuerSnipers > 0) then { _unit = selectRandom TREND_GuerSnipers; }; _unit; };
sExpSpecMilitia 		= { _unit = "I_G_Soldier_Exp_F"; if (count TREND_GuerExpSpecs > 0) then { _unit = selectRandom TREND_GuerExpSpecs; }; _unit; };
sEnemyHeliPilotMilitia 	= { _unit = "I_helipilot_F"; if (count TREND_GuerPilots > 0) then { _unit = selectRandom TREND_GuerPilots; }; _unit; };

sTank1ArmedCarMilitia = { _veh = "I_C_Offroad_02_LMG_F"; if (count TREND_GuerArmedCars > 0) then { _veh = selectRandom TREND_GuerArmedCars; }; _veh; };
sTank2APCMilitia 	  = { _veh = "I_E_APC_tracked_03_cannon_F"; if (count TREND_GuerAPCs > 0) then { _veh = selectRandom TREND_GuerAPCs; }; _veh; };
sTank3TankMilitia	  = { _veh = "I_LT_01_AT_F"; if (count TREND_GuerTanks > 0) then { _veh = selectRandom TREND_GuerTanks; }; _veh; };
sAAAVehMilitia 		  = { _veh = "I_LT_01_AA_F"; if (count TREND_GuerAntiAir > 0) then { _veh = selectRandom TREND_GuerAntiAir; }; _veh; };
sMortarMilitia		  = { _veh = ["I_Mortar_01_F"]; if (count TREND_GuerMortars > 0) then { _veh = TREND_GuerMortars; }; _veh; };

ReinforceVehicleMilitia = { _veh = "I_E_Heli_light_03_unarmed_F"; if (count (TREND_GuerHelos select {_x call TREND_fnc_isTransport;}) > 0) then { _veh = selectRandom (TREND_GuerHelos select {_x call TREND_fnc_isTransport;}); }; _veh; };



/// Mission Required Vehicles! ///

InformantClasses 		 = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses		 = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck		 = ["O_Truck_03_device_F"];
SideRadioClassNames		 = ["Land_PortableGenerator_01_F"];
sideAmmoTruck			 = { _veh = ["O_Truck_03_ammo_F"]; if (count (TREND_EastUnarmedCars select {_x call TREND_fnc_isAmmo}) > 0) then { _veh = (TREND_EastUnarmedCars select {_x call TREND_fnc_isAmmo}); }; _veh; };
DestroyAAAVeh			 = { _veh = ["O_T_APC_Tracked_02_AA_ghex_F"]; if (count TREND_EastAntiAir > 0) then { _veh = TREND_EastAntiAir; }; _veh; };

sRiflemanFriendInsurg	 = "B_G_Soldier_F";

WoundedSounds	 = ["WoundedGuyA_01","WoundedGuyA_02","WoundedGuyA_03","WoundedGuyA_04","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_07","WoundedGuyA_08","WoundedGuyB_01","WoundedGuyB_02","WoundedGuyB_03","WoundedGuyB_04","WoundedGuyB_05","WoundedGuyB_06","WoundedGuyB_07","WoundedGuyB_08","WoundedGuyC_01","WoundedGuyC_02","WoundedGuyC_03","WoundedGuyC_04","WoundedGuyC_05"];
CivCars			 = ["C_Hatchback_01_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Truck_02_transport_F"];
sCivilian		 = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
HVTCars			 = ["C_SUV_01_F","C_Hatchback_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Hatchback_01_sport_F"];
HVTVans			 = ["C_Van_02_vehicle_F","C_Van_02_transport_F","C_Truck_02_covered_F","C_Van_01_box_F"];
HVTChoppers		 = ["C_Heli_Light_01_civil_F"];
HVTPlanes		 = ["C_Plane_Civil_01_F"];
BombToDefuse	 = ["Land_SatellitePhone_F"];
CheckPointTurret = { _veh = ["O_G_HMG_02_high_F"]; if (count TREND_EastTurrets > 0) then { _veh = TREND_EastTurrets; }; _veh;};
TargetVehicles	 = ["O_SAM_System_04_F","O_Radar_System_02_F"];
TargetCaches	 = ["Box_FIA_Support_F"];

EnemyFlags = ["Flag_FD_Red_F"];

true;