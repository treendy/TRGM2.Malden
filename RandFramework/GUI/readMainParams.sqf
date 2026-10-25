//Reads the mission setup dialog (display 5000) into the mission param globals and broadcasts them; with _bObjectivesOnly just the 2nd/3rd objective combos
params [["_bObjectivesOnly", false]];

disableSerialization;
private _display = findDisplay 5000;

if (!_bObjectivesOnly) then {
	{
		_x params ["_idc", "_varName", "_values"];
		//nothing selected (e.g. a saved value that is no longer in the list): use the first option
		missionNamespace setVariable [_varName, _values select ((lbCurSel (_display displayCtrl _idc)) max 0)];
		publicVariable _varName;
	} forEach [
		[5500, "iMissionParamType", MissionParamTypesValues],
		[5104, "iMissionParamObjective", MissionParamObjectivesValues],
		[5102, "iAllowNVG", MissionParamNVGOptionsValues],
		[5100, "iMissionParamRepOption", MissionParamRepOptionsValues],
		[5101, "iWeather", MissionParamWeatherOptionsValues],
		[5103, "iUseRevive", MissionParamReviveOptionsValues],
		[2105, "iStartLocation", MissionParamLocationOptionsValues]
	];
};

//the extra objective combos only exist for some mission types
{
	_x params ["_idc", "_varName"];
	if (!isNull (_display displayCtrl _idc)) then {
		missionNamespace setVariable [_varName, MissionParamObjectivesValues select ((lbCurSel (_display displayCtrl _idc)) max 0)];
		publicVariable _varName;
	};
} forEach [[7001, "iMissionParamObjective2"], [7002, "iMissionParamObjective3"]];
