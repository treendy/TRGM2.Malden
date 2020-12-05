format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private _friendlyFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_FRIENDLY_FACTIONS_IDX;
(TREND_WestFactionData select _friendlyFactionIndex) params ["_westClassName", "_westDisplayName"];


private _westUnitData = [_westClassName, _westDisplayName] call TREND_fnc_getUnitDataByFaction;
private _westVehData = [_westClassName, _westDisplayName] call TREND_fnc_getVehicleDataByFaction;

if ("gm_fc_DK" isEqualTo _westClassName || "gm_fc_GE" isEqualTo _westClassName) then {
	_westUnitData append (["gm_fc_GE_bgs","West Germany (Borderguards)"] call TREND_fnc_getUnitDataByFaction);
	_westVehData append (["gm_fc_GE_bgs","West Germany (Borderguards)"] call TREND_fnc_getVehicleDataByFaction);
};
if ("gm_fc_DK" isEqualTo _westClassName || "gm_fc_GE_bgs" isEqualTo _westClassName) then {
	_westUnitData append (["gm_fc_GE","West Germany"] call TREND_fnc_getUnitDataByFaction);
	_westVehData append (["gm_fc_GE","West Germany"] call TREND_fnc_getVehicleDataByFaction);
};
if (["rhs_faction_usarmy", _westClassName] call BIS_fnc_inString || ["rhs_faction_usmc", _westClassName] call BIS_fnc_inString || "rhs_faction_socom" isEqualTo _westClassName) then {
	_westUnitData append (["rhs_faction_usaf", "USA (USAF)"] call TREND_fnc_getUnitDataByFaction);
	_westUnitData append (["rhs_faction_usn","USA (Navy)"] call TREND_fnc_getUnitDataByFaction);
	_westVehData append (["rhs_faction_usaf", "USA (USAF)"] call TREND_fnc_getVehicleDataByFaction);
	_westVehData append (["rhs_faction_usn","USA (Navy)"] call TREND_fnc_getVehicleDataByFaction);
};
if ("rhs_faction_socom" isEqualTo _westClassName) then {
	_westUnitData append (["rhs_faction_usarmy_wd","USA (Army - W)"] call TREND_fnc_getUnitDataByFaction);
	_westVehData append (["rhs_faction_usarmy_wd","USA (Army - W)"] call TREND_fnc_getVehicleDataByFaction);
};
if ("rhsgref_faction_cdf_ground_b" isEqualTo _westClassName) then {
	_westUnitData append (["rhsgref_faction_cdf_air_b","CDF (Air Forces)"] call TREND_fnc_getUnitDataByFaction);
	_westUnitData append (["rhsgref_faction_cdf_ng_b","CDF (National Guard)"] call TREND_fnc_getUnitDataByFaction);
	_westVehData append (["rhsgref_faction_cdf_air_b","CDF (Air Forces)"] call TREND_fnc_getVehicleDataByFaction);
	_westVehData append (["rhsgref_faction_cdf_ng_b","CDF (National Guard)"] call TREND_fnc_getVehicleDataByFaction);
};

