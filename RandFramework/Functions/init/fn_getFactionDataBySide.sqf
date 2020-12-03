params[["_side", WEST]];
// _factionData = [WEST] call TREND_fnc_getFactionDataBySide;
// Return format: [[faction1_className, faction1_displayName], [faction2_className, faction2_displayName], ... , [factionN_className, factionN_displayName]]

private _sideNum = [_side] call BIS_fnc_sideID;
private _factionConfigPaths = [];

private _configPath = (configFile >> "CfgFactionClasses");

for "_i" from 0 to (count _configPath - 1) do {

	private _element = _configPath select _i;

	if (isClass _element) then {
		if ((getNumber(_element >> "side")) == _sideNum) then {
			_factionConfigPaths pushBackUnique _element;
		};
	};
};

private _factions = [];

{
	private _faction = (configName _x);
	private _hasMan = count ("((getNumber(_x >> 'scope') == 2) && {(getNumber(_x >> 'side') == _sideNum) && {(getText(_x >> 'faction') == _faction) && {(configName(_x) isKindOf 'Man')}}})" configClasses (configFile >> "CfgVehicles")) > 0;
	private _hasCar = count ("((getNumber(_x >> 'scope') == 2) && {(getNumber(_x >> 'side') == _sideNum) && {(getText(_x >> 'faction') == _faction) && {(configName(_x) isKindOf 'Car')}}})" configClasses (configFile >> "CfgVehicles")) > 0;
	if (_hasMan && _hasCar) then {
		_factions pushBack [(configName _x), getText(_x >> "displayName")];
	};
} forEach _factionConfigPaths;

_factions;

/* Example return for side WEST:
[
	["BLU_F","NATO"],
	["BLU_G_F","FIA"],
	["BLU_T_F","NATO (Pacific)"],
	["BLU_CTRG_F","CTRG"],
	["BLU_GEN_F","Gendarmerie"],
	["gm_fc_DK","Denmark"],
	["gm_fc_GE","West Germany"],
	["gm_fc_GE_bgs","West Germany (Borderguards)"],
	["rhs_faction_usarmy_wd","USA (Army - W)"],
	["rhs_faction_usarmy_d","USA (Army - D)"],
	["rhs_faction_usmc_wd","USA (USMC - W)"],
	["rhs_faction_usmc_d","USA (USMC - D)"],
	["rhs_faction_usaf","USA (USAF)"],
	["rhs_faction_socom","USA (SOCOM)"],
	["rhsgref_faction_cdf_ground_b","CDF (Ground Forces)"],
	["rhsgref_faction_hidf","Horizon Islands Defence Force"]
]
*/

/* Example return for side EAST:
[
	["OPF_F","CSAT"],
	["OPF_G_F","FIA"],
	["OPF_T_F","CSAT (Pacific)"],
	["TEC_CSAT","CSAT (Iran, Arid)"],
	["TEC_CSAT_Pacific","CSAT (Iran, Woodland)"],
	["TEC_CSAT_SOF","CSAT (Iran, Special Forces)"],
	["gm_fc_GC","East Germany"],
	["gm_fc_GC_bgs","East Germany (Borderguards)"],
	["gm_fc_PL","Poland"],
	["rhs_faction_msv","Russia (MSV)"],
	["rhs_faction_vdv","Russia (VDV)"],
	["rhs_faction_vmf","Russia (VMF)"],
	["rhs_faction_vv","Russia (VV)"],
	["rhs_faction_rva","Russia (RVA)"],
	["rhsgref_faction_chdkz","ChDKZ"],
	["rhsgref_faction_tla","Tanoan Liberation Army"],
	["rhssaf_faction_army_opfor","SAF (KOV)"]
]
*/

/* Example return for side Independent:
[
	["IND_F","AAF"],
	["IND_G_F","FIA"],
	["IND_C_F","Syndikat"],
	["IND_E_F","LDF"],
	["rhsgref_faction_cdf_ground","CDF (Ground Forces)"],
	["rhsgref_faction_un","CDF (UN)"],
	["rhsgref_faction_nationalist","NAPA"],
	["rhsgref_faction_chdkz_g","ChDKZ"],
	["rhsgref_faction_tla_g","Tanoan Liberation Army"],
	["rhssaf_faction_army","SAF (KOV)"],
	["rhssaf_faction_un","SAF (UN Peacekeepers)"]
]
*/
