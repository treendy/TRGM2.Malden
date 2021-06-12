format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private _friendlyFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_FRIENDLY_FACTIONS_IDX;
(TREND_AllFactionData select _friendlyFactionIndex) params ["_westClassName", "_westDisplayName"];

private _baseWestUnitData = [_westClassName, _westDisplayName] call TREND_fnc_getUnitDataByFaction;
private _baseWestVehData = [_westClassName, _westDisplayName] call TREND_fnc_getVehicleDataByFaction;

private _westAppendedData = [_baseWestUnitData, _baseWestVehData, _westClassName, _westDisplayName] call TREND_fnc_appendAdditonalFactionData;
_westAppendedData params ["_westUnitData", "_westVehData"];

private _westUnitArray = [_westUnitData] call TREND_fnc_getUnitArraysFromUnitData;
_westUnitArray params ["_westriflemen", "_westleaders", "_westatsoldiers", "_westaasoldiers", "_westengineers", "_westgrenadiers", "_westmedics", "_westautoriflemen", "_westsnipers", "_westexplosiveSpecs", "_westpilots", "_westuavOperators"];

private _westVehArray = [_westVehData] call TREND_fnc_getVehicleArraysFromVehData;
_westVehArray params ["_westunarmedcars", "_westarmedcars", "_westtrucks", "_westapcs", "_westtanks", "_westartillery", "_westantiair", "_westturrets", "_westunarmedhelicopters", "_westarmedhelicopters", "_westplanes", "_westboats", "_westmortars"];

TREND_WestRiflemen =  _westriflemen; publicVariable "TREND_WestRiflemen";
TREND_WestLeaders =  _westleaders; publicVariable "TREND_WestLeaders";
TREND_WestATSoldiers =  _westatsoldiers; publicVariable "TREND_WestATSoldiers";
TREND_WestAASoldiers =  _westaasoldiers; publicVariable "TREND_WestAASoldiers";
TREND_WestEngineers =  _westengineers; publicVariable "TREND_WestEngineers";
TREND_WestGrenadiers =  _westgrenadiers; publicVariable "TREND_WestGrenadiers";
TREND_WestMedics =  _westmedics; publicVariable "TREND_WestMedics";
TREND_WestAutoriflemen =  _westautoriflemen; publicVariable "TREND_WestAutoriflemen";
TREND_WestSnipers =  _westsnipers; publicVariable "TREND_WestSnipers";
TREND_WestExpSpecs =  _westexplosiveSpecs; publicVariable "TREND_WestExpSpecs";
TREND_WestPilots =  _westpilots; publicVariable "TREND_WestPilots";
TREND_WestUAVOps = _westuavOperators; publicVariable "TREND_WestUAVOps";

TREND_WestUnarmedCars =  _westunarmedcars + _westtrucks; publicVariable "TREND_WestUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TREND_WestArmedCars =  _westarmedcars; publicVariable "TREND_WestArmedCars";
TREND_WestAPCs =  _westapcs; publicVariable "TREND_WestAPCs";
TREND_WestTanks =  _westtanks; publicVariable "TREND_WestTanks";
TREND_WestArtillery =  _westartillery; publicVariable "TREND_WestArtillery";
TREND_WestAntiAir =  _westantiair; publicVariable "TREND_WestAntiAir";
TREND_WestTurrets =  _westturrets; publicVariable "TREND_WestTurrets";
TREND_WestUnarmedHelos =  _westunarmedhelicopters; publicVariable "TREND_WestUnarmedHelos";
TREND_WestArmedHelos =  _westarmedhelicopters; publicVariable "TREND_WestArmedHelos";
TREND_WestHelos =  (_westarmedhelicopters + _westunarmedhelicopters); publicVariable "TREND_WestHelos";
TREND_WestPlanes =  _westplanes; publicVariable "TREND_WestPlanes";
TREND_WestBoats =  _westboats; publicVariable "TREND_WestBoats";
TREND_WestMortars = _westmortars; publicVariable "TREND_WestMortars";