_riflemen = []; _leaders = []; _atsoldiers = []; _aasoldiers = []; _engineers = []; _grenadiers = []; _medics = []; _autoriflemen = []; _snipers = []; _explosiveSpecs = []; _pilots = []; _uavOperators = [];
{
	_x params ["_className", "_dispName", "_icon", "_calloutName", ["_isMedic", 0], ["_isEngineer", 0], ["_isExpSpecialist", 0], ["_isUAVHacker", 0]];
	if (isNil "_className" ||isNil "_dispName" || isNil "_icon" || isNil "_calloutName") then {

	} else {
		if (["Asst", _dispName] call BIS_fnc_inString || ["Assi", _dispName] call BIS_fnc_inString || ["Story", _dispName] call BIS_fnc_inString || ["Support", _className] call BIS_fnc_inString || ["Crew", _className] call BIS_fnc_inString) then {
			// Do nothing for these units. (Currently removing any "assistant", "crew", and "support" type units, since they are generally redundant)
		} else {
			switch (_icon) do {
				case "iconManEngineer":	 { _engineers pushBackUnique _className; };
				case "iconManMedic": 	 { _medics pushBackUnique _className; };
				case "iconManExplosive": { _explosiveSpecs pushBackUnique _className; };
				case "iconManLeader":	 { _leaders pushBackUnique _className; };
				case "iconManOfficer":	 { _leaders pushBackUnique _className; };
				case "iconManMG":		 { _autoriflemen pushBackUnique _className; };
				case "iconManAT":		 { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _aasoldiers pushBackUnique _className; } else { _atsoldiers pushBackUnique _className; }; };
				default {
					if (_isEngineer isEqualTo 1) then { _engineers pushBackUnique _className; };
					if (_isMedic isEqualTo 1) then { _medics pushBackUnique _className; };
					if (_isExpSpecialist isEqualTo 1) then { _explosiveSpecs pushBackUnique _className; };
					if (_isUAVHacker isEqualTo 1) then { _uavOperators pushBackUnique _className; };
					if (["Auto", _dispName, true] call BIS_fnc_inString || ["Machine", _dispName, true] call BIS_fnc_inString) then { _autoriflemen pushBackUnique _className; };
					if (_calloutName isEqualTo "AT soldier") then { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _aasoldiers pushBackUnique _className; } else { _atsoldiers pushBackUnique _className; }; };
					if ((_icon isEqualTo "iconMan")) then { if (_calloutName isEqualTo "sniper") then { _snipers pushBackUnique _className; } else { if (["Grenadier", _dispName] call BIS_fnc_inString || ["Grenadier", _className] call BIS_fnc_inString) then { _grenadiers pushBackUnique _className; } else { if (["Pilot", _dispName] call BIS_fnc_inString || ["Pilot", _className] call BIS_fnc_inString) then { _pilots pushBackUnique _className; } else { _riflemen pushBackUnique _className; }; }; }; };
				};
			};
		};
	};
} forEach _westUnitData;

private _westUnitArray = [_riflemen, _leaders, _atsoldiers, _aasoldiers, _engineers, _grenadiers, _medics, _autoriflemen, _snipers, _explosiveSpecs, _pilots, _uavOperators];
_westUnitArray params ["_westriflemen", "_westleaders", "_westatsoldiers", "_westaasoldiers", "_westengineers", "_westgrenadiers", "_westmedics", "_westautoriflemen", "_westsnipers", "_westexplosiveSpecs", "_westpilots", "_westuavOperators"];

_unarmedcars = []; _armedcars = []; _trucks = []; _apcs = []; _tanks = []; _artillery = []; _antiair = []; _turrets = []; _unarmedhelicopters = []; _armedhelicopters = []; _planes = []; _boats = []; _mortars = [];
{
	_x params [["_className", ""], ["_dispName", ""], ["_calloutName", ""], ["_category", ""], ["_isTransport", false], ["_isArmed", false]];

	if (isNil "_className" || isNil "_dispName" || isNil "_calloutName" || isNil "_category") then {

	} else {
		if (["GMG", _dispName] call BIS_fnc_inString || ["Quadbike", _className] call BIS_fnc_inString || ["Designator", _className] call BIS_fnc_inString || ["Radar", _className] call BIS_fnc_inString || ["SAM", _className] call BIS_fnc_inString) then {
			// Do nothing for these vehs. (Currently removing most "GMG" type vehs, since they are usually OP for small units)
		} else {
			if (_calloutName isEqualTo "mortar") then {
				_mortars pushBackUnique _className;
			} else {
				switch (_category) do {
					case "Turrets": 	{ _turrets pushBackUnique _className; };
					case "Boats": 		{ _boats pushBackUnique _className; };
					case "Boat": 		{ _boats pushBackUnique _className; };
					case "Artillery": 	{ _artillery pushBackUnique _className; };
					case "Anti-Air": 	{ _antiair pushBackUnique _className; };
					case "Planes": 		{ _planes pushBackUnique _className; };
					case "Plane": 		{ _planes pushBackUnique _className; };
					case "APCs": 		{ _apcs pushBackUnique _className; };
					case "APC": 		{ _apcs pushBackUnique _className; };
					case "IFV": 		{ _apcs pushBackUnique _className; };
					case "Tanks": 		{ _tanks pushBackUnique _className; };
					case "Tank": 		{ _tanks pushBackUnique _className; };
					case "Helicopters": { if (_isArmed) then { _armedhelicopters pushBackUnique _className; } else { _unarmedhelicopters pushBackUnique _className; }; };
					case "Helicopter": 	{ if (_isArmed) then { _armedhelicopters pushBackUnique _className; } else { _unarmedhelicopters pushBackUnique _className; }; };
					case "Cars": 		{ if (_isArmed) then { _armedcars pushBackUnique _className; } else { if (_isTransport) then { _trucks pushBackUnique _className; } else { _unarmedcars pushBackUnique _className; }; }; };
					case "Car": 		{ if (_isArmed) then { _armedcars pushBackUnique _className; } else { if (_isTransport) then { _trucks pushBackUnique _className; } else { _unarmedcars pushBackUnique _className; }; }; };
					case "MRAP": 		{ if (_isArmed) then { _armedcars pushBackUnique _className; } else { if (_isTransport) then { _trucks pushBackUnique _className; } else { _unarmedcars pushBackUnique _className; }; }; };
					case "Truck": 		{ if (_isArmed) then { _armedcars pushBackUnique _className; } else { if (_isTransport) then { _trucks pushBackUnique _className; } else { _unarmedcars pushBackUnique _className; }; }; };
					default { };
				};
			};
		};
	};
} forEach _westVehData;

