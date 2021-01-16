params ["_radio","_caller","_id","_args"];
_args params ["_iSelected","_bCreateTask"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (isNil "_iSelected") then {
	_iSelected = _radio getVariable "taskIndex";
};
if (isNil "_bCreateTask") then {
	_bCreateTask = _radio getVariable "CreateTask";
};

if (side _caller == west) then {
	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";

	[_radio] remoteExec ["removeAllActions", 0, true];

	if (_bCreateTask) then {
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_fnc_ttsetTaskState", 0, true];
		//[format["c:%1",str(_iSelected)]] call TREND_fnc_notify;

	}
	else {
		["HQ are listening in, stand by..."] call TREND_fnc_notify;
		sleep 10;
		for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
			if (getMarkerType format["mrkMainObjective%1", _i] == "empty") then {
				format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
				["Map updated with main AO location"] remoteExec ["hint", 0, true];
			} else {
				[TREND_IntelShownType,"BugRadio"] spawn TREND_fnc_showIntel;
			};
		};
	};
};