FriendlyScoutVehicles		 = { _veh = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F"]; if (count TREND_WestUnarmedCars > 0) then { _veh = TREND_WestUnarmedCars; }; _veh; };
FriendlyCheckpointUnits		 = { _unit = ["B_Soldier_F"]; if (count TREND_WestRiflemen > 0) then { _unit = TREND_WestRiflemen; }; _unit; };
FriendlyFastResponseVehicles = { _veh = ["B_T_MRAP_01_F"]; if (count TREND_WestArmedCars > 0) then { _veh = TREND_WestArmedCars; }; _veh; };
SupplySupportChopperOptions	 = { _veh = ["B_Heli_Transport_03_unarmed_F"]; if (count (TREND_WestHelos select {_x call TREND_fnc_isTransport}) > 0) then { _veh = (TREND_WestHelos select {_x call TREND_fnc_isTransport}); }; _veh; };
AirSupportOptions			 = { _veh = ["B_Plane_CAS_01_dynamicLoadout_F"]; if (count TREND_WestPlanes > 0) then { _veh = TREND_WestPlanes; }; _veh; };
ArtiSupportOptions			 = { _veh = ["B_MBT_01_arty_F"]; if (count TREND_WestArtillery > 0) then { _veh = selectRandom TREND_WestArtillery; }; _veh; };

FriendlyUnarmedCar			 = { _veh = ["B_MRAP_01_F"]; if (count TREND_WestUnarmedCars > 0) then { _veh = TREND_WestUnarmedCars; }; _veh; };
FriendlyMedicalTruck		 = { _veh = ["B_Truck_01_medical_F"]; if (count (TREND_WestUnarmedCars select {_x call TREND_fnc_isMedical}) > 0) then { _veh = (TREND_WestUnarmedCars select {_x call TREND_fnc_isMedical}); }; _veh; };
FriendlyArmoredCar			 = { _veh = ["B_MRAP_01_hmg_F"]; if (count TREND_WestArmedCars > 0) then { _veh = TREND_WestArmedCars; } else { _veh = ["B_MRAP_01_hmg_F"]; }; _veh; };
FriendlyFuelTruck			 = { _veh = ["B_Truck_01_fuel_F"]; if (count (TREND_WestUnarmedCars select {_x call TREND_fnc_isFuel}) > 0) then { _veh = (TREND_WestUnarmedCars select {_x call TREND_fnc_isFuel}); }; _veh; };

FriendlyJet					 = { _veh = ["B_Plane_Fighter_01_Stealth_F"]; if (count (TREND_WestPlanes select {_x call TREND_fnc_isArmed && !(_x call TREND_fnc_isTransport)}) > 0) then { _veh = (TREND_WestPlanes select {_x call TREND_fnc_isArmed && !(_x call TREND_fnc_isTransport)}); }; _veh; };
FriendlyChopper				 = { _veh = ["B_Heli_Transport_01_camo_F","B_Heli_Attack_01_F"]; if (count (TREND_WestHelos select {_x call TREND_fnc_isArmed && !(_x call TREND_fnc_isTransport)}) > 0) then { _veh = (TREND_WestHelos select {_x call TREND_fnc_isArmed && !(_x call TREND_fnc_isTransport)}); }; _veh; };

ReinforceVehicleFriendly	 = { _veh = "B_Heli_Transport_03_unarmed_F"; if (count (TREND_WestHelos select {_x call TREND_fnc_isTransport;}) > 0) then { _veh = selectRandom (TREND_WestHelos select {_x call TREND_fnc_isTransport;}); }; _veh; };
fRifleman 		= { _unit = "B_Soldier_F"; if (count TREND_WestRiflemen > 0) then { _unit = selectRandom TREND_WestRiflemen; }; _unit; };
fTeamleader 	= { _unit = "B_Soldier_TL_F"; if (count TREND_WestLeaders > 0) then { _unit = selectRandom TREND_WestLeaders; }; _unit; };
fATMan 			= { _unit = "B_Soldier_LAT_F"; if (count TREND_WestATSoldiers > 0) then { _unit = selectRandom TREND_WestATSoldiers; }; _unit; };
fAAMan 			= { _unit = "B_Soldier_AA_F"; if (count TREND_WestAASoldiers > 0) then { _unit = selectRandom TREND_WestAASoldiers; }; _unit; };
fEngineer 		= { _unit = "B_Engineer_F"; if (count TREND_WestEngineers > 0) then { _unit = selectRandom TREND_WestEngineers; }; _unit; };
fGrenadier 		= { _unit = "B_Soldier_GL_F"; if (count TREND_WestGrenadiers > 0) then { _unit = selectRandom TREND_WestGrenadiers; }; _unit; };
fMedic 			= { _unit = "B_Medic_F"; if (count TREND_WestMedics > 0) then { _unit = selectRandom TREND_WestMedics; }; _unit; };
fMachineGunMan 	= { _unit = "B_Soldier_AR_F"; if (count TREND_WestAutoriflemen > 0) then { _unit = selectRandom TREND_WestAutoriflemen; }; _unit; };
fSniper 		= { _unit = "B_Sniper_F"; if (count TREND_WestSnipers > 0) then { _unit = selectRandom TREND_WestSnipers; }; _unit; };
fExpSpec 		= { _unit = "B_Soldier_Exp_F"; if (count TREND_WestExpSpecs > 0) then { _unit = selectRandom TREND_WestExpSpecs; }; _unit; };
fPilot			= { _unit = "B_Helipilot_F"; if (count TREND_WestPilots > 0) then { _unit = selectRandom TREND_WestPilots; }; _unit; };
fUAVOps			= { _unit = "B_soldier_UAV_F"; if (count TREND_WestUAVOps > 0) then { _unit = selectRandom TREND_WestUAVOps; }; _unit; };

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