private _westVehArray = [_unarmedcars, _armedcars, _trucks, _apcs, _tanks, _artillery, _antiair, _turrets, _unarmedhelicopters, _armedhelicopters, _planes, _boats, _mortars];
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
TREND_WestPlanes =  _westplanes; publicVariable "TREND_WestPlanes";
TREND_WestBoats =  _westboats; publicVariable "TREND_WestBoats";
TREND_WestMortars = _westmortars; publicVariable "TREND_WestMortars";

FriendlyScoutVehicles		 = call { _veh = ["B_T_MRAP_01_F","B_T_LSV_01_unarmed_F"]; if (count TREND_WestUnarmedCars > 0) then { _veh = TREND_WestUnarmedCars; }; _veh; };
FriendlyCheckpointUnits		 = call { _unit = ["B_Soldier_F"]; if (count TREND_WestRiflemen > 0) then { _unit = TREND_WestRiflemen; }; _unit; };
FriendlyFastResponseVehicles = call { _veh = ["B_T_MRAP_01_F"]; if (count TREND_WestArmedCars > 0) then { _veh = TREND_WestArmedCars; }; _veh; };
SupplySupportChopperOptions	 = call { _veh = ["B_Heli_Transport_03_unarmed_F"]; if (count TREND_WestUnarmedHelos > 0) then { _veh = TREND_WestUnarmedHelos; }; _veh; };
AirSupportOptions			 = call { _veh = ["B_Plane_CAS_01_dynamicLoadout_F"]; if (count TREND_WestPlanes > 0) then { _veh = TREND_WestPlanes; }; _veh; };
ArtiSupportOptions			 = call { _veh = ["B_MBT_01_arty_F"]; if (count TREND_WestArtillery > 0) then { _veh = selectRandom TREND_WestArtillery; }; _veh; };

FriendlyUnarmedCar			 = call { _veh = ["B_MRAP_01_F"]; if (count TREND_WestUnarmedCars > 0) then { _veh = TREND_WestUnarmedCars; }; _veh; };
FriendlyMedicalTruck		 = call { _veh = ["B_Truck_01_medical_F"]; if (count (TREND_WestUnarmedCars select {_x call TREND_fnc_isMedical}) > 0) then { _veh = (TREND_WestUnarmedCars select {_x call TREND_fnc_isMedical}); }; _veh; };
FriendlyArmoredCar			 = call { _veh = ["B_MRAP_01_hmg_F"]; if (count TREND_WestArmedCars > 0) then { _veh = TREND_WestArmedCars; } else { _veh = ["B_MRAP_01_hmg_F"]; }; _veh; };
FriendlyFuelTruck			 = call { _veh = ["B_Truck_01_fuel_F"]; if (count (TREND_WestUnarmedCars select {_x call TREND_fnc_isFuel}) > 0) then { _veh = (TREND_WestUnarmedCars select {_x call TREND_fnc_isFuel}); }; _veh; };

FriendlyJet					 = call { _veh = ["B_Plane_Fighter_01_Stealth_F"]; if (count TREND_WestPlanes > 0) then { _veh = TREND_WestPlanes; }; _veh; };
FriendlyChopper				 = call { _veh = ["B_Heli_Transport_01_camo_F","B_Heli_Attack_01_F"]; if (count TREND_WestArmedHelos > 0) then { _veh = TREND_WestArmedHelos; }; _veh; };

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