/*
Output for Russia (MSV) in format: [[_riflemen], [_leaders], [_atsoldiers], [_aasoldiers], [_engineers], [_grenadiers], [_medics], [_autoriflemen], [_snipers], [_explosiveSpecs]];
["rhs_msv_rifleman","rhs_msv_emr_rifleman","rhs_msv_emr_sergeant","rhs_msv_emr_junior_sergeant"],
["rhs_msv_efreitor","rhs_msv_sergeant","rhs_msv_junior_sergeant","rhs_msv_officer_armored","rhs_msv_officer","rhs_msv_emr_efreitor","rhs_msv_emr_officer_armored","rhs_msv_emr_officer"],
["rhs_msv_LAT","rhs_msv_RShG2","rhs_msv_grenadier_rpg","rhs_msv_at","rhs_msv_emr_LAT","rhs_msv_emr_RShG2","rhs_msv_emr_grenadier_rpg","rhs_msv_emr_at"],
["rhs_msv_aa","rhs_msv_emr_aa"],
["rhs_msv_engineer","rhs_msv_driver_armored","rhs_msv_driver","rhs_msv_emr_engineer","rhs_msv_emr_driver_armored","rhs_msv_emr_driver"],
["rhs_msv_grenadier","rhs_msv_emr_grenadier"],
["rhs_msv_medic","rhs_msv_emr_medic"],
["rhs_msv_arifleman","rhs_msv_machinegunner","rhs_msv_emr_arifleman","rhs_msv_emr_machinegunner"],
["rhs_msv_marksman","rhs_msv_emr_marksman"],
["rhs_msv_engineer","rhs_msv_emr_engineer"]
*/

/*
Output for CSAT in format: [[_riflemen], [_leaders], [_atsoldiers], [_aasoldiers], [_engineers], [_grenadiers], [_medics], [_autoriflemen], [_snipers], [_explosiveSpecs]];
["O_Soldier_F","O_Soldier_lite_F","O_Soldier_A_F","O_soldier_PG_F","O_soldier_UAV_F","O_diver_F","O_spotter_F","O_recon_F","O_recon_JTAC_F","O_soldierU_F","O_soldierU_A_F","O_ghillie_lsh_F","O_ghillie_sard_F","O_ghillie_ard_F","O_T_Recon_JTAC_F","O_V_Soldier_hex_F","O_V_Soldier_M_hex_F","O_V_Soldier_JTAC_hex_F","O_soldier_UAV_06_F","O_soldier_UAV_06_medical_F","O_A_soldier_F"],
["O_officer_F","O_Soldier_SL_F","O_Soldier_TL_F","O_Story_Colonel_F","O_Story_CEO_F","O_diver_TL_F","O_recon_TL_F","O_soldierU_TL_F","O_SoldierU_SL_F","O_V_Soldier_TL_hex_F","O_A_soldier_TL_F"],
["O_Soldier_LAT_F","O_Soldier_AT_F","O_recon_LAT_F","O_soldierU_LAT_F","O_soldierU_AT_F","O_V_Soldier_LAT_hex_F","O_Soldier_HAT_F"],
["O_Soldier_AA_F","O_soldierU_AA_F"],
["O_soldier_repair_F","O_engineer_F","O_soldierU_repair_F","O_engineer_U_F"],
["O_Soldier_GL_F","O_SoldierU_GL_F"],
["O_medic_F","O_recon_medic_F","O_soldierU_medic_F","O_V_Soldier_Medic_hex_F"],
["O_Soldier_AR_F","O_soldierU_AR_F","O_HeavyGunner_F","O_Urban_HeavyGunner_F"],
["O_soldier_M_F","O_sniper_F","O_recon_M_F","O_soldierU_M_F","O_Sharpshooter_F","O_Urban_Sharpshooter_F","O_Pathfinder_F"],
["O_soldier_exp_F","O_engineer_F","O_diver_exp_F","O_recon_exp_F","O_soldierU_exp_F","O_engineer_U_F","O_V_Soldier_Exp_hex_F","O_V_Soldier_Medic_hex_F","O_soldier_mine_F"]
*/

// Note pilots were separated out after these outputs were generated.

params["_unitData"];

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
} forEach _unitData;

[_riflemen, _leaders, _atsoldiers, _aasoldiers, _engineers, _grenadiers, _medics, _autoriflemen, _snipers, _explosiveSpecs, _pilots, _uavOperators];