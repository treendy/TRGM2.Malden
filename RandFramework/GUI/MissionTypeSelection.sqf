#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;

_thisThis = _this select 0;

_selectedIndex = _thisThis select 1;

_ctrl = (findDisplay 5000) displayCtrl 5001;
_ctrl ctrlSetText format["%1",MissionTypeDescriptions select _selectedIndex]; // for Displays

if (isNil "AllowMissionTypeCampaign") then {
	AllowMissionTypeCampaign = false;
	publicVariable "AllowMissionTypeCampaign";	
};

if (_selectedIndex == 5) then {
	if (!AllowMissionTypeCampaign) then {
		_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
		_ctrlTypes ctrlEnable false;
	};	
	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	_ctrlRep ctrlEnable false;
	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	_ctrlWeather ctrlEnable false;
}
else {
	_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
	_ctrlTypes ctrlEnable true;
	_ctrlRep = (findDisplay 5000) displayCtrl 5100;
	_ctrlRep ctrlEnable true;
	_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
	_ctrlWeather ctrlEnable true;
}