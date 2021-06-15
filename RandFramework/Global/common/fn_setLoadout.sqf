params [["_unit", objNull, [objNull]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

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
        if (count TRGM_VAR_WestRiflemen > 0) then { _riflemen = TRGM_VAR_WestRiflemen; } else { _riflemen = ["B_Soldier_F"]; };
        if (count TRGM_VAR_WestLeaders > 0) then { _leaders = TRGM_VAR_WestLeaders; } else { _leaders = _riflemen; };
        if (count TRGM_VAR_WestATSoldiers > 0) then { _atsoldiers = TRGM_VAR_WestATSoldiers; } else { _atsoldiers = _riflemen; };
        if (count TRGM_VAR_WestAASoldiers > 0) then { _aasoldiers = TRGM_VAR_WestAASoldiers; } else { _aasoldiers = _riflemen; };
        if (count TRGM_VAR_WestEngineers > 0) then { _engineers = TRGM_VAR_WestEngineers; } else { _engineers = _riflemen; };
        if (count TRGM_VAR_WestGrenadiers > 0) then { _grenadiers = TRGM_VAR_WestGrenadiers; } else { _grenadiers = _riflemen; };
        if (count TRGM_VAR_WestMedics > 0) then { _medics = TRGM_VAR_WestMedics; } else { _medics = _riflemen; };
        if (count TRGM_VAR_WestAutoriflemen > 0) then { _autoriflemen = TRGM_VAR_WestAutoriflemen; } else { _autoriflemen = _riflemen; };
        if (count TRGM_VAR_WestSnipers > 0) then { _snipers = TRGM_VAR_WestSnipers; } else { _snipers = _riflemen; };
        if (count TRGM_VAR_WestExpSpecs > 0) then { _explosiveSpecs = TRGM_VAR_WestExpSpecs; } else { _explosiveSpecs = _riflemen; };
        if (count TRGM_VAR_WestPilots > 0) then { _pilots = TRGM_VAR_WestPilots; } else { _pilots = _riflemen; };
        if (count TRGM_VAR_WestUAVOps > 0) then { _uavOps = TRGM_VAR_WestUAVOps; } else { _uavOps = _riflemen; };
    };
    case EAST: {
        if (count TRGM_VAR_EastRiflemen > 0) then { _riflemen = TRGM_VAR_EastRiflemen; } else { _riflemen = ["O_T_Soldier_F"]; };
        if (count TRGM_VAR_EastLeaders > 0) then { _leaders = TRGM_VAR_EastLeaders; } else { _leaders = _riflemen; };
        if (count TRGM_VAR_EastATSoldiers > 0) then { _atsoldiers = TRGM_VAR_EastATSoldiers; } else { _atsoldiers = _riflemen; };
        if (count TRGM_VAR_EastAASoldiers > 0) then { _aasoldiers = TRGM_VAR_EastAASoldiers; } else { _aasoldiers = _riflemen; };
        if (count TRGM_VAR_EastEngineers > 0) then { _engineers = TRGM_VAR_EastEngineers; } else { _engineers = _riflemen; };
        if (count TRGM_VAR_EastGrenadiers > 0) then { _grenadiers = TRGM_VAR_EastGrenadiers; } else { _grenadiers = _riflemen; };
        if (count TRGM_VAR_EastMedics > 0) then { _medics = TRGM_VAR_EastMedics; } else { _medics = _riflemen; };
        if (count TRGM_VAR_EastAutoriflemen > 0) then { _autoriflemen = TRGM_VAR_EastAutoriflemen; } else { _autoriflemen = _riflemen; };
        if (count TRGM_VAR_EastSnipers > 0) then { _snipers = TRGM_VAR_EastSnipers; } else { _snipers = _riflemen; };
        if (count TRGM_VAR_EastExpSpecs > 0) then { _explosiveSpecs = TRGM_VAR_EastExpSpecs; } else { _explosiveSpecs = _riflemen; };
        if (count TRGM_VAR_EastPilots > 0) then { _pilots = TRGM_VAR_EastPilots; } else { _pilots = _riflemen; };
    };
    case INDEPENDENT: {
        if (count TRGM_VAR_GuerRiflemen > 0) then { _riflemen = TRGM_VAR_GuerRiflemen; } else { _riflemen = ["I_G_Soldier_F"]; };
        if (count TRGM_VAR_GuerLeaders > 0) then { _leaders = TRGM_VAR_GuerLeaders; } else { _leaders = _riflemen; };
        if (count TRGM_VAR_GuerATSoldiers > 0) then { _atsoldiers = TRGM_VAR_GuerATSoldiers; } else { _atsoldiers = _riflemen; };
        if (count TRGM_VAR_GuerAASoldiers > 0) then { _aasoldiers = TRGM_VAR_GuerAASoldiers; } else { _aasoldiers = _riflemen; };
        if (count TRGM_VAR_GuerEngineers > 0) then { _engineers = TRGM_VAR_GuerEngineers; } else { _engineers = _riflemen; };
        if (count TRGM_VAR_GuerGrenadiers > 0) then { _grenadiers = TRGM_VAR_GuerGrenadiers; } else { _grenadiers = _riflemen; };
        if (count TRGM_VAR_GuerMedics > 0) then { _medics = TRGM_VAR_GuerMedics; } else { _medics = _riflemen; };
        if (count TRGM_VAR_GuerAutoriflemen > 0) then { _autoriflemen = TRGM_VAR_GuerAutoriflemen; } else { _autoriflemen = _riflemen; };
        if (count TRGM_VAR_GuerSnipers > 0) then { _snipers = TRGM_VAR_GuerSnipers; } else { _snipers = _riflemen; };
        if (count TRGM_VAR_GuerExpSpecs > 0) then { _explosiveSpecs = TRGM_VAR_GuerExpSpecs; } else { _explosiveSpecs = _riflemen; };
        if (count TRGM_VAR_GuerPilots > 0) then { _pilots = TRGM_VAR_GuerPilots; } else { _pilots = _riflemen; };
    };
};

