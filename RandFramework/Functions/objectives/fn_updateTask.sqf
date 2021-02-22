format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
params ["_missionObjective", ["_missionStatus", "succeeded"], ["_customRepReason", ""], ["_customHintString", ""], ["_repAmountOnFail", 0]];

if (isNil "_missionObjective") exitWith {};

if !(_missionStatus in ["succeeded", "failed", "canceled"]) then {
	_missionStatus = "succeeded";
	_customRepReason = "";
	_customHintString = "";
	_repAmountOnFail = 0;
};

private _objParams = _missionObjective getVariable "ObjectiveParams";
_objParams params ["_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];
_args params ["_hintStrOnComplete", ["_repAmountOnComplete", 0], ["_repReasonOnComplete", ""]];

TREND_ClearedPositions pushBack [_centralAO_x, _centralAO_y];
publicVariable "TREND_ClearedPositions";

[_missionObjective] remoteExec ["removeAllActions", 0, true];

if (!_bCreateTask) then {
	if (_repAmountOnComplete > 0 && _repAmountOnFail isEqualTo 0) then {
		[_repAmountOnComplete, [[_customRepReason, _repReasonOnComplete] select (_customRepReason isEqualTo ""), "Objective Completed."] select (_repReasonOnComplete isEqualTo "")] spawn TREND_fnc_AdjustMaxBadPoints;
		[[_customHintString, _hintStrOnComplete] select (_customHintString isEqualTo "")] call TREND_fnc_notifyGlobal;
	} else if (_repAmountOnFail > 0) then {
		[_repAmountOnFail, [_customRepReason, "Objective Failed."] select (_customRepReason isEqualTo "")] spawn TREND_fnc_AdjustBadPoints;
		[[_customHintString, _hintStrOnComplete] select (_customHintString isEqualTo "")] call TREND_fnc_notifyGlobal;
	};
} else {
	if (!([format["InfSide%1",_iTaskIndex]] call FHQ_fnc_ttAreTasksCompleted)) then {
		[format["InfSide%1",_iTaskIndex], _missionStatus] remoteExec ["FHQ_fnc_ttSetTaskState", 0];
	};
};

true;