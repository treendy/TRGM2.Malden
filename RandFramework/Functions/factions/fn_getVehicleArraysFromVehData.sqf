params["_vehData"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

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
} forEach _vehData;

[_unarmedcars, _armedcars, _trucks, _apcs, _tanks, _artillery, _antiair, _turrets, _unarmedhelicopters, _armedhelicopters, _planes, _boats, _mortars];

/*
Example output for CSAT:
[
	["O_Truck_02_box_F","O_Truck_02_Ammo_F","O_Truck_02_fuel_F","O_Truck_03_repair_F","O_Truck_03_ammo_F","O_Truck_03_fuel_F","O_Truck_03_device_F","O_LSV_02_unarmed_F"],
	["O_MRAP_02_hmg_F","O_LSV_02_armed_F","O_LSV_02_AT_F"],
	["O_MRAP_02_F","O_Truck_02_covered_F","O_Truck_02_transport_F","O_Truck_02_medical_F","O_Truck_03_transport_F","O_Truck_03_covered_F","O_Truck_03_medical_F"],
	["O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_v2_F"],
	["O_MBT_02_cannon_F","O_MBT_04_cannon_F","O_MBT_04_command_F"],
	["O_MBT_02_arty_F"],
	["O_APC_Tracked_02_AA_F"],
	["O_HMG_01_F","O_HMG_01_high_F","O_HMG_01_A_F","O_Mortar_01_F","O_static_AA_F","O_static_AT_F"],
	["O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_box_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F"],
	["O_Heli_Light_02_dynamicLoadout_F","O_Heli_Attack_02_dynamicLoadout_F"],
	["O_Plane_CAS_02_dynamicLoadout_F","O_Plane_Fighter_02_F","O_Plane_Fighter_02_Stealth_F"],
	["O_Boat_Armed_01_hmg_F","O_Boat_Transport_01_F","O_Lifeboat"]
]
*/

/*
Example output for FIA:
[
	["O_G_Offroad_01_repair_F","O_G_Offroad_01_F","O_G_Offroad_01_AT_F","O_G_Van_01_transport_F","O_G_Van_01_fuel_F","O_G_Van_02_vehicle_F"],
	["O_G_Offroad_01_armed_F"],
	["O_G_Van_02_transport_F"],
	[],
	[],
	[],
	[],
	["O_G_HMG_02_F","O_G_HMG_02_high_F","O_G_Mortar_01_F"],
	[],
	[],
	[],
	["O_G_Boat_Transport_01_F"]
]
*/

/*
Example output for MSV:
[
	["rhs_gaz66_flat_msv","rhs_gaz66o_flat_msv","rhs_gaz66_r142_msv","rhs_gaz66_repair_msv","rhs_gaz66_ap2_msv","rhs_gaz66_ammo_msv","rhs_zil131_flatbed_msv","rhs_zil131_flatbed_cover_msv","RHS_UAZ_MSV_01","rhs_uaz_open_MSV_01","RHS_Ural_Flat_MSV_01","RHS_Ural_Open_Flat_MSV_01","RHS_Ural_Fuel_MSV_01","RHS_Ural_Repair_MSV_01","rhs_tigr_msv","rhs_tigr_3camo_msv","rhs_tigr_m_msv","rhs_tigr_m_3camo_msv","rhs_kamaz5350_flatbed_msv","rhs_kamaz5350_flatbed_cover_msv","rhs_kraz255b1_flatbed_msv","rhs_kraz255b1_fuel_msv","rhs_kraz255b1_pmp_msv","rhs_kraz255b1_bmkt_msv"],
	["rhs_gaz66_zu23_msv","RHS_Ural_Zu23_MSV_01","rhs_tigr_sts_msv","rhs_tigr_sts_3camo_msv","rhsgref_BRDM2_msv","rhsgref_BRDM2_ATGM_msv","rhsgref_BRDM2UM_msv","rhsgref_BRDM2_HQ_msv"],
	["rhs_gaz66_msv","rhs_gaz66o_msv","rhs_zil131_msv","rhs_zil131_open_msv","RHS_Ural_MSV_01","RHS_Ural_Open_MSV_01","rhs_kamaz5350_msv","rhs_kamaz5350_open_msv","rhs_kraz255b1_cargo_open_msv"],
	["rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_bmp1_msv","rhs_bmp1p_msv","rhs_bmp1k_msv","rhs_bmp1d_msv","rhs_prp3_msv","rhs_bmp2e_msv","rhs_bmp2_msv","rhs_bmp2k_msv","rhs_bmp2d_msv","rhs_Ob_681_2","rhs_brm1k_msv","rhs_btr70_msv","rhs_btr80_msv","rhs_btr80a_msv","rhs_btr60_msv"],
	[],
	["rhs_2b14_82mm_msv","rhs_D30_msv","rhs_D30_at_msv","RHS_BM21_MSV_01"],
	[],
	["RHS_ZU23_MSV","RHS_NSV_TriPod_MSV","rhs_KORD_MSV","rhs_KORD_high_MSV","RHS_AGS30_TriPod_MSV","rhs_SPG9M_MSV","rhs_Igla_AA_pod_msv","rhs_Metis_9k115_2_msv","rhs_Kornet_9M133_2_msv"],
	[],
	[],
	[],
	[]
]
*/