[_unitClassName, getText(_configPath >> "displayName"), getText(_configPath >> "icon"), getText(_configPath >> "textSingular"), getNumber(_configPath >> "attendant"), getNumber(_configPath >> "engineer"), getNumber(_configPath >> "canDeactivateMines"), getNumber(_configPath >> "uavHacker")] params ["_className", "_dispName", "_icon", "_calloutName", "_isMedic", "_isEngineer", "_isExpSpecialist", "_isUAVHacker"];

if (isNil "_className" ||isNil "_dispName" || isNil "_icon" || isNil "_calloutName") then {

} else {
    if (["Ass.", _dispName] call BIS_fnc_inString || ["Asst", _dispName] call BIS_fnc_inString || ["Assi", _dispName] call BIS_fnc_inString || ["Story", _dispName] call BIS_fnc_inString || ["Support", _className] call BIS_fnc_inString || ["Crew", _className] call BIS_fnc_inString) then {
        _unit setUnitLoadout (getUnitLoadout (selectRandom _riflemen));
    } else {
        switch (_icon) do {
            case "iconManEngineer":     { _unit setUnitLoadout (getUnitLoadout (selectRandom _engineers)); };
            case "iconManMedic":      { _unit setUnitLoadout (getUnitLoadout (selectRandom _medics)); };
            case "iconManExplosive": { _unit setUnitLoadout (getUnitLoadout (selectRandom _explosiveSpecs)); };
            case "iconManLeader":     { _unit setUnitLoadout (getUnitLoadout (selectRandom _leaders)); };
            case "iconManOfficer":     { _unit setUnitLoadout (getUnitLoadout (selectRandom _leaders)); };
            case "iconManMG":         { _unit setUnitLoadout (getUnitLoadout (selectRandom _autoriflemen)); };
            case "iconManAT":         { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _aasoldiers)); } else { _unit setUnitLoadout (getUnitLoadout (selectRandom _atsoldiers)); }; };
            default {
                if (_isEngineer isEqualTo 1) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _engineers)); };
                if (_isMedic isEqualTo 1) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _medics)); };
                if (_isExpSpecialist isEqualTo 1) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _explosiveSpecs)); };
                if (_isUAVHacker isEqualTo 1) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _uavOps)); };
                if (["Auto", _dispName, true] call BIS_fnc_inString || ["Machine", _dispName, true] call BIS_fnc_inString) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _autoriflemen)); };
                if (_calloutName isEqualTo "AT soldier") then { if (["AA", _dispName, true] call BIS_fnc_inString || ["AA", _className] call BIS_fnc_inString) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _aasoldiers)); } else { _unit setUnitLoadout (getUnitLoadout (selectRandom _atsoldiers)); }; };
                if ((_icon isEqualTo "iconMan")) then { if (_calloutName isEqualTo "sniper") then { _unit setUnitLoadout (getUnitLoadout (selectRandom _snipers)); } else { if (["Grenadier", _dispName] call BIS_fnc_inString || ["Grenadier", _className] call BIS_fnc_inString) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _grenadiers)); } else { if (["Pilot", _dispName] call BIS_fnc_inString || ["Pilot", _className] call BIS_fnc_inString) then { _unit setUnitLoadout (getUnitLoadout (selectRandom _pilots)); } else { _unit setUnitLoadout (getUnitLoadout (selectRandom _riflemen)); }; }; }; };
            };
        };
    };
};

if (TRGM_VAR_useCustomFriendlyFaction || TRGM_VAR_useCustomEnemyFaction || TRGM_VAR_useCustomMilitiaFaction) exitWith {
    [_unit] call TRGM_GLOBAL_fnc_setCustomLoadout;
};

true;