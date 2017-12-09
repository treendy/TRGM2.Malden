#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;


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


bAndSoItBegins = true; 
publicVariable 'bAndSoItBegins'; 
closedialog 0;