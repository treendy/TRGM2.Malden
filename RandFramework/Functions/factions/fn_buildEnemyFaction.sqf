format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private _enemyFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_ENEMY_FACTIONS_IDX;
(TREND_EastFactionData select _enemyFactionIndex) params ["_eastClassName", "_eastDisplayName"];


private _eastUnitData = [_eastClassName, _eastDisplayName] call TREND_fnc_getUnitDataByFaction;
private _eastVehData = [_eastClassName, _eastDisplayName] call TREND_fnc_getVehicleDataByFaction;

if (["CSAT", _eastDisplayName] call BIS_fnc_inString) then {
	_eastUnitData append (["OPF_V_F","Viper"] call TREND_fnc_getUnitDataByFaction);
	_eastVehData append (["OPF_V_F","Viper"] call TREND_fnc_getVehicleDataByFaction);
};
if (["TEC_CSAT", _eastClassName] call BIS_fnc_inString) then {
	_eastUnitData append (["TEC_CSAT_Navy","CSAT (Iran, Navy)"] call TREND_fnc_getUnitDataByFaction);
	_eastVehData append (["TEC_CSAT_Navy","CSAT (Iran, Navy)"] call TREND_fnc_getVehicleDataByFaction);
	if ("TEC_CSAT_SOF" isEqualTo _eastClassName) then {
		_eastUnitData append (["TEC_CSAT","CSAT (Iran, Arid)"] call TREND_fnc_getUnitDataByFaction);
		_eastVehData append (["TEC_CSAT_Navy","CSAT (Iran, Navy)"] call TREND_fnc_getVehicleDataByFaction);
	};
};
if ("gm_fc_PL" isEqualTo _eastClassName || "gm_fc_GC" isEqualTo _eastClassName) then {
	_eastUnitData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TREND_fnc_getUnitDataByFaction);
	_eastVehData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TREND_fnc_getVehicleDataByFaction);
};
if ("gm_fc_PL" isEqualTo _eastClassName || "gm_fc_GC_bgs" isEqualTo _eastClassName) then {
	_eastUnitData append (["gm_fc_GC","East Germany"] call TREND_fnc_getUnitDataByFaction);
	_eastVehData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TREND_fnc_getVehicleDataByFaction);
};
if ("rhssaf_faction_army_opfor" isEqualTo _eastClassName) then {
	_eastUnitData append (["rhssaf_faction_airforce_opfor","SAF (RVIPVO)"] call TREND_fnc_getUnitDataByFaction);
	_eastVehData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TREND_fnc_getVehicleDataByFaction);
};
if (["rhs_faction", _eastClassName] call BIS_fnc_inString) then {
	switch (_eastClassName) do {
		case "rhs_faction_msv": {
			_eastUnitData append (["rhs_faction_rva","Russia (RVA)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getUnitDataByFaction);

			_eastVehData append (["rhs_faction_rva","Russia (RVA)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getVehicleDataByFaction);
		};
		case "rhs_faction_vdv": {
			_eastUnitData append (["rhs_faction_rva","Russia (RVA)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getUnitDataByFaction);

			_eastVehData append (["rhs_faction_rva","Russia (RVA)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getVehicleDataByFaction);
		};
		case "rhs_faction_vmf": {
			_eastUnitData append (["rhs_faction_msv","Russia (MSV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getUnitDataByFaction);

			_eastVehData append (["rhs_faction_msv","Russia (MSV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getVehicleDataByFaction);
		};
		case "rhs_faction_vv": {
			_eastUnitData append (["rhs_faction_rva","Russia (RVA)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vvs","Russia (VVS - Grey)"] call TREND_fnc_getUnitDataByFaction);

			_eastVehData append (["rhs_faction_rva","Russia (RVA)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vvs","Russia (VVS - Grey)"] call TREND_fnc_getVehicleDataByFaction);
		};
		case "rhs_faction_rva": {
			_eastUnitData append (["rhs_faction_msv","Russia (MSV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getUnitDataByFaction);
			_eastUnitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getUnitDataByFaction);

			_eastVehData append (["rhs_faction_msv","Russia (MSV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vmf","Russia (VMF)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_tv","Russia (TV)"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["OPF_R_F","Spetsnaz"] call TREND_fnc_getVehicleDataByFaction);
			_eastVehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TREND_fnc_getVehicleDataByFaction);
		};
		default { };
	};
};


_riflemen = []; _leaders = []; _atsoldiers = []; _aasoldiers = []; _engineers = []; _grenadiers = []; _medics = []; _autoriflemen = []; _snipers = []; _explosiveSpecs = []; _pilots = []; _uavOperators = [];
{
	_x params ["_className", "_dispName", "_icon", "_calloutName", ["_isMedic", 0], ["_isEngineer", 0], ["_isExpSpecialist", 0], ["_isUAVHacker", 0]];
	if (isNil "_className" ||isNil "_dispName" || isNil "_icon" || isNil "_calloutName") then {

	} else {
		if (["Ass.", _dispName] call BIS_fnc_inString || ["Asst", _dispName] call BIS_fnc_inString || ["Assi", _dispName] call BIS_fnc_inString || ["Story", _dispName] call BIS_fnc_inString || ["Support", _className] call BIS_fnc_inString || ["Crew", _className] call BIS_fnc_inString) then {
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
} forEach _eastUnitData;

private _eastUnitArray = [_riflemen, _leaders, _atsoldiers, _aasoldiers, _engineers, _grenadiers, _medics, _autoriflemen, _snipers, _explosiveSpecs, _pilots, _uavOperators];
_eastUnitArray params ["_eastriflemen", "_eastleaders", "_eastatsoldiers", "_eastaasoldiers", "_eastengineers", "_eastgrenadiers", "_eastmedics", "_eastautoriflemen", "_eastsnipers", "_eastexplosiveSpecs", "_eastpilots", "_eastuavOperators"];

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
} forEach _eastVehData;

private _eastVehArray = [_unarmedcars, _armedcars, _trucks, _apcs, _tanks, _artillery, _antiair, _turrets, _unarmedhelicopters, _armedhelicopters, _planes, _boats, _mortars];
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

TREND_EastUnarmedCars =  _eastunarmedcars + _easttrucks; publicVariable "TREND_EastUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TREND_EastArmedCars =  _eastarmedcars; publicVariable "TREND_EastArmedCars";
TREND_EastAPCs =  _eastapcs; publicVariable "TREND_EastAPCs";
TREND_EastTanks =  _easttanks; publicVariable "TREND_EastTanks";
TREND_EastArtillery =  _eastartillery; publicVariable "TREND_EastArtillery";
TREND_EastAntiAir =  _eastantiair; publicVariable "TREND_EastAntiAir";
TREND_EastTurrets =  _eastturrets; publicVariable "TREND_EastTurrets";
TREND_EastUnarmedHelos =  _eastunarmedhelicopters; publicVariable "TREND_EastUnarmedHelos";
TREND_EastArmedHelos =  _eastarmedhelicopters; publicVariable "TREND_EastArmedHelos";
TREND_EastPlanes =  _eastplanes; publicVariable "TREND_EastPlanes";
TREND_EastBoats =  _eastboats; publicVariable "TREND_EastBoats";
TREND_EastMortars = _eastmortars; publicVariable "TREND_EastMortars";

sRifleman 		= call { _unit = "O_T_Soldier_F"; if (count TREND_EastRiflemen > 0) then { _unit = selectRandom TREND_EastRiflemen; }; _unit; };
sTeamleader 	= call { _unit = "O_T_Soldier_TL_F"; if (count TREND_EastLeaders > 0) then { _unit = selectRandom TREND_EastLeaders; }; _unit; };
sATMan 			= call { _unit = "O_T_Soldier_LAT_F"; if (count TREND_EastATSoldiers > 0) then { _unit = selectRandom TREND_EastATSoldiers; }; _unit; };
sAAMan 			= call { _unit = "O_T_Soldier_AA_F"; if (count TREND_EastAASoldiers > 0) then { _unit = selectRandom TREND_EastAASoldiers; }; _unit; };
sEngineer 		= call { _unit = "O_T_Engineer_F"; if (count TREND_EastEngineers > 0) then { _unit = selectRandom TREND_EastEngineers; }; _unit; };
sGrenadier 		= call { _unit = "O_T_Soldier_GL_F"; if (count TREND_EastGrenadiers > 0) then { _unit = selectRandom TREND_EastGrenadiers; }; _unit; };
sMedic 			= call { _unit = "O_T_Medic_F"; if (count TREND_EastMedics > 0) then { _unit = selectRandom TREND_EastMedics; }; _unit; };
sMachineGunMan 	= call { _unit = "O_T_Soldier_AR_F"; if (count TREND_EastAutoriflemen > 0) then { _unit = selectRandom TREND_EastAutoriflemen; }; _unit; };
sSniper 		= call { _unit = "O_T_Sniper_F"; if (count TREND_EastSnipers > 0) then { _unit = selectRandom TREND_EastSnipers; }; _unit; };
sExpSpec 		= call { _unit = "O_T_Soldier_Exp_F"; if (count TREND_EastExpSpecs > 0) then { _unit = selectRandom TREND_EastExpSpecs; }; _unit; };
sEnemyHeliPilot = call { _unit = "O_T_Helipilot_F"; if (count TREND_EastPilots > 0) then { _unit = selectRandom TREND_EastPilots; }; _unit; };

sTank1ArmedCar			 = call { _veh = "O_T_LSV_02_armed_F"; if (count TREND_EastArmedCars > 0) then { _veh = selectRandom TREND_EastArmedCars; }; _veh; };
sTank2APC				 = call { _veh = "O_APC_Wheeled_02_rcws_v2_F"; if (count TREND_EastAPCs > 0) then { _veh = selectRandom TREND_EastAPCs; }; _veh; };
sTank3Tank				 = call { _veh = "O_MBT_02_cannon_F"; if (count TREND_EastTanks > 0) then { _veh = selectRandom TREND_EastTanks; }; _veh; };
sAAAVeh					 = call { _veh = "O_APC_Tracked_02_AA_F"; if (count TREND_EastAntiAir > 0) then { _veh = selectRandom TREND_EastAntiAir; }; _veh; };
sMortar					 = call { _veh = ["O_Mortar_01_F"]; if (count TREND_EastMortars > 0) then { _veh = TREND_EastMortars; }; _veh; };
sArtilleryVeh			 = call { _veh = "O_MBT_02_arty_F"; if (count TREND_EastArtillery > 0) then { _veh = selectRandom TREND_EastArtillery; }; _veh; };
sBoatUnit				 = call { _veh = "O_Boat_Armed_01_hmg_F"; if (count TREND_EastBoats > 0) then { _veh = selectRandom TREND_EastBoats; }; _veh; };
ReinforceVehicle		 = call { _veh = "O_Heli_Light_02_unarmed_F"; if (count TREND_EastUnarmedHelos > 0) then { _veh = selectRandom TREND_EastUnarmedHelos; }; _veh; };
EnemyAirToAirSupports	 = call { _veh = ["O_Plane_Fighter_02_F"]; if (count TREND_EastPlanes > 0) then { _veh = TREND_EastPlanes; }; _veh; };
EnemyAirToGroundSupports = call { _veh = ["O_Heli_Light_02_dynamicLoadout_F"]; if (count TREND_EastArmedHelos > 0) then { _veh = TREND_EastArmedHelos; }; _veh; };
EnemyAirScout			 = call { _veh = ["O_Heli_Light_02_dynamicLoadout_F"]; if (count TREND_EastArmedHelos > 0) then { _veh = TREND_EastArmedHelos; }; _veh; };
UnarmedScoutVehicles	 = call { _veh = ["O_Truck_02_covered_F"]; if (count TREND_EastUnarmedCars > 0) then { _veh = TREND_EastUnarmedCars; }; _veh; };
EnemyBaseChoppers		 = call { _veh = ["O_Heli_Light_02_unarmed_F"]; if (count TREND_EastUnarmedHelos > 0) then { _veh = TREND_EastUnarmedHelos; }; _veh; };




private _guerFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_MILITIA_FACTIONS_IDX;
(TREND_GuerFactionData select _guerFactionIndex) params ["_guerClassName", "_guerDisplayName"];


private _guerUnitData = [_guerClassName, _guerDisplayName] call TREND_fnc_getUnitDataByFaction;
private _guerVehData = [_guerClassName, _guerDisplayName] call TREND_fnc_getVehicleDataByFaction;

if ("rhsgref_faction_cdf_ground" isEqualTo _guerClassName) then {
	_guerUnitData append (["rhsgref_faction_cdf_air","CDF (Air Forces)"] call TREND_fnc_getUnitDataByFaction);
	_guerUnitData append (["rhsgref_faction_cdf_ng","CDF (National Guard)"] call TREND_fnc_getUnitDataByFaction);
	_guerVehData append (["rhsgref_faction_cdf_air","CDF (Air Forces)"] call TREND_fnc_getVehicleDataByFaction);
	_guerVehData append (["rhsgref_faction_cdf_ng","CDF (National Guard)"] call TREND_fnc_getVehicleDataByFaction);
};
if ("rhssaf_faction_army" isEqualTo _guerClassName) then {
	_guerUnitData append (["rhssaf_faction_airforce","SAF (RVIPVO)"] call TREND_fnc_getUnitDataByFaction);
	_guerVehData append (["rhssaf_faction_airforce","SAF (RVIPVO)"] call TREND_fnc_getVehicleDataByFaction);
};


_riflemen = []; _leaders = []; _atsoldiers = []; _aasoldiers = []; _engineers = []; _grenadiers = []; _medics = []; _autoriflemen = []; _snipers = []; _explosiveSpecs = []; _pilots = []; _uavOperators = [];
{
	_x params ["_className", "_dispName", "_icon", "_calloutName", ["_isMedic", 0], ["_isEngineer", 0], ["_isExpSpecialist", 0], ["_isUAVHacker", 0]];
	if (isNil "_className" ||isNil "_dispName" || isNil "_icon" || isNil "_calloutName") then {

	} else {
		if (["Ass.", _dispName] call BIS_fnc_inString || ["Asst", _dispName] call BIS_fnc_inString || ["Assi", _dispName] call BIS_fnc_inString || ["Story", _dispName] call BIS_fnc_inString || ["Support", _className] call BIS_fnc_inString || ["Crew", _className] call BIS_fnc_inString) then {
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
} forEach _guerUnitData;

private _guerUnitArray = [_riflemen, _leaders, _atsoldiers, _aasoldiers, _engineers, _grenadiers, _medics, _autoriflemen, _snipers, _explosiveSpecs, _pilots, _uavOperators];
_guerUnitArray params ["_guerriflemen", "_guerleaders", "_gueratsoldiers", "_gueraasoldiers", "_guerengineers", "_guergrenadiers", "_guermedics", "_guerautoriflemen", "_guersnipers", "_guerexplosiveSpecs", "_guerpilots", "_gueruavOperators"];

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
} forEach _guerVehData;

private _guerVehArray = [_unarmedcars, _armedcars, _trucks, _apcs, _tanks, _artillery, _antiair, _turrets, _unarmedhelicopters, _armedhelicopters, _planes, _boats, _mortars];
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

TREND_GuerUnarmedCars =  _guerunarmedcars + _guertrucks; publicVariable "TREND_GuerUnarmedCars"; // Combine transport vehicles and scout vehicles for now...
TREND_GuerArmedCars =  _guerarmedcars; publicVariable "TREND_GuerArmedCars";
TREND_GuerAPCs =  _guerapcs; publicVariable "TREND_GuerAPCs";
TREND_GuerTanks =  _guertanks; publicVariable "TREND_GuerTanks";
TREND_GuerArtillery =  _guerartillery; publicVariable "TREND_GuerArtillery";
TREND_GuerAntiAir =  _guerantiair; publicVariable "TREND_GuerAntiAir";
TREND_GuerTurrets =  _guerturrets; publicVariable "TREND_GuerTurrets";
TREND_GuerUnarmedHelos =  _guerunarmedhelicopters; publicVariable "TREND_GuerUnarmedHelos";
TREND_GuerArmedHelos =  _guerarmedhelicopters; publicVariable "TREND_GuerArmedHelos";
TREND_GuerPlanes =  _guerplanes; publicVariable "TREND_GuerPlanes";
TREND_GuerBoats =  _guerboats; publicVariable "TREND_GuerBoats";
TREND_GuerMortars = _guermortars; publicVariable "TREND_GuerMortars";

sRiflemanMilitia	  = call { _unit = "I_G_Soldier_F"; if (count TREND_GuerRiflemen > 0) then { _unit = selectRandom TREND_GuerRiflemen; }; _unit; };
sTeamleaderMilitia	  = call { _unit = "I_G_Soldier_SL_F"; if (count TREND_GuerLeaders > 0) then { _unit = selectRandom TREND_GuerLeaders; }; _unit; };
sATManMilitia		  = call { _unit = "I_G_Soldier_LAT_F"; if (count TREND_GuerATSoldiers > 0) then { _unit = selectRandom TREND_GuerATSoldiers; }; _unit; };
sAAManMilitia		  = call { _unit = "I_G_Soldier_LAT_F"; if (count TREND_GuerAASoldiers > 0) then { _unit = selectRandom TREND_GuerAASoldiers; }; _unit; };
sEngineerMilitia	  = call { _unit = "I_G_engineer_F"; if (count TREND_GuerEngineers > 0) then { _unit = selectRandom TREND_GuerEngineers; }; _unit; };
sGrenadierMilitia	  = call { _unit = "I_G_Soldier_GL_F"; if (count TREND_GuerGrenadiers > 0) then { _unit = selectRandom TREND_GuerGrenadiers; }; _unit; };
sMedicMilitia		  = call { _unit = "I_G_medic_F"; if (count TREND_GuerMedics > 0) then { _unit = selectRandom TREND_GuerMedics; }; _unit; };
sMachineGunManMilitia = call { _unit = "I_G_Soldier_AR_F"; if (count TREND_GuerAutoriflemen > 0) then { _unit = selectRandom TREND_GuerAutoriflemen; }; _unit; };
sTank1ArmedCarMilitia = call { _veh = "I_C_Offroad_02_LMG_F"; if (count TREND_GuerArmedCars > 0) then { _veh = selectRandom TREND_GuerArmedCars; }; _veh; };
sTank2APCMilitia 	  = call { _veh = "I_E_APC_tracked_03_cannon_F"; if (count TREND_GuerAPCs > 0) then { _veh = selectRandom TREND_GuerAPCs; }; _veh; };
sTank3TankMilitia	  = call { _veh = "I_LT_01_AT_F"; if (count TREND_GuerTanks > 0) then { _veh = selectRandom TREND_GuerTanks; }; _veh; };
sAAAVehMilitia 		  = call { _veh = "I_LT_01_AA_F"; if (count TREND_GuerAntiAir > 0) then { _veh = selectRandom TREND_GuerAntiAir; }; _veh; };
sMortarMilitia		  = call { _veh = ["I_Mortar_01_F"]; if (count TREND_GuerMortars > 0) then { _veh = TREND_GuerMortars; }; _veh; };

InformantClasses 		 = ["C_Orestes","C_Nikos"];
InterogateOfficerClasses = ["O_T_Officer_F"];
WeaponDealerClasses		 = ["C_Nikos_aged","C_man_hunter_1_F"];
sideResarchTruck		 = ["O_Truck_03_device_F"];
SideRadioClassNames		 = ["Land_PortableGenerator_01_F"];
sideAmmoTruck			 = call { _veh = ["O_Truck_03_ammo_F"]; if (count (TREND_EastUnarmedCars select {_x call TREND_fnc_isAmmo}) > 0) then { _veh = (TREND_EastUnarmedCars select {_x call TREND_fnc_isAmmo}); }; _veh; };
DestroyAAAVeh			 = call { _veh = ["O_T_APC_Tracked_02_AA_ghex_F"]; if (count TREND_EastAntiAir > 0) then { _veh = TREND_EastAntiAir; }; _veh; };

sRiflemanFriendInsurg	 = "B_G_Soldier_F";

WoundedSounds	 = ["WoundedGuyA_01","WoundedGuyA_02","WoundedGuyA_03","WoundedGuyA_04","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_07","WoundedGuyA_08","WoundedGuyB_01","WoundedGuyB_02","WoundedGuyB_03","WoundedGuyB_04","WoundedGuyB_05","WoundedGuyB_06","WoundedGuyB_07","WoundedGuyB_08","WoundedGuyC_01","WoundedGuyC_02","WoundedGuyC_03","WoundedGuyC_04","WoundedGuyC_05"];
CivCars			 = ["C_Hatchback_01_F","C_Offroad_01_F","C_SUV_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Truck_02_transport_F"];
sCivilian		 = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
HVTCars			 = ["C_SUV_01_F","C_Hatchback_01_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Hatchback_01_sport_F"];
HVTVans			 = ["C_Van_02_vehicle_F","C_Van_02_transport_F","C_Truck_02_covered_F","C_Van_01_box_F"];
HVTChoppers		 = ["C_Heli_Light_01_civil_F"];
HVTPlanes		 = ["C_Plane_Civil_01_F"];
BombToDefuse	 = ["Land_SatellitePhone_F"];
CheckPointTurret = call { _veh = ["O_G_HMG_02_high_F"]; if (count TREND_EastTurrets > 0) then { _veh = TREND_EastTurrets; }; _veh;};
TargetVehicles	 = ["O_SAM_System_04_F","O_Radar_System_02_F"];
TargetCaches	 = ["Box_FIA_Support_F"];

EnemyFlags = ["Flag_FD_Red_F"];

true;