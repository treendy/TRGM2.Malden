#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;



if (!isNull (findDisplay 6000)) then {
	AdvancedSettings = [];
	{
		_CurrentControl = _x;
		_ThisControlOptions = (_x select 4);
		_ThisControlIDX = (_x select 0) + 1;
		_ctrlItem = (findDisplay 6000) displayCtrl _ThisControlIDX;
		debugMessages = "\n\n" + str(lbCurSel _ctrlItem);
		publicVariable "debugMessages";
		_value = _ThisControlOptions select (lbCurSel _ctrlItem);
		AdvancedSettings pushBack _value; 
	} forEach AdvControls;
	publicVariable "AdvancedSettings";

	//_ctrlItem = (findDisplay 6000) displayCtrl 5500;
	//iMissionParamType = MissionParamTypesValues select lbCurSel _ctrlItem;
	//publicVariable "iMissionParamType";
};

closedialog 0;

sleep 0.1;


createDialog "Trend_DialogSetupParams";
waitUntil {!isNull (findDisplay 5000);};
//hint "opening 2dialogB";




_ctrlItem = (findDisplay 5000) displayCtrl 5500;
_optionItem = MissionParamTypes;
{
	_ctrlItem lbAdd _x;
} forEach _optionItem;

_ctrlTypes = (findDisplay 5000) displayCtrl 5104;
_optionTypes = MissionParamObjectives;
{
	_ctrlTypes lbAdd _x;
} forEach _optionTypes;

_ctrlNVG = (findDisplay 5000) displayCtrl 5102;
_optionNVG = MissionParamNVGOptions;
{
	_ctrlNVG lbAdd _x;
} forEach _optionNVG;

_ctrlRep = (findDisplay 5000) displayCtrl 5100;
_optionRep = MissionParamRepOptions;
{
	_ctrlRep lbAdd _x;
} forEach _optionRep;

_ctrlWeather = (findDisplay 5000) displayCtrl 5101;
_optionWeathers = MissionParamWeatherOptions;
{
	_ctrlWeather lbAdd _x;
} forEach _optionWeathers;

_ctrlRevive = (findDisplay 5000) displayCtrl 5103;
_optionRevive = MissionParamReviveOptions;
{
	_ctrlRevive lbAdd _x;
} forEach _optionRevive;

_ctrlLocation = (findDisplay 5000) displayCtrl 2105;
_optionLocation = MissionParamLocationOptions;
{
	_ctrlLocation lbAdd _x;
} forEach _optionLocation;

_ctrlItem lbSetCurSel (MissionParamTypesValues find iMissionParamType);
_ctrlTypes lbSetCurSel (MissionParamObjectivesValues find iMissionParamObjective);
_ctrlRep lbSetCurSel (MissionParamRepOptionsValues find iMissionParamRepOption);
_ctrlWeather lbSetCurSel (MissionParamWeatherOptionsValues find iWeather);
_ctrlNVG lbSetCurSel (MissionParamNVGOptionsValues find iAllowNVG);
_ctrlRevive lbSetCurSel (MissionParamReviveOptionsValues find iUseRevive);
_ctrlLocation lbSetCurSel (MissionParamLocationOptionsValues find iStartLocation);
