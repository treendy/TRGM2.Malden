params [["_unit", objNull, [objNull]]];

private _unitClassName = typeOf _unit;
private _configPath = (configFile >> "CfgVehicles" >> _unitClassName);

_riflemen = ["B_Soldier_F"];
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
		if (count TREND_WestRiflemen > 0) then { _riflemen = TREND_WestRiflemen; } else { _riflemen = ["B_Soldier_F"]; };
		if (count TREND_WestLeaders > 0) then { _leaders = TREND_WestLeaders; } else { _leaders = _riflemen; };
		if (count TREND_WestATSoldiers > 0) then { _atsoldiers = TREND_WestATSoldiers; } else { _atsoldiers = _riflemen; };
		if (count TREND_WestAASoldiers > 0) then { _aasoldiers = TREND_WestAASoldiers; } else { _aasoldiers = _riflemen; };
		if (count TREND_WestEngineers > 0) then { _engineers = TREND_WestEngineers; } else { _engineers = _riflemen; };
		if (count TREND_WestGrenadiers > 0) then { _grenadiers = TREND_WestGrenadiers; } else { _grenadiers = _riflemen; };
		if (count TREND_WestMedics > 0) then { _medics = TREND_WestMedics; } else { _medics = _riflemen; };
		if (count TREND_WestAutoriflemen > 0) then { _autoriflemen = TREND_WestAutoriflemen; } else { _autoriflemen = _riflemen; };
		if (count TREND_WestSnipers > 0) then { _snipers = TREND_WestSnipers; } else { _snipers = _riflemen; };
		if (count TREND_WestExpSpecs > 0) then { _explosiveSpecs = TREND_WestExpSpecs; } else { _explosiveSpecs = _riflemen; };
		if (count TREND_WestPilots > 0) then { _pilots = TREND_WestPilots; } else { _pilots = _riflemen; };
		if (count TREND_WestUAVOps > 0) then { _uavOps = TREND_WestUAVOps; } else { _uavOps = _riflemen; };
	};
	case EAST: {
		if (count TREND_EastRiflemen > 0) then { _riflemen = TREND_EastRiflemen; } else { _riflemen = ["B_Soldier_F"]; };
		if (count TREND_EastLeaders > 0) then { _leaders = TREND_EastLeaders; } else { _leaders = _riflemen; };
		if (count TREND_EastATSoldiers > 0) then { _atsoldiers = TREND_EastATSoldiers; } else { _atsoldiers = _riflemen; };
		if (count TREND_EastAASoldiers > 0) then { _aasoldiers = TREND_EastAASoldiers; } else { _aasoldiers = _riflemen; };
		if (count TREND_EastEngineers > 0) then { _engineers = TREND_EastEngineers; } else { _engineers = _riflemen; };
		if (count TREND_EastGrenadiers > 0) then { _grenadiers = TREND_EastGrenadiers; } else { _grenadiers = _riflemen; };
		if (count TREND_EastMedics > 0) then { _medics = TREND_EastMedics; } else { _medics = _riflemen; };
		if (count TREND_EastAutoriflemen > 0) then { _autoriflemen = TREND_EastAutoriflemen; } else { _autoriflemen = _riflemen; };
		if (count TREND_EastSnipers > 0) then { _snipers = TREND_EastSnipers; } else { _snipers = _riflemen; };
		if (count TREND_EastExpSpecs > 0) then { _explosiveSpecs = TREND_EastExpSpecs; } else { _explosiveSpecs = _riflemen; };
		if (count TREND_EastPilots > 0) then { _pilots = TREND_EastPilots; } else { _pilots = _riflemen; };
	};
	case INDEPENDENT: {
		if (count TREND_GuerRiflemen > 0) then { _riflemen = TREND_GuerRiflemen; } else { _riflemen = ["B_Soldier_F"]; };
		if (count TREND_GuerLeaders > 0) then { _leaders = TREND_GuerLeaders; } else { _leaders = _riflemen; };
		if (count TREND_GuerATSoldiers > 0) then { _atsoldiers = TREND_GuerATSoldiers; } else { _atsoldiers = _riflemen; };
		if (count TREND_GuerAASoldiers > 0) then { _aasoldiers = TREND_GuerAASoldiers; } else { _aasoldiers = _riflemen; };
		if (count TREND_GuerEngineers > 0) then { _engineers = TREND_GuerEngineers; } else { _engineers = _riflemen; };
		if (count TREND_GuerGrenadiers > 0) then { _grenadiers = TREND_GuerGrenadiers; } else { _grenadiers = _riflemen; };
		if (count TREND_GuerMedics > 0) then { _medics = TREND_GuerMedics; } else { _medics = _riflemen; };
		if (count TREND_GuerAutoriflemen > 0) then { _autoriflemen = TREND_GuerAutoriflemen; } else { _autoriflemen = _riflemen; };
		if (count TREND_GuerSnipers > 0) then { _snipers = TREND_GuerSnipers; } else { _snipers = _riflemen; };
		if (count TREND_GuerExpSpecs > 0) then { _explosiveSpecs = TREND_GuerExpSpecs; } else { _explosiveSpecs = _riflemen; };
		if (count TREND_GuerPilots > 0) then { _pilots = TREND_GuerPilots; } else { _pilots = _riflemen; };
	};
};

