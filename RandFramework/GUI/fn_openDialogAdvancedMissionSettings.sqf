/*
 * Author: Trendy (Modified by TheAce0296)
 * Opens the advanced mission settings dialog,
 * also saves the settings in the main dialog so
 * they don't get overwritten when moving from the
 * advanced settings dialog to the main dialog.
 *
 * Arguments: None
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [] spawn TRGM_GUI_fnc_openDialogAdvancedMissionSettings
 */

disableSerialization;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (isNil "TRGM_VAR_iMissionParamObjective2") then { TRGM_VAR_iMissionParamObjective2 =   0; publicVariable "TRGM_VAR_iMissionParamObjective2"; };
if (isNil "TRGM_VAR_iMissionParamObjective3") then { TRGM_VAR_iMissionParamObjective3 =   0; publicVariable "TRGM_VAR_iMissionParamObjective3"; };

if (!isNull (findDisplay 5000)) then {
	_ctrlItem = (findDisplay 5000) displayCtrl 5500;
	TRGM_VAR_iMissionParamType = TRGM_VAR_MissionParamTypesValues select lbCurSel _ctrlItem;
	publicVariable "TRGM_VAR_iMissionParamType";

	_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
	TRGM_VAR_iMissionParamObjective = TRGM_VAR_MissionParamObjectivesValues select lbCurSel _ctrlTypes;
	publicVariable "TRGM_VAR_iMissionParamObjective";

	_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
	TRGM_VAR_iAllowNVG = TRGM_VAR_MissionParamNVGOptionsValues select lbCurSel _ctrlNVG;
	publicVariable "TRGM_VAR_iAllowNVG";

	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	TRGM_VAR_iMissionParamRepOption = TRGM_VAR_MissionParamRepOptionsValues select lbCurSel _ctrlRep;
	publicVariable "TRGM_VAR_iMissionParamRepOption";


	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	TRGM_VAR_iWeather = TRGM_VAR_MissionParamWeatherOptionsValues select lbCurSel _ctrlWeather;
	publicVariable "TRGM_VAR_iWeather";

	_ctrlTime = (findDisplay 5000) displayCtrl 5115;
	_ctrlTimeValue = (sliderPosition _ctrlTime) * 3600;
	TRGM_VAR_arrayTime = [floor (_ctrlTimeValue / 3600), floor ((_ctrlTimeValue / 60) mod 60)];
	publicVariable "TRGM_VAR_arrayTime";

	_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
	TRGM_VAR_iUseRevive = TRGM_VAR_MissionParamReviveOptionsValues select lbCurSel _ctrlRevive;
	publicVariable "TRGM_VAR_iUseRevive";

	_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
	TRGM_VAR_iStartLocation = TRGM_VAR_MissionParamLocationOptionsValues select lbCurSel _ctrlLocation;
	publicVariable "TRGM_VAR_iStartLocation";

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

};

closedialog 0;

sleep 0.1;

createDialog "TRGM_VAR_DialogSetupParamsAdvanced";
waitUntil {!isNull (findDisplay 6000);};

_display = findDisplay 6000;
_lineHeight = 0.03;

