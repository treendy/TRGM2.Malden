//Reads the mission setup dialog (display 5000) into the mission param globals and broadcasts them (does nothing if the dialog is not open,
//e.g. when Begin is pressed on the more settings page: the values were read when leaving this page)
disableSerialization;
private _display = findDisplay 5000;
if (isNull _display) exitWith {};

//the mission type is worked out from the operation / side ops / intel choices by TRGM_fnc_missionSetupUpdate
publicVariable "iMissionParamType";

{
	_x params ["_idc", "_varName", "_values"];
	//nothing selected (e.g. a saved value that is no longer in the list): use the first option
	missionNamespace setVariable [_varName, _values select ((lbCurSel (_display displayCtrl _idc)) max 0)];
	publicVariable _varName;
} forEach [
	[5104, "iMissionParamObjective", MissionParamObjectivesValues],
	[5102, "iAllowNVG", MissionParamNVGOptionsValues],
	[5100, "iMissionParamRepOption", MissionParamRepOptionsValues],
	[5101, "iWeather", MissionParamWeatherOptionsValues],
	[5103, "iUseRevive", MissionParamReviveOptionsValues],
	[2105, "iStartLocation", MissionParamLocationOptionsValues]
];

//the extra objective combos are only shown for mission types with more than one objective
{
	_x params ["_idc", "_varName"];
	private _ctrl = _display displayCtrl _idc;
	missionNamespace setVariable [_varName, [0, MissionParamObjectivesValues select ((lbCurSel _ctrl) max 0)] select (ctrlShown _ctrl)];
	publicVariable _varName;
} forEach [[7001, "iMissionParamObjective2"], [7002, "iMissionParamObjective3"]];
