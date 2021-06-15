params[["_factionClassName", "any"], ["_factionDispName", "any"]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
// _vehData = [faction_className, faction_displayName] call TRGM_GLOBAL_fnc_getVehicleDataByFaction;
// Param format: [faction_className, faction_displayName]
// Return format: [[unit1_className, unit1_dispName, unit1_category, unit1_isTransport, unit1_isArmed], ... , [unitN_className, unitN_dispName, unitN_category, unitN_isTransport, unitN_isArmed]]

if (_factionClassName isEqualTo "any" || _factionDispName isEqualTo "any") exitWith {};

private _vehConfigPaths = [];

private _configPath = (configFile >> "CfgVehicles");

for "_i" from 0 to (count _configPath - 1) do {

	private _element = _configPath select _i;

	if (isclass _element) then {
		if ((getText(_element >> "faction")) isEqualTo _factionClassName && {(getnumber(_element >> "scope")) isEqualTo 2 && {((configname _element) isKindOf "LandVehicle" || (configname _element) isKindOf "Air"|| (configname _element) isKindOf "Ship")}}) then {
			_vehConfigPaths pushbackunique _element;
		};
	};
};

private _vehs = [];
{
	if (getText(_x >> "vehicleClass") != "Training" && {!((getText(configfile >> "CfgEditorSubcategories" >> getText(_x >> "editorSubcategory") >> "displayName")) in ["Storage", "Submersibles", "Drones"])}) then {
		_vehs pushBack [(configname _x), getText(_x >> "displayName"), getText(_x >> "textSingular"), getText(configfile >> "CfgEditorSubcategories" >> getText(_x >> "editorSubcategory") >> "displayName"), (configname _x) call TRGM_GLOBAL_fnc_isTransport, (configname _x) call TRGM_GLOBAL_fnc_isArmed];
	};
} forEach _vehConfigPaths;

_vehs;


/* CSAT
[
	["O_HMG_01_F","Mk30 HMG .50","Turrets"],
	["O_Heli_Light_02_dynamicLoadout_F","PO-30 Orca","Helicopters"],
	["O_APC_Tracked_02_cannon_F","BTR-K Kamysh","APCs"],
	["O_APC_Tracked_02_AA_F","ZSU-39 Tigris","Anti-Air"],
	["O_MBT_02_cannon_F","T-100 Varsuk","Tanks"],
	["O_MBT_02_arty_F","2S9 Sochor","Artillery"],
	["O_Boat_Armed_01_hmg_F","Speedboat HMG","Boats"],
	["O_MRAP_02_F","Abda FMV","Cars"],
	["O_Plane_CAS_02_dynamicLoadout_F","To-199 Neophron (CAS)","Planes"],
]
*/

/* RHS MSV
[
	["RHS_ZU23_MSV","ZU-23-2","Turrets"],
	["rhs_2b14_82mm_msv","2B14-1 'Podnos'","Artillery"],
	["rhs_gaz66_msv","GAZ-66","Truck"],
	["RHS_UAZ_MSV_01","UAZ-3151","Car"],
	["rhs_bmp3_msv","BMP-3 (early)","IFV"],
	["rhs_btr70_msv","BTR-70","APC"],
	["rhsgref_BRDM2_msv","BRDM-2","MRAP"]
]
*/

/* FIA
[
	["O_G_HMG_02_F","M2 HMG .50","Turrets"],
	["O_G_Boat_Transport_01_F","Assault Boat","Boats"],
	["O_G_Offroad_01_repair_F","Offroad (Repair)","Cars"]
]
*/

/* RHS VDV
[
	["RHS_ZU23_VDV","ZU-23-2","Turrets"],
	["rhs_2b14_82mm_vdv","2B14-1 'Podnos'","Artillery"],
	["rhs_gaz66_vdv","GAZ-66","Truck"],
	["RHS_Mi24P_vdv","Mi-24P","Helicopter"],
	["rhs_uaz_vdv","UAZ-3151","Car"],
	["rhs_bmd1","BMD-1","IFV"],
	["rhs_btr70_vdv","BTR-70","APC"],
	["rhs_sprut_vdv","2S25","Tank"],
	["rhsgref_BRDM2_vdv","BRDM-2","MRAP"]
]
*/