/*
Example output for VDV:
[
	["rhs_gaz66_flat_vdv","rhs_gaz66o_flat_vdv","rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_gaz66_ap2_vdv","rhs_gaz66_ammo_vdv","rhs_zil131_flatbed_vdv","rhs_zil131_flatbed_cover_vdv","rhs_uaz_vdv","rhs_uaz_open_vdv","RHS_Ural_Flat_VDV_01","RHS_Ural_Open_Flat_VDV_01","RHS_Ural_Fuel_VDV_01","RHS_Ural_Repair_VDV_01","rhs_typhoon_vdv","rhs_tigr_vdv","rhs_tigr_3camo_vdv","rhs_tigr_m_vdv","rhs_tigr_m_3camo_vdv","rhs_kamaz5350_flatbed_vdv","rhs_kamaz5350_flatbed_cover_vdv","rhs_kraz255b1_flatbed_vdv","rhs_kraz255b1_fuel_vdv","rhs_kraz255b1_pmp_vdv","rhs_kraz255b1_bmkt_vdv"],
	["rhs_gaz66_zu23_vdv","RHS_Ural_Zu23_VDV_01","rhs_tigr_sts_vdv","rhs_tigr_sts_3camo_vdv","rhsgref_BRDM2_vdv","rhsgref_BRDM2_ATGM_vdv","rhsgref_BRDM2UM_vdv","rhsgref_BRDM2_HQ_vdv"],
	["rhs_gaz66_vdv","rhs_gaz66o_vdv","rhs_zil131_vdv","rhs_zil131_open_vdv","RHS_Ural_VDV_01","RHS_Ural_Open_VDV_01","rhs_kamaz5350_vdv","rhs_kamaz5350_open_vdv","rhs_kraz255b1_cargo_open_vdv"],
	["rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2m","rhs_bmd2k","rhs_bmp1_vdv","rhs_bmp1p_vdv","rhs_bmp1k_vdv","rhs_bmp1d_vdv","rhs_prp3_vdv","rhs_bmp2e_vdv","rhs_bmp2_vdv","rhs_bmp2k_vdv","rhs_bmp2d_vdv","rhs_brm1k_vdv","rhs_btr70_vdv","rhs_btr80_vdv","rhs_btr80a_vdv","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv","rhs_btr60_vdv"],
	["rhs_sprut_vdv"],
	["rhs_2b14_82mm_vdv","rhs_D30_vdv","rhs_D30_at_vdv","RHS_BM21_VDV_01"],
	[],
	["RHS_ZU23_VDV","RHS_NSV_TriPod_VDV","rhs_KORD_VDV","rhs_KORD_high_VDV","RHS_AGS30_TriPod_VDV","rhs_SPG9M_VDV","rhs_Igla_AA_pod_vdv","rhs_Metis_9k115_2_vdv","rhs_Kornet_9M133_2_vdv"],
	[],
	["RHS_Mi24P_vdv","RHS_Mi24V_vdv","RHS_Mi8mt_vdv","RHS_Mi8mt_Cargo_vdv","RHS_Mi8MTV3_vdv","RHS_Mi8mtv3_Cargo_vdv","RHS_Mi8MTV3_heavy_vdv","RHS_Mi8T_vdv","RHS_Mi8AMT_vdv"],
	[],
	[]
]
*/