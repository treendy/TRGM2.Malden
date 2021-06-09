params [["_unit", objNull, [objNull]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (TREND_useCustomFriendlyFaction || TREND_useCustomEnemyFaction || TREND_useCustomMilitiaFaction) then {
	private _unitClassName = typeOf _unit;
	private _configPath = (configFile >> "CfgVehicles" >> _unitClassName);

	_riflemen = (configFile >> "CfgVehicles" >> "B_Soldier_F");
	_leaders = _riflemen;
	_atsoldiers = _riflemen;
	_aasoldiers = _riflemen;
	_engineers = _riflemen;
	_grenadiers = _riflemen;
	_medics = _riflemen;
	_autoriflemen = _riflemen;
	_snipers = _riflemen;
	_explosiveSpecs = _riflemen;
	_pilots = _riflemen;
	_uavOps = _riflemen;

	switch (side _unit) do {
		case WEST: {
			if !(TREND_useCustomFriendlyFaction) exitWith {};
			_riflemen = (missionConfigFile >> "BluRifleman");
			_leaders = (missionConfigFile >> "BluLeader");
			_atsoldiers = (missionConfigFile >> "BluAT");
			_aasoldiers = (missionConfigFile >> "BluAA");
			_engineers = (missionConfigFile >> "BluEngineer");
			_grenadiers = (missionConfigFile >> "BluGrenadier");
			_medics = (missionConfigFile >> "BluMedic");
			_autoriflemen = (missionConfigFile >> "BluAutorifleman");
			_snipers = (missionConfigFile >> "BluSniper");
			_explosiveSpecs = (missionConfigFile >> "BluExplosiveSpec");
			_pilots = (missionConfigFile >> "BluPilot");
			_uavOps = (missionConfigFile >> "BluUavOp");
		};
		case EAST: {
			if !(TREND_useCustomEnemyFaction) exitWith {};
			_riflemen = (missionConfigFile >> "OpfRifleman");
			_leaders = (missionConfigFile >> "OpfLeader");
			_atsoldiers = (missionConfigFile >> "OpfAT");
			_aasoldiers = (missionConfigFile >> "OpfAA");
			_engineers = (missionConfigFile >> "OpfEngineer");
			_grenadiers = (missionConfigFile >> "OpfGrenadier");
			_medics = (missionConfigFile >> "OpfMedic");
			_autoriflemen = (missionConfigFile >> "OpfAutorifleman");
			_snipers = (missionConfigFile >> "OpfSniper");
			_explosiveSpecs = (missionConfigFile >> "OpfExplosiveSpec");
			_pilots = (missionConfigFile >> "OpfPilot");
			_uavOps = (missionConfigFile >> "OpfUavOp");
		};
		case INDEPENDENT: {
			if !(TREND_useCustomMilitiaFaction) exitWith {};
			_riflemen = (missionConfigFile >> "IndRifleman");
			_leaders = (missionConfigFile >> "IndLeader");
			_atsoldiers = (missionConfigFile >> "IndAT");
			_aasoldiers = (missionConfigFile >> "IndAA");
			_engineers = (missionConfigFile >> "IndEngineer");
			_grenadiers = (missionConfigFile >> "IndGrenadier");
			_medics = (missionConfigFile >> "IndMedic");
			_autoriflemen = (missionConfigFile >> "IndAutorifleman");
			_snipers = (missionConfigFile >> "IndSniper");
			_explosiveSpecs = (missionConfigFile >> "IndExplosiveSpec");
			_pilots = (missionConfigFile >> "IndPilot");
			_uavOps = (missionConfigFile >> "IndUavOp");
		};
	};

	[_unitClassName, getText(_configPath >> "displayName"), getText(_configPath >> "icon"), getText(_configPath >> "textSingular"), getNumber(_configPath >> "attendant"), getNumber(_configPath >> "engineer"), getNumber(_configPath >> "canDeactivateMines"), getNumber(_configPath >> "uavHacker")] params ["_className", "_dispName", "_icon", "_calloutName", "_isMedic", "_isEngineer", "_isExpSpecialist", "_isUAVHacker"];

	if (isNil "_className" ||isNil "_dispName" || isNil "_icon" || isNil "_calloutName") then {

	} else {
		if (["Ass.", _dispName] call BIS_fnc_inString || ["Asst", _dispName] call BIS_fnc_inString || ["Assi", _dispName] call BIS_fnc_inString || ["Story", _dispName] call BIS_fnc_inString || ["Support", _className] call BIS_fnc_inString || ["Crew", _className] call BIS_fnc_inString) then {
			_unit setUnitLoadout _riflemen;
		} else {
			switch (_icon) do {
				case "iconManEngineer":	 { _unit setUnitLoadout _engineers; };
				case "iconManMedic": 	 { _unit setUnitLoadout _medics; };
				case "iconManExplosive": { _unit setUnitLoadout _explosiveSpecs; };
				case "iconManLeader":	 { _unit setUnitLoadout _leaders; };
				case "iconManOfficer":	 { _unit setUnitLoadout _leaders; };
				case "iconManMG":		 { _unit setUnitLoadout _autoriflemen; };
				case "iconManAT":		 { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _aasoldiers; } else { _unit setUnitLoadout _atsoldiers; }; };
				default {
					if (_isEngineer isEqualTo 1) then { _unit setUnitLoadout _engineers; };
					if (_isMedic isEqualTo 1) then { _unit setUnitLoadout _medics; };
					if (_isExpSpecialist isEqualTo 1) then { _unit setUnitLoadout _explosiveSpecs; };
					if (_isUAVHacker isEqualTo 1) then { _unit setUnitLoadout _uavOps; };
					if (["Auto", _dispName, true] call BIS_fnc_inString || ["Machine", _dispName, true] call BIS_fnc_inString) then { _unit setUnitLoadout _autoriflemen; };
					if (_calloutName isEqualTo "AT soldier") then { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _aasoldiers; } else { _unit setUnitLoadout _atsoldiers; }; };
					if ((_icon isEqualTo "iconMan")) then { if (_calloutName isEqualTo "sniper") then { _unit setUnitLoadout _snipers; } else { if (["Grenadier", _dispName] call BIS_fnc_inString || ["Grenadier", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _grenadiers; } else { if (["Pilot", _dispName] call BIS_fnc_inString || ["Pilot", _className] call BIS_fnc_inString) then { _unit setUnitLoadout _pilots; } else { _unit setUnitLoadout _riflemen; }; }; }; };
				};
			};
		};
	};
};

true;