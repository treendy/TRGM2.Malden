/*
* Author: TheAce0296
* Creates the request units/vehicles dialog.
*
* Arguments:
* 0: The unit opened the dialog (should be player) <OBJECT>
*
* Return Value:
* true <BOOL>
*
* Example:
* player call TRGM_GUI_fnc_openDialogRequests
*/

disableSerialization;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
params [["_player", objNull, [objNull]]];

if (player != _player) exitwith {};

private _dCurrentRep = [TRGM_VAR_maxBadPoints - TRGM_VAR_BadPoints, 1] call BIS_fnc_cutDecimals;
private _unitMap = [
    [localize "STR_TRGM2_openDialogRequests_Riflemen", TRGM_VAR_WestRiflemen, TRGM_VAR_WestRiflemen apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_ATSoldiers", TRGM_VAR_WestATSoldiers, TRGM_VAR_WestATSoldiers apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_AASoldiers", TRGM_VAR_WestAASoldiers, TRGM_VAR_WestAASoldiers apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_Engineers", TRGM_VAR_WestEngineers, TRGM_VAR_WestEngineers apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_Medics", TRGM_VAR_WestMedics, TRGM_VAR_WestMedics apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_ExplosiveSpecialists", TRGM_VAR_WestExpSpecs, TRGM_VAR_WestExpSpecs apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]
];

if (_dCurrentRep >= 3) then {
    _unitMap append [[localize "STR_TRGM2_openDialogRequests_Autoriflemen", TRGM_VAR_WestAutoriflemen, TRGM_VAR_WestAutoriflemen apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
    _unitMap append [[localize "STR_TRGM2_openDialogRequests_Grenadiers", TRGM_VAR_WestGrenadiers, TRGM_VAR_WestGrenadiers apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]]
};
if (_dCurrentRep >= 5) then {
    _unitMap append [[localize "STR_TRGM2_openDialogRequests_Snipers", TRGM_VAR_WestSnipers, TRGM_VAR_WestSnipers apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
};
if (_dCurrentRep >= 7) then {
    _unitMap append [[localize "STR_TRGM2_openDialogRequests_UAVOperators", TRGM_VAR_WestUAVOps, TRGM_VAR_WestUAVOps apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
};

TRGM_VAR_RecruitUnitMap = _unitMap;
publicVariable "TRGM_VAR_RecruitUnitMap";

private _vehMap = [
    [localize "STR_TRGM2_openDialogRequests_Unarmedcarstrucks", TRGM_VAR_WestUnarmedCars, TRGM_VAR_WestUnarmedCars apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_Unarmedhelicopters", TRGM_VAR_WestUnarmedHelos, TRGM_VAR_WestUnarmedHelos apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_Turrets", TRGM_VAR_WestTurrets, TRGM_VAR_WestTurrets apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }],
    [localize "STR_TRGM2_openDialogRequests_Boats", TRGM_VAR_WestBoats, TRGM_VAR_WestBoats apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]
];

if (_dCurrentRep >= 3 || {!(call TRGM_GETTER_fnc_bVehiclesRequireRep)}) then {
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_Armedcarstrucks", TRGM_VAR_WestArmedCars, TRGM_VAR_WestArmedCars apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_APCs", TRGM_VAR_WestAPCs, TRGM_VAR_WestAPCs apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]]
};
if (_dCurrentRep >= 5 || {!(call TRGM_GETTER_fnc_bVehiclesRequireRep)}) then {
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_Tanks", TRGM_VAR_WestTanks, TRGM_VAR_WestTanks apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_Armedhelicopters", TRGM_VAR_WestArmedHelos, TRGM_VAR_WestArmedHelos apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
};
if (_dCurrentRep >= 7 || {!(call TRGM_GETTER_fnc_bVehiclesRequireRep)}) then {
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_Artillery", TRGM_VAR_WestArtillery, TRGM_VAR_WestArtillery apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_Antiair", TRGM_VAR_WestAntiAir, TRGM_VAR_WestAntiAir apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
    _vehMap append [[localize "STR_TRGM2_openDialogRequests_Planes", TRGM_VAR_WestPlanes, TRGM_VAR_WestPlanes apply { getText(configFile >> "Cfgvehicles" >> _x >> "displayname"); }]];
};

TRGM_VAR_RecruitVehicleMap = _vehMap;
publicVariable "TRGM_VAR_RecruitVehicleMap";


createdialog "TRGM_VAR_dialogRequests";
waitUntil {
    !isNull (findDisplay 8000);
};

_display = findDisplay 8000;

_display ctrlCreate ["RscCombo", 8011];
_cboselectUnitClass = _display displayCtrl 8011;
_cboselectUnitClass ctrlsetPosition [0.365954 * safeZoneW + safeZoneX, 0.412003 * safeZoneH + safeZoneY, 0.123734 * safeZoneW, 0.0329991 * safeZoneH];
{
    private _unitClassName = _x select 0;
    _cboselectUnitClass lbAdd _unitClassName;
} forEach TRGM_VAR_RecruitUnitMap;
_cboselectUnitClass lbsetCurSel 0;
_cboselectUnitClass ctrlCommit 0;
_cboselectUnitClass ctrlsettooltip localize "STR_TRGM2_openDialogRequests_RequestUnitClassDefault";
_cboselectUnitClass ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_selectedIndex"];
    lbClear 8007;
    {
        lbAdd [8007, _x];
    } forEach ((TRGM_VAR_RecruitUnitMap select _selectedIndex) select 2);
    lbsetCurSel [8007, 0];
}];

_display ctrlCreate ["RscCombo", 8007];
_cboselectUnit = _display displayCtrl 8007;
_cboselectUnit ctrlsetPosition [0.365954 * safeZoneW + safeZoneX, 0.412003 * safeZoneH + safeZoneY + (1.5 * (0.0329991 * safeZoneH)), 0.123734 * safeZoneW, 0.0329991 * safeZoneH];
{
    _cboselectUnit lbAdd _x;
} forEach ((TRGM_VAR_RecruitUnitMap select 0) select 2);
_cboselectUnit lbsetCurSel 0;
_cboselectUnit ctrlCommit 0;
_cboselectUnit ctrlsettooltip localize "str_TRGM2_opendialogRequests_RequestUnitdefault";


_btnselectUnit = _display displayCtrl 8003;
_btnselectUnit ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _classIndex = lbCurSel 8011;
    private _unitIndex = lbCurSel 8007;
    private _unitClassName = ((TRGM_VAR_RecruitUnitMap select _classIndex) select 1) select _unitIndex;

    if (player != leader group player) then {
        titleText[localize "str_TRGM2_opendialogRequests_notgroupleader", "PLAin"];
    } else {
        _currentSpentPoints = call TRGM_GLOBAL_fnc_countSpentPoints;
        if (_currentSpentPoints < (TRGM_VAR_maxBadPoints - TRGM_VAR_BadPoints + 1)) then {
            private _spawnedUnit = (group player createUnit [_unitClassName, getPos player, [], 10, "NONE"]);
            addswitchableUnit _spawnedUnit;
            player doFollow player;
            _spawnedUnit setVariable ["Repcost", 0.5, true];
            _spawnedUnit setVariable ["IsFRT", true, true];

            [box1, [_spawnedUnit]] call TRGM_GLOBAL_fnc_initAmmoBox;

            _spawnedUnit addEventHandler ["killed", {
                _tombStone = selectRandom TRGM_VAR_tombStones createvehicle TRGM_VAR_GraveYardPos;
                _tombStone setDir TRGM_VAR_GraveYarddirection;
                _tombStone setVariable ["Message", format[localize "str_TRGM2_Recruiteinf_KIA", name (_this select 0)], true];
                _tombStone addAction [localize "str_TRGM2_Recruiteinf_Read", {
                    [format["%1", (_this select 0) getVariable "Message"]] call TRGM_GLOBAL_fnc_notify;
                }];
                [0.2, format[localize "str_TRGM2_Recruiteinf_KIA", name (_this select 0)]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
            }];

            if (TRGM_VAR_bUseRevive || !isNil "AIS_mod_ENABLED") then {
                [_spawnedUnit] call AIS_System_fnc_loadAIS;
            };
            titleText[localize "str_TRGM2_opendialogRequests_unitspawned", "PLAin"];
        } else {
            titleText [localize "str_TRGM2_Recruiteinf_MoreReputation", "PLAin"];
        };
    };
    closedialog 0;
    false;
}];

_display ctrlCreate ["RscCombo", 8013];
_cboselectVehicleClass = _display displayCtrl 8013;
_cboselectVehicleClass ctrlsetPosition [0.520622 * safeZoneW + safeZoneX, 0.412003 * safeZoneH + safeZoneY, 0.123734 * safeZoneW, 0.0329991 * safeZoneH];
{
    private _vehicleClassName = _x select 0;
    _cboselectVehicleClass lbAdd _vehicleClassName;
} forEach TRGM_VAR_RecruitVehicleMap;
_cboselectVehicleClass lbsetCurSel 0;
_cboselectVehicleClass ctrlCommit 0;
_cboselectVehicleClass ctrlsettooltip localize "STR_TRGM2_openDialogRequests_RequestVehicleClassDefault";
_cboselectVehicleClass ctrlAddEventHandler ["LBSelChanged", {
    params ["_control", "_selectedIndex"];
    lbClear 8009;
    {
        lbAdd [8009, _x];
    } forEach ((TRGM_VAR_RecruitVehicleMap select _selectedIndex) select 2);
    lbsetCurSel [8009, 0];
}];

_display ctrlCreate ["RscCombo", 8009];
_cboselectvehicle = _display displayCtrl 8009;
_cboselectvehicle ctrlsetPosition [0.520622 * safeZoneW + safeZoneX, 0.412003 * safeZoneH + safeZoneY + (1.5 * (0.0329991 * safeZoneH)), 0.123734 * safeZoneW, 0.0329991 * safeZoneH];
{
    _cboselectvehicle lbAdd _x;
} forEach ((TRGM_VAR_RecruitVehicleMap select 0) select 2);
_cboselectvehicle lbsetCurSel 0;
_cboselectvehicle ctrlCommit 0;
_cboselectvehicle ctrlsettooltip localize "str_TRGM2_opendialogRequests_Requestvehicledefault";

_btnselectvehicle = _display displayCtrl 8005;
_btnselectvehicle ctrlAddEventHandler ["ButtonClick", {
    params ["_control"];
    private _classIndex = lbCurSel 8013;
    private _vehIndex = lbCurSel 8009;
    private _vehClassName = ((TRGM_VAR_RecruitVehicleMap select _classIndex) select 1) select _vehIndex;
    _currentSpentPoints = call TRGM_GLOBAL_fnc_countSpentPoints;
    if (!(call TRGM_GETTER_fnc_bVehiclesRequireRep) || {
        _currentSpentPoints < (TRGM_VAR_maxBadPoints - TRGM_VAR_BadPoints + 1)
    }) then {
        [_vehClassName] spawn {
            params ["_classtospawn"];
            private _safePos = [getPos player, 20, 100, 25, 0, 0.15, 0, [], [getPos player, getPos player], _classtospawn] call TRGM_GLOBAL_fnc_findSafePos;
            // find a valid pos
            if (_safePos isEqualto getPos player) then {
                _safePos = [getPos player, 20, 150, 25, 0, 0.30, 0, [], [getPos player, getPos player], _classtospawn] call TRGM_GLOBAL_fnc_findSafePos;
                // find a valid pos
            };
            if (_safePos isEqualto getPos player) exitwith {
                ["No safe location nearby to create vehicle!"] call TRGM_GLOBAL_fnc_notify;
            };
            player setPos _safePos;
            private _spawnedVeh = createvehicle [_classtospawn, _safePos vectorAdd [0, 0, 250], [], 0, "NONE"];
            _spawnedVeh allowdamage false;
            _spawnedVeh setDamage 0;

            private _largeObjectCorrection = if (((boundingBoxReal _spawnedVeh select 1 select 1) - (boundingBoxReal _spawnedVeh select 0 select 1)) != 0 && {
                ((boundingBoxReal _spawnedVeh select 1 select 0) - (boundingBoxReal _spawnedVeh select 0 select 0)) > 3.2 &&
                ((boundingBoxReal _spawnedVeh select 1 select 0) - (boundingBoxReal _spawnedVeh select 0 select 0)) / ((boundingBoxReal _spawnedVeh select 1 select 1) - (boundingBoxReal _spawnedVeh select 0 select 1)) > 1.25
            })
            then {
                90;
            } else {
                0;
            };

            private _attachPos = [
                (boundingCenter _spawnedVeh select 0) * cos _largeObjectCorrection - (boundingCenter _spawnedVeh select 1) * sin _largeObjectCorrection,
                ((-(boundingBoxReal _spawnedVeh select 0 select 0) * sin _largeObjectCorrection) max (-(boundingBoxReal _spawnedVeh select 1 select 0) * sin _largeObjectCorrection)) + ((-(boundingBoxReal _spawnedVeh select 0 select 1) * cos _largeObjectCorrection) max (-(boundingBoxReal _spawnedVeh select 1 select 1) * cos _largeObjectCorrection)) + 2 + 0.3 * (((boundingBoxReal _spawnedVeh select 1 select 1)-(boundingBoxReal _spawnedVeh select 0 select 1)) * abs sin _largeObjectCorrection + ((boundingBoxReal _spawnedVeh select 1 select 0)-(boundingBoxReal _spawnedVeh select 0 select 0)) * abs cos _largeObjectCorrection),
                -(boundingBoxReal _spawnedVeh select 0 select 2)
            ];

            if (!local _spawnedVeh) then {
                private _makelocalStarttime = time;
                _spawnedVeh setowner (owner player);
                waitUntil {
                    local _spawnedVeh || time > _makelocalStarttime + 1.5
                };
            };

            sleep 0.5;

            _spawnedVeh setPos _safePos;
            _spawnedVeh attachto [player, _attachPos, "head"];

            _actionReleaseObject = player addAction [format [localize "str_TRGM2_opendialogRequests_vehicleRelease", gettext (configFile >> "Cfgvehicles" >> _classtospawn >> "displayname")], {
                params ["_target", "_caller", "_actionId", "_arguments"];
                _arguments params ["_spawnedVeh"];
                detach _spawnedVeh;
                _spawnedVeh setPos [getPos _spawnedVeh select 0, getPos _spawnedVeh select 1];
                _spawnedVeh setvectorUp surfaceNormal position _spawnedVeh;
                _spawnedVeh allowdamage true;
                _target removeAction _actionId;

                // if turret, allow it to be moved by player | todo: Storage system for statics...
                if ((toLower (gettext (configFile >> 'cfgvehicles' >> (typeOf _spawnedVeh) >> 'vehicleClass')) isEqualto 'static')) then {
                    [_spawnedVeh, [format [localize "str_TRGM2_UnloadDingy_push", gettext (configFile >> "Cfgvehicles" >> (typeOf _spawnedVeh) >> "displayname")], {
                        _this spawn TRGM_GLOBAL_fnc_pushObject;
                    }, [], -99, false, false, "", "_this isEqualTo player && count crew _target isEqualto 0"]] remoteExec ["addAction", 0];
                } else {
                    // if not a turret, allow an inflatable boat to be unloaded.
                    [_spawnedVeh, [localize "str_TRGM2_startinfMission_UnloadDingy", {
                        _this spawn TRGM_GLOBAL_fnc_unloadDingy;
                    }, [], -99, false, false, "", "_this isEqualTo player && count crew _target isEqualto 0"]] remoteExec ["addAction", 0];
                    [_spawnedVeh, (units group _caller)] call TRGM_GLOBAL_fnc_initAmmoBox;
                };

                _data = [];
                _vehicleFaction = faction _spawnedVeh;
                {
                    _items = [];
                    {
                        _configName = configname _x;
                        _displayName = gettext (_x >> "displayName");
                        _factions = getarray (_x >> "factions");
                        if (count _factions isEqualTo 0) then {_factions = [_vehicleFaction];};
                        if (
                            _displayName != ""
                            &&
                            {getnumber (_x >> "scope") > 1 || !isnumber (_x >> "scope")}
                            &&
                            {{_x isEqualTo _vehicleFaction} count _factions > 0}
                        ) then {
                            _items pushback [_x,_displayName];
                        };
                    } foreach (configproperties [_x,"isclass _x",true]);
                    _data pushback _items;
                } foreach [
                    configfile >> "cfgvehicles" >> typeof _spawnedVeh >> "animationSources",
                    configfile >> "cfgvehicles" >> typeof _spawnedVeh >> "textureSources"
                ];

                if (count _data > 0) then {
                    ["Open", _spawnedVeh] spawn TRGM_GUI_fnc_openVehicleCustomizationDialog;
                };

            }, [_spawnedVeh], 5, true, true];

            if (call TRGM_GETTER_fnc_bVehiclesRequireRep) then {
                TRGM_VAR_SpawnedVehicles pushBack _spawnedVeh;
                publicVariable "TRGM_VAR_SpawnedVehicles";
                _spawnedVeh addEventHandler ["Killed", {
                    params ["_unit", "_killer", "_instigator", "_useEffects"];
                    [1, format[localize "str_TRGM2_spawnvehicles_KIA", name _unit]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
                }];
            };

            titleText[localize "str_TRGM2_opendialogRequests_vehiclespawned", "PLAin"];
        };
    } else {
        titleText [localize "str_TRGM2_spawnvehicles_MoreReputation", "PLAin"];
    };

    closedialog 0;
    false;
}];

true;