disableSerialization;

if (isNil "TREND_iMissionParamObjective2") then { TREND_iMissionParamObjective2 =   0; publicVariable "TREND_iMissionParamObjective2"; };
if (isNil "TREND_iMissionParamObjective3") then { TREND_iMissionParamObjective3 =   0; publicVariable "TREND_iMissionParamObjective3"; };

if (!isNull (findDisplay 5000)) then {
	_ctrlItem = (findDisplay 5000) displayCtrl 5500;
	TREND_iMissionParamType = TREND_MissionParamTypesValues select lbCurSel _ctrlItem;
	publicVariable "TREND_iMissionParamType";

	_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
	TREND_iMissionParamObjective = TREND_MissionParamObjectivesValues select lbCurSel _ctrlTypes;
	publicVariable "TREND_iMissionParamObjective";

	_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
	TREND_iAllowNVG = TREND_MissionParamNVGOptionsValues select lbCurSel _ctrlNVG;
	publicVariable "TREND_iAllowNVG";

	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	TREND_iMissionParamRepOption = TREND_MissionParamRepOptionsValues select lbCurSel _ctrlRep;
	publicVariable "TREND_iMissionParamRepOption";


	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	TREND_iWeather = TREND_MissionParamWeatherOptionsValues select lbCurSel _ctrlWeather;
	publicVariable "TREND_iWeather";

	_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
	TREND_iUseRevive = TREND_MissionParamReviveOptionsValues select lbCurSel _ctrlRevive;
	publicVariable "TREND_iUseRevive";

	_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
	TREND_iStartLocation = TREND_MissionParamLocationOptionsValues select lbCurSel _ctrlLocation;
	publicVariable "TREND_iStartLocation";

	if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
		_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
		TREND_iMissionParamObjective2 = TREND_MissionParamObjectivesValues select lbCurSel _ctrlTypes1;
		publicVariable "TREND_iMissionParamObjective2";
	};
	if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
		_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
		TREND_iMissionParamObjective3 = TREND_MissionParamObjectivesValues select lbCurSel _ctrlTypes2;
		publicVariable "TREND_iMissionParamObjective3";
	};

};

//hint "opening 2dialogA";

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

// _display ctrlCreate ["RscButton", 6998];
// _btnSetEnemyFaction = _display displayCtrl 6998;
// _btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
// _btnSetEnemyFaction ctrlCommit 0;
// ctrlSetText [6998,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy"];
// _btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] spawn TREND_fnc_openDialogEnemyFaction; false}];


// _display ctrlCreate ["RscButton", 6997];
// _btnSetEnemyFaction = _display displayCtrl 6997;
// _btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 * 1.1) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
// _btnSetEnemyFaction ctrlCommit 0;
// ctrlSetText [6997,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomLoadouts"];
// _btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] spawn TREND_fnc_openDialogTeamLoadouts; false}];




//colorText[] = {0,1,0,1};

_lblctrlTitle ctrlCommit 0;

{
	// _lblCtrlID , _lblText												,_lnpCtrlType ,_Options                          ,_Values                       ,_DefaultSelIndex                       ,tooltip
	//[6013       , localize "STR_TRGM2_TRGMSetUnitGlobalVars_EnemyFactions","RscCombo"   ,TREND_DefaultEnemyFactionArrayText,TREND_DefaultEnemyFactionArray,TREND_DefaultEnemyFactionValue select 0,""     ],
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
	_inpctrl ctrlSetPosition [_inpXPos, _ctrlYPos,_ctrlWidth,_ctrlHeight];

	if (_lnpCtrlType == "RscCombo") then {
		{
			_inpctrl lbAdd _x;
		} forEach _Options;
		_inpctrl lbSetCurSel (_Values find (TREND_AdvancedSettings select _forEachIndex));
	};
	if (_lnpCtrlType == "RscEdit") then {
		_inpctrl ctrlSetText (TREND_AdvancedSettings select _forEachIndex);
	};
	_inpctrl ctrlCommit 0;
	_inpctrl ctrlSetTooltip _toolTip;

} forEach TREND_AdvControls;

// if (TREND_EnemyFactionData != "") then {
// 	_display ctrlCreate ["RscText", 6996];
// 	_lblctrlWarn1 = _display displayCtrl 6996;
// 	_lblctrlWarn1 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.70 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
// 	_lblctrlWarn1 ctrlSetTextColor [1, 0, 0, 1];

// 	ctrlSetText [6996,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy_Hint"];

// 	_lblctrlWarn1 ctrlCommit 0;
// };
// if (TREND_LoadoutData != "") then {
// 	_display ctrlCreate ["RscText", 6995];
// 	_lblctrlWarn2 = _display displayCtrl 6995;
// 	_lblctrlWarn2 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.72 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
// 	_lblctrlWarn2 ctrlSetTextColor [1, 0, 0, 1];

// 	ctrlSetText [6995,  localize "STR_TRGM2_openDialogAdvancedMissionSettings_CustomFriend_Hint"];

// 	_lblctrlWarn2 ctrlCommit 0;
// };

