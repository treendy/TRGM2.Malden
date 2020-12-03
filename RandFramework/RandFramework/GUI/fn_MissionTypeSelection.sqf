disableSerialization;

_thisThis = _this select 0;

_selectedIndex = _thisThis select 1;

if (isNil "TREND_iMissionParamObjective2") then { TREND_iMissionParamObjective2 =   0; publicVariable "TREND_iMissionParamObjective2"; };
if (isNil "TREND_iMissionParamObjective3") then { TREND_iMissionParamObjective3 =   0; publicVariable "TREND_iMissionParamObjective3"; };

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

_display = findDisplay 5000;
_ctrl = (findDisplay 5000) displayCtrl 5001;
_ctrl ctrlSetText format["%1",TREND_MissionTypeDescriptions select _selectedIndex]; // for Displays


_display ctrlCreate ["RscStructuredText", 7003];
_ctrlText1 = _display displayCtrl 7003;
_ctrlText1 ctrlSetStructuredText parseText "<t color='#ccaaaa'>Visit <a href='http://www.trgm2.com'>www.trgm2.com</a> for help and features... or donations : )</t>";
_ctrlText1 ctrlSetTextColor [1, 1, 0, 1];
_ctrlText1 ctrlSetPosition [0.303 * safezoneW + safezoneX, (0.770) * safezoneH + safezoneY,0.3 * safezoneW,0.1 * safezoneH];
_ctrlText1 ctrlCommit 0;


if (isNil "TREND_AllowMissionTypeCampaign") then { TREND_AllowMissionTypeCampaign =   false; publicVariable "TREND_AllowMissionTypeCampaign"; };
_selectedTypeID = TREND_MissionParamTypesValues select _selectedIndex;

if (_selectedTypeID == 5) then {
	if (!TREND_AllowMissionTypeCampaign) then {
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

if (_selectedTypeID == 0 || _selectedTypeID == 6 || _selectedTypeID == 4 || _selectedTypeID == 7 || _selectedTypeID == 8 || _selectedTypeID == 9) then {
	if (isNull((findDisplay 5000) displayCtrl 7001)) then {
		_display ctrlCreate ["RscCombo", 7001];
		_inpctrl1 = _display displayCtrl 7001;
		_inpctrl1 ctrlSetTextColor [1, 1, 0, 1];
		_inpctrl1 ctrlSetPosition [0.541 * safezoneW + safezoneX, (0.561) * safezoneH + safezoneY,0.08 * safezoneW,0.02 * safezoneH];
		_inpctrl1 ctrlCommit 0;
		_ctrlTypes1 = (findDisplay 5000) displayCtrl 7001;
		_optionTypes = TREND_MissionParamObjectives;
		{
			_ctrlTypes1 lbAdd _x;
		} forEach _optionTypes;
		_ctrlTypes1 lbSetCurSel (TREND_MissionParamObjectivesValues find TREND_iMissionParamObjective2);
	};
	if (isNull((findDisplay 5000) displayCtrl 7002)) then {
		_display ctrlCreate ["RscCombo", 7002];
		_inpctrl2 = _display displayCtrl 7002;
		_inpctrl2 ctrlSetTextColor [1, 1, 0, 1];
		_inpctrl2 ctrlSetPosition [0.621 * safezoneW + safezoneX, (0.561) * safezoneH + safezoneY,0.08 * safezoneW,0.02 * safezoneH];
		_inpctrl2 ctrlCommit 0;
		_ctrlTypes2 = (findDisplay 5000) displayCtrl 7002;
		_optionTypes = TREND_MissionParamObjectives;
		{
			_ctrlTypes2 lbAdd _x;
		} forEach _optionTypes;
		_ctrlTypes2 lbSetCurSel (TREND_MissionParamObjectivesValues find TREND_iMissionParamObjective3);
	};

	if (_selectedTypeID == 8 || _selectedTypeID == 9) then {
		if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
			ctrlDelete ((findDisplay 5000) displayCtrl 7002);
			TREND_iMissionParamObjective3 = 0;
		};
	};
}
else {
	if (!isNull((findDisplay 5000) displayCtrl 7001)) then {
		ctrlDelete ((findDisplay 5000) displayCtrl 7001);
		TREND_iMissionParamObjective2 = 0;
	};
	if (!isNull((findDisplay 5000) displayCtrl 7002)) then {
		ctrlDelete ((findDisplay 5000) displayCtrl 7002);
		TREND_iMissionParamObjective3 = 0;
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