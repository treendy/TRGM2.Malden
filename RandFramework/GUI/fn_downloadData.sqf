/*
[OBJECT, ["DOWNLOAD DATA", { _this spawn TRGM_GUI_fnc_downloadData; }, ["Downloading data from terminal...", "FUNCTION", true, ["This is an array of arguments for the callback!"]], 0, true, true, "", "_this isEqualTo player"]] remoteExec ["addAction", 0, true];
*/

[[_this select 0, _this select 1, _this select 2, _this select 3], {
	params ["_target" , "_caller", "_id", "_arguments"];
	_arguments params [["_text", "Downloading Data...", [""]], ["_passTargetCallerIDParams", true], ["_callback", "", [""]], ["_callbackArgs", []]];
	if (isDedicated || !hasInterface) exitWith {};
	disableSerialization;

	_getSignal = {
		_signal = switch (true) do
		{
			case ((_this select 0) distance2d getPosATL (_this select 1) <= 5) :
			{
				["a3\Ui_f\data\IGUI\RscTitles\RscHvtPhase\JAC_A3_Signal_4_ca.paa", .5]
			};
			case ((_this select 0) distance2d getPosATL (_this select 1) > 5 && (_this select 0) distance2d getPosATL (_this select 1) <= 10) :
			{
				["a3\Ui_f\data\IGUI\RscTitles\RscHvtPhase\JAC_A3_Signal_3_ca.paa", 1]
			};
			case ((_this select 0) distance2d getPosATL (_this select 1) > 10 && (_this select 0) distance2d getPosATL (_this select 1) <= 15) :
			{
				["a3\Ui_f\data\IGUI\RscTitles\RscHvtPhase\JAC_A3_Signal_2_ca.paa", 1.5]
			};
			case ((_this select 0) distance2d getPosATL (_this select 1) > 15 && (_this select 0) distance2d getPosATL (_this select 1) <= 20) :
			{
				["a3\Ui_f\data\IGUI\RscTitles\RscHvtPhase\JAC_A3_Signal_1_ca.paa", 2]
			};
			case ((_this select 0) distance2d getPosATL (_this select 1) > 20) :
			{
				["", 1]
			};
		};
		_signal
	};

	if (isNil {uiNamespace getVariable "disp_downloadingData"}) then {uiNamespace setVariable ["disp_downloadingData", displayNull];};

	("Layer_Download_Data" call BIS_fnc_rscLayer) cutRsc ["Download_Data", "PLAIN", 0.01, false];
	waitUntil {!isNull (uiNamespace getVariable ["disp_downloadingData", displayNull]);};
	_display = uiNamespace getVariable "disp_downloadingData";

	(_display displayCtrl 200) ctrlSetText _text;

	_downloaded = 0;
	_increment = 1;

	while {_downloaded < 100 && "Layer_Download_Data" in allCutLayers} do
	{
		_downloaded = _downloaded + _increment;
		_multiplier = ({alive _x && _x distance2d getPosATL _target <= 20} count units group _caller);
		if (_multiplier < 1) then {_multiplier = 1;}; //No dividing by zero here!
		_signalRet = [_caller, _target] call _getSignal;
		_signalRet params ["_signalIcon", "_signalMultiplier"];
		(_display displayCtrl 300) ctrlSetText format ["%1", _multiplier];
		(_display displayCtrl 400) progressSetPosition (_downloaded / 100);
		(_display displayCtrl 500) ctrlSetText format ["%1%2 / 100%2", _downloaded, "%"];
		(_display displayCtrl 700) ctrlSetText format ["%1", _signalIcon];
		if (_caller distance2d getPosATL _target > 20) exitWith
		{
			("Layer_Download_Data" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
		};
		sleep (_signalMultiplier/_multiplier);
	};

	("Layer_Download_Data" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	if (player isEqualTo _caller) then {
		if (_passTargetCallerIDParams) then {
			[_target, _caller, _id, _callbackArgs] spawn (missionNamespace getVariable _callback);
		} else {
			_callbackArgs spawn (missionNamespace getVariable _callback);
		};
	};
}] remoteExec ["spawn"];