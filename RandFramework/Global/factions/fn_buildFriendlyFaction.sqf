format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

private _friendlyFactionIndex = TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_FRIENDLY_FACTIONS_IDX;
(TRGM_VAR_AllFactionData select _friendlyFactionIndex) params ["_westClassName", "_westDisplayName"];

private _baseWestUnitData = [_westClassName, _westDisplayName] call TRGM_GLOBAL_fnc_getUnitDataByFaction;
private _baseWestVehData = [_westClassName, _westDisplayName] call TRGM_GLOBAL_fnc_getVehicleDataByFaction;

private _westAppendedData = [_baseWestUnitData, _baseWestVehData, _westClassName, _westDisplayName] call TRGM_GLOBAL_fnc_appendAdditonalFactionData;
_westAppendedData params ["_westUnitData", "_westVehData"];

private _westUnitArray = [_westUnitData] call TRGM_GLOBAL_fnc_getUnitArraysFromUnitData;
_westUnitArray params ["_westriflemen", "_westleaders", "_westatsoldiers", "_westaasoldiers", "_westengineers", "_westgrenadiers", "_westmedics", "_westautoriflemen", "_westsnipers", "_westexplosiveSpecs", "_westpilots", "_westuavOperators"];

private _westVehArray = [_westVehData] call TRGM_GLOBAL_fnc_getVehicleArraysFromVehData;
_westVehArray params ["_westunarmedcars", "_westarmedcars", "_westtrucks", "_westapcs", "_westtanks", "_westartillery", "_westantiair", "_westturrets", "_westunarmedhelicopters", "_westarmedhelicopters", "_westplanes", "_westboats", "_westmortars"];

TRGM_VAR_WestRiflemen =  _westriflemen; publicVariable "TRGM_VAR_WestRiflemen";
TRGM_VAR_WestLeaders =  _westleaders; publicVariable "TRGM_VAR_WestLeaders";
TRGM_VAR_WestATSoldiers =  _westatsoldiers; publicVariable "TRGM_VAR_WestATSoldiers";
TRGM_VAR_WestAASoldiers =  _westaasoldiers; publicVariable "TRGM_VAR_WestAASoldiers";
TRGM_VAR_WestEngineers =  _westengineers; publicVariable "TRGM_VAR_WestEngineers";
TRGM_VAR_WestGrenadiers =  _westgrenadiers; publicVariable "TRGM_VAR_WestGrenadiers";
TRGM_VAR_WestMedics =  _westmedics; publicVariable "TRGM_VAR_WestMedics";
TRGM_VAR_WestAutoriflemen =  _westautoriflemen; publicVariable "TRGM_VAR_WestAutoriflemen";
TRGM_VAR_WestSnipers =  _westsnipers; publicVariable "TRGM_VAR_WestSnipers";
TRGM_VAR_WestExpSpecs =  _westexplosiveSpecs; publicVariable "TRGM_VAR_WestExpSpecs";
TRGM_VAR_WestPilots =  _westpilots; publicVariable "TRGM_VAR_WestPilots";
TRGM_VAR_WestUAVOps = _westuavOperators; publicVariable "TRGM_VAR_WestUAVOps";

TRGM_VAR_WestUnarmedCars =  _westunarmedcars + _westtrucks; publicVariable "TRGM_VAR_WestUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TRGM_VAR_WestArmedCars =  _westarmedcars; publicVariable "TRGM_VAR_WestArmedCars";
TRGM_VAR_WestAPCs =  _westapcs; publicVariable "TRGM_VAR_WestAPCs";
TRGM_VAR_WestTanks =  _westtanks; publicVariable "TRGM_VAR_WestTanks";
TRGM_VAR_WestArtillery =  _westartillery; publicVariable "TRGM_VAR_WestArtillery";
TRGM_VAR_WestAntiAir =  _westantiair; publicVariable "TRGM_VAR_WestAntiAir";
TRGM_VAR_WestTurrets =  _westturrets; publicVariable "TRGM_VAR_WestTurrets";
TRGM_VAR_WestUnarmedHelos =  _westunarmedhelicopters; publicVariable "TRGM_VAR_WestUnarmedHelos";
TRGM_VAR_WestArmedHelos =  _westarmedhelicopters; publicVariable "TRGM_VAR_WestArmedHelos";
TRGM_VAR_WestHelos =  (_westarmedhelicopters + _westunarmedhelicopters); publicVariable "TRGM_VAR_WestHelos";
TRGM_VAR_WestPlanes =  _westplanes; publicVariable "TRGM_VAR_WestPlanes";
TRGM_VAR_WestBoats =  _westboats; publicVariable "TRGM_VAR_WestBoats";
TRGM_VAR_WestMortars = _westmortars; publicVariable "TRGM_VAR_WestMortars";

