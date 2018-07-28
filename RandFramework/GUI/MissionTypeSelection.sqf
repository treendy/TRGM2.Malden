#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;

_thisThis = _this select 0;

_selectedIndex = _thisThis select 1;

if (isNil "iMissionParamObjective2") then {
	iMissionParamObjective2 = 0;
	publicVariable "iMissionParamObjective2";
};
if (isNil "iMissionParamObjective3") then {
	iMissionParamObjective3 = 0;
	publicVariable "iMissionParamObjective3";
};

if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
	_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
	iMissionParamObjective2 = MissionParamObjectivesValues select lbCurSel _ctrlTypes1;
	publicVariable "iMissionParamObjective2";

	_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
	iMissionParamObjective3 = MissionParamObjectivesValues select lbCurSel _ctrlTypes2;
	publicVariable "iMissionParamObjective3";
};

_display = findDisplay 5000;
_ctrl = (findDisplay 5000) displayCtrl 5001;
_ctrl ctrlSetText format["%1",MissionTypeDescriptions select _selectedIndex]; // for Displays


_display ctrlCreate ["RscStructuredText", 7003];
_ctrlText1 = _display displayCtrl 7003;
_ctrlText1 ctrlSetStructuredText parseText "<a href='http://www.trgm2.com'>Click here to visit www.trgm2.com for help and features</a>";
_ctrlText1 ctrlSetTextColor [1, 1, 0, 1];
_ctrlText1 ctrlSetPosition [0.303 * safezoneW + safezoneX, (0.770) * safezoneH + safezoneY,0.2 * safezoneW,0.1 * safezoneH];
_ctrlText1 ctrlCommit 0;


if (isNil "AllowMissionTypeCampaign") then {
	AllowMissionTypeCampaign = false;
	publicVariable "AllowMissionTypeCampaign";	
};
_selectedTypeID = MissionParamTypesValues select _selectedIndex;

if (_selectedTypeID == 5) then {
	if (!AllowMissionTypeCampaign) then {
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

if (_selectedTypeID == 0 || _selectedTypeID == 6 || _selectedTypeID == 4 || _selectedTypeID == 7) then {
	if (isNull((findDisplay 5000) displayCtrl 7001)) then {
		_display ctrlCreate ["RscCombo", 7001];
		_inpctrl1 = _display displayCtrl 7001;
		_inpctrl1 ctrlSetTextColor [1, 1, 0, 1];
		_inpctrl1 ctrlSetPosition [0.541 * safezoneW + safezoneX, (0.561) * safezoneH + safezoneY,0.08 * safezoneW,0.02 * safezoneH];
		_inpctrl1 ctrlCommit 0;

		_display ctrlCreate ["RscCombo", 7002];
		_inpctrl2 = _display displayCtrl 7002;
		_inpctrl2 ctrlSetTextColor [1, 1, 0, 1];
		_inpctrl2 ctrlSetPosition [0.621 * safezoneW + safezoneX, (0.561) * safezoneH + safezoneY,0.08 * safezoneW,0.02 * safezoneH];
		_inpctrl2 ctrlCommit 0;

		_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
		_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
		_optionTypes = MissionParamObjectives;
		{
			_ctrlTypes1 lbAdd _x;
			_ctrlTypes2 lbAdd _x;
		} forEach _optionTypes;

		_ctrlTypes1 lbSetCurSel (MissionParamObjectivesValues find iMissionParamObjective2);
		_ctrlTypes2 lbSetCurSel (MissionParamObjectivesValues find iMissionParamObjective3);
	};
}
else {
	if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
		ctrlDelete ((findDisplay 5000) displayCtrl 7001);
		ctrlDelete ((findDisplay 5000) displayCtrl 7002);
		iMissionParamObjective2 = 0;
		iMissionParamObjective3 = 0;
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