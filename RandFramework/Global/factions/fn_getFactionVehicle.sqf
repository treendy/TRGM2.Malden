params [["_veh", objNull, [objNull]], ["_side", WEST]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

private _vehClassName = typeOf _veh;
private _configPath = (configFile >> "CfgVehicles" >> _vehClassName);

private _returnVeh = [_vehClassName];

_UnarmedCars = ["B_Truck_01_covered_F"];
_ArmedCars = ["B_MRAP_01_hmg_F"];
_APCs = ["B_T_LSV_01_unarmed_F"];
_Tanks = ["B_MBT_01_cannon_F"];
_Artillery = ["B_MBT_01_arty_F"];
_AntiAir = ["B_APC_Tracked_01_AA_F"];
_Turrets = ["B_G_HMG_02_high_F"];
_UnarmedHelos = ["B_Heli_Transport_03_unarmed_F"];
_ArmedHelos = ["B_Heli_Transport_01_camo_F"];
_Planes = ["B_Plane_Fighter_01_Stealth_F"];
_Boats = ["B_Boat_Transport_01_F"];
_Mortars = ["B_Mortar_01_F"];

switch (_side) do {
	case WEST: {
		if (count TRGM_VAR_WestUnarmedCars > 0) then { _UnarmedCars = TRGM_VAR_WestUnarmedCars; } else { _UnarmedCars = ["B_Truck_01_covered_F"]; };
		if (count TRGM_VAR_WestArmedCars > 0) then { _ArmedCars = TRGM_VAR_WestArmedCars; } else { _ArmedCars = ["B_MRAP_01_hmg_F"]; };
		if (count TRGM_VAR_WestAPCs > 0) then { _APCs = TRGM_VAR_WestAPCs; } else { _APCs = ["B_T_LSV_01_unarmed_F"]; };
		if (count TRGM_VAR_WestTanks > 0) then { _Tanks = TRGM_VAR_WestTanks; } else { _Tanks = ["B_MBT_01_cannon_F"]; };
		if (count TRGM_VAR_WestArtillery > 0) then { _Artillery = TRGM_VAR_WestArtillery; } else { _Artillery = ["B_MBT_01_arty_F"]; };
		if (count TRGM_VAR_WestAntiAir > 0) then { _AntiAir = TRGM_VAR_WestAntiAir; } else { _AntiAir = ["B_APC_Tracked_01_AA_F"]; };
		if (count TRGM_VAR_WestTurrets > 0) then { _Turrets = TRGM_VAR_WestTurrets; } else { _Turrets = ["B_G_HMG_02_high_F"]; };
		if (count TRGM_VAR_WestUnarmedHelos > 0) then { _UnarmedHelos = TRGM_VAR_WestUnarmedHelos; } else { _UnarmedHelos = ["B_Heli_Transport_03_unarmed_F"]; };
		if (count TRGM_VAR_WestArmedHelos > 0) then { _ArmedHelos = TRGM_VAR_WestArmedHelos; } else { _ArmedHelos = ["B_Heli_Transport_01_camo_F"]; };
		if (count TRGM_VAR_WestPlanes > 0) then { _Planes = TRGM_VAR_WestPlanes; } else { _Planes = ["B_Plane_Fighter_01_Stealth_F"]; };
		if (count TRGM_VAR_WestBoats > 0) then { _Boats = TRGM_VAR_WestBoats; } else { _Boats = ["B_Boat_Transport_01_F"]; };
		if (count TRGM_VAR_WestMortars > 0) then { _Mortars = TRGM_VAR_WestMortars; } else { _Mortars = ["B_Mortar_01_F"]; };
	};
	case EAST: {
		if (count TRGM_VAR_EastUnarmedCars > 0) then { _UnarmedCars = TRGM_VAR_EastUnarmedCars; } else { _UnarmedCars = ["O_Truck_02_covered_F"]; };
		if (count TRGM_VAR_EastArmedCars > 0) then { _ArmedCars = TRGM_VAR_EastArmedCars; } else { _ArmedCars = ["O_T_LSV_02_armed_F"]; };
		if (count TRGM_VAR_EastAPCs > 0) then { _APCs = TRGM_VAR_EastAPCs; } else { _APCs = ["O_APC_Wheeled_02_rcws_v2_F"]; };
		if (count TRGM_VAR_EastTanks > 0) then { _Tanks = TRGM_VAR_EastTanks; } else { _Tanks = ["O_MBT_02_cannon_F"]; };
		if (count TRGM_VAR_EastArtillery > 0) then { _Artillery = TRGM_VAR_EastArtillery; } else { _Artillery = ["O_MBT_02_arty_F"]; };
		if (count TRGM_VAR_EastAntiAir > 0) then { _AntiAir = TRGM_VAR_EastAntiAir; } else { _AntiAir = ["O_APC_Tracked_02_AA_F"]; };
		if (count TRGM_VAR_EastTurrets > 0) then { _Turrets = TRGM_VAR_EastTurrets; } else { _Turrets = ["O_G_HMG_02_high_F"]; };
		if (count TRGM_VAR_EastUnarmedHelos > 0) then { _UnarmedHelos = TRGM_VAR_EastUnarmedHelos; } else { _UnarmedHelos = ["O_Heli_Light_02_unarmed_F"]; };
		if (count TRGM_VAR_EastArmedHelos > 0) then { _ArmedHelos = TRGM_VAR_EastArmedHelos; } else { _ArmedHelos = ["O_Heli_Light_02_dynamicLoadout_F"]; };
		if (count TRGM_VAR_EastPlanes > 0) then { _Planes = TRGM_VAR_EastPlanes; } else { _Planes = ["O_Plane_Fighter_02_F"]; };
		if (count TRGM_VAR_EastBoats > 0) then { _Boats = TRGM_VAR_EastBoats; } else { _Boats = ["O_Boat_Armed_01_hmg_F"]; };
		if (count TRGM_VAR_EastMortars > 0) then { _Mortars = TRGM_VAR_EastMortars; } else { _Mortars = ["O_Mortar_01_F"]; };
	};
	case INDEPENDENT: {
		if (count TRGM_VAR_GuerUnarmedCars > 0) then { _UnarmedCars = TRGM_VAR_GuerUnarmedCars; } else { _UnarmedCars = ["I_C_Offroad_02_unarmed_F"]; };
		if (count TRGM_VAR_GuerArmedCars > 0) then { _ArmedCars = TRGM_VAR_GuerArmedCars; } else { _ArmedCars = ["I_C_Offroad_02_LMG_F"]; };
		if (count TRGM_VAR_GuerAPCs > 0) then { _APCs = TRGM_VAR_GuerAPCs; } else { _APCs = ["I_E_APC_tracked_03_cannon_F"]; };
		if (count TRGM_VAR_GuerTanks > 0) then { _Tanks = TRGM_VAR_GuerTanks; } else { _Tanks = ["I_LT_01_AT_F"]; };
		if (count TRGM_VAR_GuerArtillery > 0) then { _Artillery = TRGM_VAR_GuerArtillery; } else { _Artillery = ["I_Truck_02_MRL_F"]; };
		if (count TRGM_VAR_GuerAntiAir > 0) then { _AntiAir = TRGM_VAR_GuerAntiAir; } else { _AntiAir = ["I_LT_01_AA_F"]; };
		if (count TRGM_VAR_GuerTurrets > 0) then { _Turrets = TRGM_VAR_GuerTurrets; } else { _Turrets = ["I_E_HMG_02_high_F"]; };
		if (count TRGM_VAR_GuerUnarmedHelos > 0) then { _UnarmedHelos = TRGM_VAR_GuerUnarmedHelos; } else { _UnarmedHelos = ["I_E_Heli_light_03_unarmed_F"]; };
		if (count TRGM_VAR_GuerArmedHelos > 0) then { _ArmedHelos = TRGM_VAR_GuerArmedHelos; } else { _ArmedHelos = ["I_E_Heli_light_03_dynamicLoadout_F"]; };
		if (count TRGM_VAR_GuerPlanes > 0) then { _Planes = TRGM_VAR_GuerPlanes; } else { _Planes = ["I_Plane_Fighter_04_F"]; };
		if (count TRGM_VAR_GuerBoats > 0) then { _Boats = TRGM_VAR_GuerBoats; } else { _Boats = ["I_Boat_Transport_01_F"]; };
		if (count TRGM_VAR_GuerMortars > 0) then { _Mortars = TRGM_VAR_GuerMortars; } else { _Mortars = ["I_Mortar_01_F"]; };
	};
};

[_vehClassName, getText(_configPath >> "displayName"), getText(_configPath >> "textSingular"), getText(configfile >> "CfgEditorSubcategories" >> getText(_configPath >> "editorSubcategory") >> "displayName"), (configName _configPath) call TRGM_GLOBAL_fnc_isTransport, (configName _configPath) call TRGM_GLOBAL_fnc_isArmed] params [["_className", ""], ["_dispName", ""], ["_calloutName", ""], ["_category", ""], ["_isTransport", false], ["_isArmed", false]];

if (isNil "_className" || isNil "_dispName" || isNil "_calloutName" || isNil "_category") then {

} else {
	if (["GMG", _dispName] call BIS_fnc_inString || ["Quadbike", _className] call BIS_fnc_inString || ["Designator", _className] call BIS_fnc_inString || ["Radar", _className] call BIS_fnc_inString || ["SAM", _className] call BIS_fnc_inString) then {
		_returnVeh = _UnarmedCars;
	} else {
		if (_calloutName isEqualTo "mortar") then {
			_returnVeh = _Mortars;
		} else {
			switch (_category) do {
				case "Turrets": 	{ _returnVeh = _Turrets; };
				case "Boats": 		{ _returnVeh = _Boats; };
				case "Boat": 		{ _returnVeh = _Boats; };
				case "Artillery": 	{ _returnVeh = _Artillery; };
				case "Anti-Air": 	{ _returnVeh = _AntiAir; };
				case "Planes": 		{ _returnVeh = _Planes; };
				case "Plane": 		{ _returnVeh = _Planes; };
				case "APCs": 		{ _returnVeh = _APCs; };
				case "APC": 		{ _returnVeh = _APCs; };
				case "IFV": 		{ _returnVeh = _APCs; };
				case "Tanks": 		{ _returnVeh = _Tanks; };
				case "Tank": 		{ _returnVeh = _Tanks; };
				case "Helicopters": { if (_isArmed && !_isTransport) then { _returnVeh = _ArmedHelos; } else { _returnVeh = _UnarmedHelos; }; };
				case "Helicopter": 	{ if (_isArmed && !_isTransport) then { _returnVeh = _ArmedHelos; } else { _returnVeh = _UnarmedHelos; }; };
				case "Cars": 		{ if (_isArmed && !_isTransport) then { _returnVeh = _ArmedCars; } else { _returnVeh = _UnarmedCars; }; };
				case "Car": 		{ if (_isArmed && !_isTransport) then { _returnVeh = _ArmedCars; } else { _returnVeh = _UnarmedCars; }; };
				case "MRAP": 		{ if (_isArmed && !_isTransport) then { _returnVeh = _ArmedCars; } else { _returnVeh = _UnarmedCars; }; };
				case "Truck": 		{ if (_isArmed && !_isTransport) then { _returnVeh = _ArmedCars; } else { _returnVeh = _UnarmedCars; }; };
				default { };
			};
		};
	};
};

if (_vehClassName call TRGM_GLOBAL_fnc_isMedical) then {
	_returnVeh = _returnVeh select {_x call TRGM_GLOBAL_fnc_isMedical};
	if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
} else {
	if (_vehClassName call TRGM_GLOBAL_fnc_isFuel) then {
		_returnVeh = _returnVeh select {_x call TRGM_GLOBAL_fnc_isFuel};
		if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
	} else {
		if (_vehClassName call TRGM_GLOBAL_fnc_isRepair) then {
			_returnVeh = _returnVeh select {_x call TRGM_GLOBAL_fnc_isRepair};
			if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
		} else {
			if (_vehClassName call TRGM_GLOBAL_fnc_isAmmo) then {
				_returnVeh = _returnVeh select {_x call TRGM_GLOBAL_fnc_isAmmo};
				if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
			} else {
				if (_isArmed) then {
					_returnVeh = _returnVeh select {_x call TRGM_GLOBAL_fnc_isArmed};
					if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
				} else {
					if (_isTransport) then {
						_returnVeh = _returnVeh select {_x call TRGM_GLOBAL_fnc_isTransport};
						if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
					};
				};
			};
		};
	};
};

_returnVeh = selectRandom _returnVeh;

// Final fail safe:
if (isNil "_returnVeh" || { _returnVeh isEqualTo []}) exitWith {_vehClassName};
_returnVeh;