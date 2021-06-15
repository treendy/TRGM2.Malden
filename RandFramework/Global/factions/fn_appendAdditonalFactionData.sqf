params[["_baseUnitData", []], ["_baseVehData", []], ["_className", ""], ["_dispName", ""]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

private _unitData = [] + _baseUnitData;
private _vehData = [] + _baseVehData;

if ("gm_fc_DK" isEqualTo _className || "gm_fc_GE" isEqualTo _className) then {
    _unitData append (["gm_fc_GE_bgs","West Germany (Borderguards)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["gm_fc_GE_bgs","West Germany (Borderguards)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if ("gm_fc_DK" isEqualTo _className || "gm_fc_GE_bgs" isEqualTo _className) then {
    _unitData append (["gm_fc_GE","West Germany"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["gm_fc_GE","West Germany"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if (["rhs_faction_usarmy", _className] call BIS_fnc_inString || ["rhs_faction_usmc", _className] call BIS_fnc_inString || "rhs_faction_socom" isEqualTo _className) then {
    _unitData append (["rhs_faction_usaf", "USA (USAF)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _unitData append (["rhs_faction_usn","USA (Navy)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["rhs_faction_usaf", "USA (USAF)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
    _vehData append (["rhs_faction_usn","USA (Navy)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if ("rhs_faction_socom" isEqualTo _className) then {
    _unitData append (["rhs_faction_usarmy_wd","USA (Army - W)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["rhs_faction_usarmy_wd","USA (Army - W)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if ("rhsgref_faction_cdf_ground_b" isEqualTo _className) then {
    _unitData append (["rhsgref_faction_cdf_air_b","CDF (Air Forces)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _unitData append (["rhsgref_faction_cdf_ng_b","CDF (National Guard)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["rhsgref_faction_cdf_air_b","CDF (Air Forces)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
    _vehData append (["rhsgref_faction_cdf_ng_b","CDF (National Guard)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if (["CSAT", _dispName] call BIS_fnc_inString) then {
    _unitData append (["OPF_V_F","Viper"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["OPF_V_F","Viper"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if (["TEC_CSAT", _className] call BIS_fnc_inString) then {
    _unitData append (["TEC_CSAT_Navy","CSAT (Iran, Navy)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["TEC_CSAT_Navy","CSAT (Iran, Navy)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
    if ("TEC_CSAT_SOF" isEqualTo _className) then {
        _unitData append (["TEC_CSAT","CSAT (Iran, Arid)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
        _vehData append (["TEC_CSAT_Navy","CSAT (Iran, Navy)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
    };
};
if ("gm_fc_PL" isEqualTo _className || "gm_fc_GC" isEqualTo _className) then {
    _unitData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if ("gm_fc_PL" isEqualTo _className || "gm_fc_GC_bgs" isEqualTo _className) then {
    _unitData append (["gm_fc_GC","East Germany"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if ("rhssaf_faction_army_opfor" isEqualTo _className) then {
    _unitData append (["rhssaf_faction_airforce_opfor","SAF (RVIPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["gm_fc_GC_bgs","East Germany (Borderguards)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if (["rhs_faction", _className] call BIS_fnc_inString) then {
    switch (_className) do {
        case "rhs_faction_msv": {
            _unitData append (["rhs_faction_rva","Russia (RVA)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);

            _vehData append (["rhs_faction_rva","Russia (RVA)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
        };
        case "rhs_faction_vdv": {
            _unitData append (["rhs_faction_rva","Russia (RVA)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);

            _vehData append (["rhs_faction_rva","Russia (RVA)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
        };
        case "rhs_faction_vmf": {
            _unitData append (["rhs_faction_msv","Russia (MSV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);

            _vehData append (["rhs_faction_msv","Russia (MSV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
        };
        case "rhs_faction_vv": {
            _unitData append (["rhs_faction_rva","Russia (RVA)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vvs","Russia (VVS - Grey)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);

            _vehData append (["rhs_faction_rva","Russia (RVA)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vvs","Russia (VVS - Grey)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
        };
        case "rhs_faction_rva": {
            _unitData append (["rhs_faction_msv","Russia (MSV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
            _unitData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);

            _vehData append (["rhs_faction_msv","Russia (MSV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vpvo","Russia (VPVO)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vmf","Russia (VMF)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_tv","Russia (TV)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["OPF_R_F","Spetsnaz"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
            _vehData append (["rhs_faction_vvs_c","Russia (VVS - Camo)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
        };
        default { };
    };
};
if ("rhsgref_faction_cdf_ground" isEqualTo _className) then {
    _unitData append (["rhsgref_faction_cdf_air","CDF (Air Forces)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _unitData append (["rhsgref_faction_cdf_ng","CDF (National Guard)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["rhsgref_faction_cdf_air","CDF (Air Forces)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
    _vehData append (["rhsgref_faction_cdf_ng","CDF (National Guard)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};
if ("rhssaf_faction_army" isEqualTo _className) then {
    _unitData append (["rhssaf_faction_airforce","SAF (RVIPVO)"] call TRGM_GLOBAL_fnc_getUnitDataByFaction);
    _vehData append (["rhssaf_faction_airforce","SAF (RVIPVO)"] call TRGM_GLOBAL_fnc_getVehicleDataByFaction);
};

[_unitData, _vehData];