_display ctrlCreate ["RscText", 6999];
_lblctrlTitle = _display displayCtrl 6999;
_lblctrlTitle ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
ctrlSetText [6999,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_AdvOpt"];

_lblctrlTitle ctrlCommit 0;

{
	// _lblCtrlID , _lblText												,_lnpCtrlType ,_Options                          ,_Values                       ,_DefaultSelIndex                       ,tooltip
	//[6013       , localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFactions","RscCombo"   ,TRGM_VAR_DefaultEnemyFactionArrayText,TRGM_VAR_DefaultEnemyFactionArray,TRGM_VAR_DefaultEnemyFactionValue select 0,""     ],
	_currentLinePos = _lineHeight * (_forEachIndex + 1 - ([0, 13] select (_forEachIndex > 12)));
	_ctrlWidth = 0.08 * safezoneW;
	_ctrlHeight = 0.02 * safezoneH;
	_lblXPos = ([0, ((2 * _ctrlWidth) + 0.1)] select (_forEachIndex > 12)) + (0.3 * safezoneW + safezoneX);
	_inpXPos = ([0, ((2 * _ctrlWidth) + 0.1)] select (_forEachIndex > 12)) + (0.4 * safezoneW + safezoneX);
	_ctrlYPos = ((0.27 + _currentLinePos) * safezoneH + safezoneY);

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
	_lblctrl ctrlSetPosition [_lblXPos, _ctrlYPos,_ctrlWidth,_ctrlHeight];
	ctrlSetText [_lblCtrlID,  _x select 1];
	_lblctrl ctrlCommit 0;

	_display ctrlCreate [_lnpCtrlType, _InpCtrlID];
	_inpctrl = _display displayCtrl _InpCtrlID;
	_inpctrl ctrlSetPosition [_inpXPos, _ctrlYPos,[_ctrlWidth, .75*_ctrlWidth] select (_lnpCtrlType isEqualTo "RscXSliderH"),_ctrlHeight];

	if (_lnpCtrlType isEqualTo "RscCombo") then {
		{
			_inpctrl lbAdd _x;
		} forEach _Options;
		_inpctrl lbSetCurSel (_Values find (TRGM_VAR_AdvancedSettings select _forEachIndex));
	};
	if (_lnpCtrlType isEqualTo "RscEdit") then {
		_inpctrl ctrlSetText (TRGM_VAR_AdvancedSettings select _forEachIndex);
	};
	if (_lnpCtrlType isEqualTo "RscXSliderH") then {
		_inpctrl sliderSetRange [_Options, _Values];
		_inpctrl sliderSetSpeed [(_Values / _Options), 1];
		_inpctrl sliderSetPosition (TRGM_VAR_AdvancedSettings select _forEachIndex);

		_display ctrlCreate ["ctrlEdit", (_InpCtrlID+500)];
		_valctrl = _display displayCtrl (_InpCtrlID+500);
		_valctrl ctrlSetPosition [_inpXPos+(.75*_ctrlWidth), _ctrlYPos,.25*_ctrlWidth,_ctrlHeight];
		_valctrl ctrlSetText (str(round (TRGM_VAR_AdvancedSettings select _forEachIndex)) + "s");
		_valctrl ctrlCommit 0;

		_inpctrl ctrlAddEventHandler ["SliderPosChanged", {
			params ["_control", "_newValue"];
			_display 	= findDisplay 6000;
			_ctrlIDC 	= ctrlIDC _control;
			_ctrlSlider	= _display displayCtrl _ctrlIDC;
			_ctrlVal 	= _display displayCtrl (_ctrlIDC+500);
			_ctrlVal ctrlSetText (str(round _newValue) + "s");
		}];
	};
	_inpctrl ctrlCommit 0;
	_inpctrl ctrlSetTooltip _toolTip;

} forEach TRGM_VAR_AdvControls;

// Ace - TODO: Convert Custom Faction System into new Faction selection...

// _display ctrlCreate ["RscButton", 6998];
// _btnSetEnemyFaction = _display displayCtrl 6998;
// _btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
// _btnSetEnemyFaction ctrlCommit 0;
// ctrlSetText [6998,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy"];
// _btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] spawn TRGM_GUI_fnc_openDialogEnemyFaction; false}];

// _display ctrlCreate ["RscButton", 6997];
// _btnSetEnemyFaction = _display displayCtrl 6997;
// _btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 * 1.1) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
// _btnSetEnemyFaction ctrlCommit 0;
// ctrlSetText [6997,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomLoadouts"];
// _btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] spawn TRGM_GUI_fnc_openDialogTeamLoadouts; false}];.

// if (TRGM_VAR_EnemyFactionData != "") then {
// 	_display ctrlCreate ["RscText", 6996];
// 	_lblctrlWarn1 = _display displayCtrl 6996;
// 	_lblctrlWarn1 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.70 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
// 	_lblctrlWarn1 ctrlSetTextColor [1, 0, 0, 1];

// 	ctrlSetText [6996,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy_Hint"];

// 	_lblctrlWarn1 ctrlCommit 0;
// };
// if (TRGM_VAR_LoadoutData != "") then {
// 	_display ctrlCreate ["RscText", 6995];
// 	_lblctrlWarn2 = _display displayCtrl 6995;
// 	_lblctrlWarn2 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.72 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
// 	_lblctrlWarn2 ctrlSetTextColor [1, 0, 0, 1];

// 	ctrlSetText [6995,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomFriend_Hint"];

// 	_lblctrlWarn2 ctrlCommit 0;
// };

