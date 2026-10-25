disableSerialization;

if (isNil "iMissionParamObjective2") then {
	iMissionParamObjective2 = 0;
	publicVariable "iMissionParamObjective2";
};
if (isNil "iMissionParamObjective3") then {
	iMissionParamObjective3 = 0;
	publicVariable "iMissionParamObjective3";
};

if (!isNull (findDisplay 5000)) then {
	[] call TRGM_fnc_readMainParams;
};


closedialog 0;

sleep 0.1;

createDialog "Trend_DialogSetupParamsAdvanced";
waitUntil {!isNull (findDisplay 6000);};

_display = findDisplay 6000;
_lineHeight = 0.03;

_display ctrlCreate ["RscText", 6999];
_lblctrlTitle = _display displayCtrl 6999;
_lblctrlTitle ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
ctrlSetText [6999,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_AdvOpt"];

_display ctrlCreate ["RscButton", 6998];
_btnSetEnemyFaction = _display displayCtrl 6998;
_btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
_btnSetEnemyFaction ctrlCommit 0;
ctrlSetText [6998,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy"];
_btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] execVM 'RandFramework\GUI\openDialogEnemyFaction.sqf'; false}];


_display ctrlCreate ["RscButton", 6997];
_btnSetEnemyFaction = _display displayCtrl 6997;
_btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 * 1.1) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
_btnSetEnemyFaction ctrlCommit 0;
ctrlSetText [6997,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomLoadouts"];
_btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] execVM 'RandFramework\GUI\openDialogTeamLoadouts.sqf'; false}];


_lblctrlTitle ctrlCommit 0;

{
	_currentLinePos = _lineHeight * (_forEachIndex + 1);
	_lblCtrlID =  _x select 0;
	_InpCtrlID = _lblCtrlID + 1;
	_lblText = _x select 1;
	_lnpCtrlType = _x select 2;
	_Options = _x select 3;
	_Values = _x select 4;
	_DefaultSelIndex = _x select 5;
	_toolTip = _x select 6;

	_display ctrlCreate ["RscText", _lblCtrlID];
	_lblctrl = _display displayCtrl _lblCtrlID;
	_lblctrl ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.27 + _currentLinePos) * safezoneH + safezoneY,0.08 * safezoneW,0.02 * safezoneH];
	ctrlSetText [_lblCtrlID,  _x select 1];
	_lblctrl ctrlCommit 0;

	_display ctrlCreate [_lnpCtrlType, _InpCtrlID];
	_inpctrl = _display displayCtrl _InpCtrlID;
	_inpctrl ctrlSetPosition [0.4 * safezoneW + safezoneX, (0.27 + _currentLinePos) * safezoneH + safezoneY,0.08 * safezoneW,0.02 * safezoneH];

	if (_lnpCtrlType == "RscCombo") then {
		{
			_inpctrl lbAdd _x;
		} forEach _Options;
		_inpctrl lbSetCurSel (_Values find (AdvancedSettings select _forEachIndex));
	};
	if (_lnpCtrlType == "RscEdit") then {
		_inpctrl ctrlSetText (AdvancedSettings select _forEachIndex);
	};
	_inpctrl ctrlCommit 0;
	_inpctrl ctrlSetTooltip _toolTip;

} forEach AdvControls;

if (EnemyFactionData != "") then {
	_display ctrlCreate ["RscText", 6996];
	_lblctrlWarn1 = _display displayCtrl 6996;
	_lblctrlWarn1 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.70 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
	_lblctrlWarn1 ctrlSetTextColor [1, 0, 0, 1];

	ctrlSetText [6996,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy_Hint"];

	_lblctrlWarn1 ctrlCommit 0;
};
if (LoadoutData != "") then {
	_display ctrlCreate ["RscText", 6995];
	_lblctrlWarn2 = _display displayCtrl 6995;
	_lblctrlWarn2 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.72 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
	_lblctrlWarn2 ctrlSetTextColor [1, 0, 0, 1];

	ctrlSetText [6995,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomFriend_Hint"];

	_lblctrlWarn2 ctrlCommit 0;
};


//AdvancedSettings select ADVSET_VIRTUAL_ARSENAL_IDX