[_unitClassName, getText(_configPath >> "displayName"), getText(_configPath >> "icon"), getText(_configPath >> "textSingular"), getNumber(_configPath >> "attendant"), getNumber(_configPath >> "engineer"), getNumber(_configPath >> "canDeactivateMines"), getNumber(_configPath >> "uavHacker")] params ["_className", "_dispName", "_icon", "_calloutName", "_isMedic", "_isEngineer", "_isExpSpecialist", "_isUAVHacker"];

if (["Asst", _dispName] call BIS_fnc_inString || ["Assi", _dispName] call BIS_fnc_inString || ["Story", _dispName] call BIS_fnc_inString || ["Support", _className] call BIS_fnc_inString || ["Crew", _className] call BIS_fnc_inString) then {
	_unit setUnitLoadout (getUnitLoadout (selectRandom _riflemen));
} else {
	if (_isEngineer == 1 || _icon == "iconManEngineer") then {
		_unit setUnitLoadout (getUnitLoadout (selectRandom _engineers));
	};

	if (_isMedic == 1 || _icon == "iconManMedic") then {
		_unit setUnitLoadout (getUnitLoadout (selectRandom _medics));
	};

	if (_isExpSpecialist == 1 || _icon == "iconManExplosive") then {
		_unit setUnitLoadout (getUnitLoadout (selectRandom _explosiveSpecs));
	};

	if (_isUAVHacker isEqualTo 1) then {
		_unit setUnitLoadout (getUnitLoadout (selectRandom _uavOps));
	};

	if (_icon == "iconManLeader" || _icon == "iconManOfficer") then {
		_unit setUnitLoadout (getUnitLoadout (selectRandom _leaders));
	};

	if (_icon == "iconManMG" || ["Auto", _dispName, true] call BIS_fnc_inString || ["Machine", _dispName, true] call BIS_fnc_inString) then {
		_unit setUnitLoadout (getUnitLoadout (selectRandom _autoriflemen));
	};

	if (_icon == "iconManAT" || _calloutName == "AT soldier") then {
		if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then {
			_unit setUnitLoadout (getUnitLoadout (selectRandom _aasoldiers));
		} else {
			_unit setUnitLoadout (getUnitLoadout (selectRandom _atsoldiers));
		};
	};

	if (_icon == "iconMan") then {
		if (_calloutName == "sniper") then {
			_unit setUnitLoadout (getUnitLoadout (selectRandom _snipers));
		} else {
			if (["Grenadier", _dispName] call BIS_fnc_inString || ["Grenadier", _className] call BIS_fnc_inString) then {
				_unit setUnitLoadout (getUnitLoadout (selectRandom _grenadiers));
			} else {
				if (["Pilot", _dispName] call BIS_fnc_inString || ["Pilot", _className] call BIS_fnc_inString) then {
					_unit setUnitLoadout (getUnitLoadout (selectRandom _pilots));
				} else {
					_unit setUnitLoadout (getUnitLoadout (selectRandom _riflemen));
				};
			};
		};
	};
};

true;