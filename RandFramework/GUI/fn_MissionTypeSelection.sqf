/*
 * Author: Trendy (Modified by TheAce0296)
 * Does various checks when the mission type is selected,
 * for example, if a triple mission is selected, this function
 * adds the two additional mission task lists to the dialog.
 *
 * Arguments:
 * 0: The list control type that invoked this function.
 *    Arg 0 select 1 is the selected index from the list control.
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [_this] spawn TRGM_GUI_fnc_missionTypeSelection
 */
disableSerialization;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_thisThis = _this select 0;
_selectedIndex = _thisThis select 1;

#define UI_GRID_X        (safezoneX)
#define UI_GRID_Y        (safezoneY)
#define UI_GRID_W        (safezoneW / 40)
#define UI_GRID_H        (safezoneH / 25)
#define UI_GRID_WABS    (safezoneW)
#define UI_GRID_HABS    (safezoneH)
#define MISSIONLISTX     (15.46 * UI_GRID_W + UI_GRID_X)
#define MISSIONLISTY     (13.6 * UI_GRID_H + UI_GRID_Y)
#define MISSIONLISTW     (6.18854 * UI_GRID_W)
#define MISSIONLISTH     (0.54988 * UI_GRID_H)

if (isNil "TRGM_VAR_iMissionParamObjective2") then { TRGM_VAR_iMissionParamObjective2 =   0; publicVariable "TRGM_VAR_iMissionParamObjective2"; };
if (isNil "TRGM_VAR_iMissionParamObjective3") then { TRGM_VAR_iMissionParamObjective3 =   0; publicVariable "TRGM_VAR_iMissionParamObjective3"; };

if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
    _ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
    TRGM_VAR_iMissionParamObjective2 = TRGM_VAR_MissionParamObjectivesValues select lbCurSel _ctrlTypes1;
    publicVariable "TRGM_VAR_iMissionParamObjective2";
};
if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
    _ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
    TRGM_VAR_iMissionParamObjective3 = TRGM_VAR_MissionParamObjectivesValues select lbCurSel _ctrlTypes2;
    publicVariable "TRGM_VAR_iMissionParamObjective3";
};

_display = findDisplay 5000;
_ctrl = (findDisplay 5000) displayCtrl 5001;
_ctrl ctrlSetText format["%1",TRGM_VAR_MissionTypeDescriptions select _selectedIndex]; // for Displays


if (isNil "TRGM_VAR_AllowMissionTypeCampaign") then { TRGM_VAR_AllowMissionTypeCampaign =   false; publicVariable "TRGM_VAR_AllowMissionTypeCampaign"; };
_selectedTypeID = TRGM_VAR_MissionParamTypesValues select _selectedIndex;

if (_selectedTypeID isEqualTo 5) then {
    if (!TRGM_VAR_AllowMissionTypeCampaign) then {
        _ctrlTypes = (findDisplay 5000) displayCtrl 5104;
        _ctrlTypes ctrlEnable false;
        _ctrlTypes lbSetCurSel (0);
    };
    _ctrlRep = (findDisplay 5000) displayCtrl 5100;
    _ctrlRep ctrlEnable false;
    _ctrlRep lbSetCurSel (1);
    _ctrlWeather = (findDisplay 5000) displayCtrl 5101;
    _ctrlWeather ctrlEnable false;
    _ctrlWeather lbSetCurSel (0);
}
else {
    _ctrlTypes = (findDisplay 5000) displayCtrl 5104;
    _ctrlTypes ctrlEnable true;
    _ctrlRep = (findDisplay 5000) displayCtrl 5100;
    _ctrlRep ctrlEnable true;
    _ctrlWeather = (findDisplay 5000) displayCtrl 5101;
    _ctrlWeather ctrlEnable true;
};

if (_selectedTypeID isEqualTo 0 || _selectedTypeID isEqualTo 6 || _selectedTypeID isEqualTo 4 || _selectedTypeID isEqualTo 7 || _selectedTypeID isEqualTo 8 || _selectedTypeID isEqualTo 9 || _selectedTypeID isEqualTo 11 || _selectedTypeID isEqualTo 12) then {
    if (isNull((findDisplay 5000) displayCtrl 7001)) then {
        _display ctrlCreate ["RscCombo", 7001];
        _inpctrl1 = _display displayCtrl 7001;
        _inpctrl1 ctrlSetTextColor [1, 1, 0, 1];
        _inpctrl1 ctrlSetPosition [MISSIONLISTX+MISSIONLISTW, MISSIONLISTY,MISSIONLISTW/2,MISSIONLISTH];
        _inpctrl1 ctrlCommit 0;
        _ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
        _optionTypes = TRGM_VAR_MissionParamObjectives;
        {
            _ctrlTypes1 lbAdd _x;
        } forEach _optionTypes;
        _ctrlTypes1 lbSetCurSel (TRGM_VAR_MissionParamObjectivesValues find TRGM_VAR_iMissionParamObjective2);
    };
    if (isNull((findDisplay 5000) displayCtrl 7002)) then {
        _display ctrlCreate ["RscCombo", 7002];
        _inpctrl2 = _display displayCtrl 7002;
        _inpctrl2 ctrlSetTextColor [1, 1, 0, 1];
        _inpctrl2 ctrlSetPosition [MISSIONLISTX+MISSIONLISTW+(MISSIONLISTW/2), MISSIONLISTY,MISSIONLISTW/2,MISSIONLISTH];
        _inpctrl2 ctrlCommit 0;
        _ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
        _optionTypes = TRGM_VAR_MissionParamObjectives;
        {
            _ctrlTypes2 lbAdd _x;
        } forEach _optionTypes;
        _ctrlTypes2 lbSetCurSel (TRGM_VAR_MissionParamObjectivesValues find TRGM_VAR_iMissionParamObjective3);
    };

    if (_selectedTypeID isEqualTo 8 || _selectedTypeID isEqualTo 9) then {
        if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
            ctrlDelete ((findDisplay 5000) displayCtrl 7002);
            TRGM_VAR_iMissionParamObjective3 = 0;
        };
    };
}
else {
    if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
        ctrlDelete ((findDisplay 5000) displayCtrl 7001);
        TRGM_VAR_iMissionParamObjective2 = 0;
    };
    if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
        ctrlDelete ((findDisplay 5000) displayCtrl 7002);
        TRGM_VAR_iMissionParamObjective3 = 0;
    };
};

if (!isMultiplayer) then {
    _ctrlLoadLocal = (findDisplay 5000) displayCtrl 1601;
    _ctrlLoadGlobal = (findDisplay 5000) displayCtrl 1602;
    _ctrlLoadLocal  ctrlShow false;
    _ctrlLoadGlobal  ctrlShow false;
    //ctrlDelete _ctrlLoadLocal;
    //ctrlDelete _ctrlLoadGlobal;
};

true;