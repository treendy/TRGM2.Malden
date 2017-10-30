#include "..\..\setUnitGlobalVars.sqf";

hint "opening 2dialogA";

disableSerialization;
createDialog "Trend_DialogTest";
waitUntil {!isNull (findDisplay 5000);};
hint "opening 2dialogB";


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

_ctrlItem lbSetCurSel 0;
_ctrlTypes lbSetCurSel 0;
_ctrlRep lbSetCurSel 0;
_ctrlWeather lbSetCurSel 0;
_ctrlNVG lbSetCurSel 0;
_ctrlRevive lbSetCurSel 0;
