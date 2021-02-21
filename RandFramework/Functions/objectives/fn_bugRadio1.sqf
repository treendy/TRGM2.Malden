params ["_radio","_caller","_id","_args"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private _iSelected = _radio getVariable "taskIndex";
private _bCreateTask = _radio getVariable "createTask";

if (side _caller == west && !_bCreateTask) then {
	["HQ are listening in, stand by..."] call TREND_fnc_notifyGlobal;
	sleep 10;
	for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
		if (getMarkerType format["mrkMainObjective%1", _i] == "empty") then {
			format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
			["Map updated with main AO location"] spawn TREND_fnc_notifyGlobal;
		} else {
			[TREND_IntelShownType,"BugRadio"] spawn TREND_fnc_showIntel;
		};
	};
	_radio spawn TREND_fnc_updateTask;
};