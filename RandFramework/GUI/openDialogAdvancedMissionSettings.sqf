#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;

if (!isNull (findDisplay 5000)) then {
	_ctrlItem = (findDisplay 5000) displayCtrl 5500;
	iMissionParamType = MissionParamTypesValues select lbCurSel _ctrlItem;
	publicVariable "iMissionParamType";

	_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
	iMissionParamObjective = MissionParamObjectivesValues select lbCurSel _ctrlTypes;
	publicVariable "iMissionParamObjective";

	_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
	iAllowNVG = MissionParamNVGOptionsValues select lbCurSel _ctrlNVG;
	publicVariable "iAllowNVG";

	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	iMissionParamRepOption = MissionParamRepOptionsValues select lbCurSel _ctrlRep;
	publicVariable "iMissionParamRepOption";


	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	iWeather = MissionParamWeatherOptionsValues select lbCurSel _ctrlWeather;
	publicVariable "iWeather";

	_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
	iUseRevive = MissionParamReviveOptionsValues select lbCurSel _ctrlRevive;
	publicVariable "iUseRevive";

	_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
	iStartLocation = MissionParamLocationOptionsValues select lbCurSel _ctrlLocation;
	publicVariable "iStartLocation";
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
ctrlSetText [6999,  "Advanced Options (more options soon!)"];

_display ctrlCreate ["RscButton", 6998];
_btnSetEnemyFaction = _display displayCtrl 6998;
_btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
_btnSetEnemyFaction ctrlCommit 0;
ctrlSetText [6998,  "Custom Enemy Classnames"];
_btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] execVM 'RandFramework\GUI\openDialogEnemyFaction.sqf'; false}];


_display ctrlCreate ["RscButton", 6997];
_btnSetEnemyFaction = _display displayCtrl 6997;
_btnSetEnemyFaction ctrlSetPosition [0.6 * safezoneW + safezoneX, (0.25 * 1.1) * safezoneH + safezoneY,0.1 * safezoneW,0.02 * safezoneH];
_btnSetEnemyFaction ctrlCommit 0;
ctrlSetText [6997,  "Custom Team Loadouts"];
_btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {[] execVM 'RandFramework\GUI\openDialogTeamLoadouts.sqf'; false}];




//colorText[] = {0,1,0,1};

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

} forEach AdvControls;

if (EnemyFactionData != "") then {
	_display ctrlCreate ["RscText", 6996];
	_lblctrlWarn1 = _display displayCtrl 6996;
	_lblctrlWarn1 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.70 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
	_lblctrlWarn1 ctrlSetTextColor [1, 0, 0, 1];
	ctrlSetText [6996,  "You have enemy class names active, this will overright enemy faction settings you have selected above"];
	_lblctrlWarn1 ctrlCommit 0;
};
if (LoadoutData != "") then {
	_display ctrlCreate ["RscText", 6995];
	_lblctrlWarn2 = _display displayCtrl 6995;
	_lblctrlWarn2 ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.72 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
	_lblctrlWarn2 ctrlSetTextColor [1, 0, 0, 1];
	ctrlSetText [6995,  "You have friendly class names active, this will overright friendly faction settings you have selected above"];
	_lblctrlWarn2 ctrlCommit 0;
};



//AdvancedSettings select ADVSET_VIRTUAL_ARSENAL_IDX