FriendlyScoutVehicles		 = { _veh = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F"]; if (count TRGM_VAR_WestUnarmedCars > 0) then { _veh = TRGM_VAR_WestUnarmedCars; }; _veh; };
FriendlyCheckpointUnits		 = { _unit = ["B_Soldier_F"]; if (count TRGM_VAR_WestRiflemen > 0) then { _unit = TRGM_VAR_WestRiflemen; }; _unit; };
FriendlyFastResponseVehicles = { _veh = ["B_T_MRAP_01_F"]; if (count TRGM_VAR_WestArmedCars > 0) then { _veh = TRGM_VAR_WestArmedCars; }; _veh; };
SupplySupportChopperOptions	 = { _veh = ["B_Heli_Transport_03_unarmed_F"]; if (count (TRGM_VAR_WestHelos select {_x call TRGM_GLOBAL_fnc_isTransport}) > 0) then { _veh = (TRGM_VAR_WestHelos select {_x call TRGM_GLOBAL_fnc_isTransport}); }; _veh; };
AirSupportOptions			 = { _veh = ["B_Plane_CAS_01_dynamicLoadout_F"]; if (count TRGM_VAR_WestPlanes > 0) then { _veh = TRGM_VAR_WestPlanes; }; _veh; };
ArtiSupportOptions			 = { _veh = ["B_MBT_01_arty_F"]; if (count TRGM_VAR_WestArtillery > 0) then { _veh = selectRandom TRGM_VAR_WestArtillery; }; _veh; };

FriendlyUnarmedCar			 = { _veh = ["B_MRAP_01_F"]; if (count TRGM_VAR_WestUnarmedCars > 0) then { _veh = TRGM_VAR_WestUnarmedCars; }; _veh; };
FriendlyMedicalTruck		 = { _veh = ["B_Truck_01_medical_F"]; if (count (TRGM_VAR_WestUnarmedCars select {_x call TRGM_GLOBAL_fnc_isMedical}) > 0) then { _veh = (TRGM_VAR_WestUnarmedCars select {_x call TRGM_GLOBAL_fnc_isMedical}); }; _veh; };
FriendlyArmoredCar			 = { _veh = ["B_MRAP_01_hmg_F"]; if (count TRGM_VAR_WestArmedCars > 0) then { _veh = TRGM_VAR_WestArmedCars; } else { _veh = ["B_MRAP_01_hmg_F"]; }; _veh; };
FriendlyFuelTruck			 = { _veh = ["B_Truck_01_fuel_F"]; if (count (TRGM_VAR_WestUnarmedCars select {_x call TRGM_GLOBAL_fnc_isFuel}) > 0) then { _veh = (TRGM_VAR_WestUnarmedCars select {_x call TRGM_GLOBAL_fnc_isFuel}); }; _veh; };

FriendlyJet					 = { _veh = ["B_Plane_Fighter_01_Stealth_F"]; if (count (TRGM_VAR_WestPlanes select {_x call TRGM_GLOBAL_fnc_isArmed && !(_x call TRGM_GLOBAL_fnc_isTransport)}) > 0) then { _veh = (TRGM_VAR_WestPlanes select {_x call TRGM_GLOBAL_fnc_isArmed && !(_x call TRGM_GLOBAL_fnc_isTransport)}); }; _veh; };
FriendlyChopper				 = { _veh = ["B_Heli_Transport_01_camo_F","B_Heli_Attack_01_F"]; if (count (TRGM_VAR_WestHelos select {_x call TRGM_GLOBAL_fnc_isArmed && !(_x call TRGM_GLOBAL_fnc_isTransport)}) > 0) then { _veh = (TRGM_VAR_WestHelos select {_x call TRGM_GLOBAL_fnc_isArmed && !(_x call TRGM_GLOBAL_fnc_isTransport)}); }; _veh; };

ReinforceVehicleFriendly	 = { _veh = "B_Heli_Transport_03_unarmed_F"; if (count (TRGM_VAR_WestHelos select {_x call TRGM_GLOBAL_fnc_isTransport;}) > 0) then { _veh = selectRandom (TRGM_VAR_WestHelos select {_x call TRGM_GLOBAL_fnc_isTransport;}); }; _veh; };
fRifleman 		= { _unit = "B_Soldier_F"; if (count TRGM_VAR_WestRiflemen > 0) then { _unit = selectRandom TRGM_VAR_WestRiflemen; }; _unit; };
fTeamleader 	= { _unit = "B_Soldier_TL_F"; if (count TRGM_VAR_WestLeaders > 0) then { _unit = selectRandom TRGM_VAR_WestLeaders; }; _unit; };
fATMan 			= { _unit = "B_Soldier_LAT_F"; if (count TRGM_VAR_WestATSoldiers > 0) then { _unit = selectRandom TRGM_VAR_WestATSoldiers; }; _unit; };
fAAMan 			= { _unit = "B_Soldier_AA_F"; if (count TRGM_VAR_WestAASoldiers > 0) then { _unit = selectRandom TRGM_VAR_WestAASoldiers; }; _unit; };
fEngineer 		= { _unit = "B_Engineer_F"; if (count TRGM_VAR_WestEngineers > 0) then { _unit = selectRandom TRGM_VAR_WestEngineers; }; _unit; };
fGrenadier 		= { _unit = "B_Soldier_GL_F"; if (count TRGM_VAR_WestGrenadiers > 0) then { _unit = selectRandom TRGM_VAR_WestGrenadiers; }; _unit; };
fMedic 			= { _unit = "B_Medic_F"; if (count TRGM_VAR_WestMedics > 0) then { _unit = selectRandom TRGM_VAR_WestMedics; }; _unit; };
fMachineGunMan 	= { _unit = "B_Soldier_AR_F"; if (count TRGM_VAR_WestAutoriflemen > 0) then { _unit = selectRandom TRGM_VAR_WestAutoriflemen; }; _unit; };
fSniper 		= { _unit = "B_Sniper_F"; if (count TRGM_VAR_WestSnipers > 0) then { _unit = selectRandom TRGM_VAR_WestSnipers; }; _unit; };
fExpSpec 		= { _unit = "B_Soldier_Exp_F"; if (count TRGM_VAR_WestExpSpecs > 0) then { _unit = selectRandom TRGM_VAR_WestExpSpecs; }; _unit; };
fPilot			= { _unit = "B_Helipilot_F"; if (count TRGM_VAR_WestPilots > 0) then { _unit = selectRandom TRGM_VAR_WestPilots; }; _unit; };
fUAVOps			= { _unit = "B_soldier_UAV_F"; if (count TRGM_VAR_WestUAVOps > 0) then { _unit = selectRandom TRGM_VAR_WestUAVOps; }; _unit; };

FriendlyVictims				 = ["B_Soldier_unarmed_F"];
FriendlyVictimVehs			 = ["Land_Wreck_Slammer_F","Land_Wreck_Heli_Attack_01_F","Land_HistoricalPlaneWreck_03_F"];
Paramedics					 = ["C_Man_Paramedic_01_F"];
Ambulances					 = ["C_Van_02_medevac_F"];
AirAmbulances				 = ["C_IDAP_Heli_Transport_02_F"];
Police						 = ["B_GEN_Soldier_F"];
PoliceVehicles				 = ["B_GEN_Offroad_01_gen_F","B_GEN_Van_02_vehicle_F"];
Reporters					 = ["C_journalist_F"];
ReporterChoppers			 = ["C_Heli_Light_01_civil_F"];

FriendlyFlags = ["Flag_FD_Blue_F"];

true;