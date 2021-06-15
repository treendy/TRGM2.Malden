format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
params ["_missionObjective", ["_missionStatus", "succeeded"], ["_customRepReason", ""], ["_customHintString", ""], ["_repAmountOnFail", 0]];

if (isNil "_missionObjective") exitWith {};

if !(_missionStatus in ["succeeded", "failed", "canceled"]) then {
	_missionStatus = "succeeded";
	_customRepReason = "";
	_customHintString = "";
	_repAmountOnFail = 0;
};

_objParams = [];

switch (typeName _missionObjective) do {
	case "SCALAR": {
		_objParams = missionNamespace getVariable (format ["missionObjectiveParams%1", _missionObjective]);
	};
	case "STRING": {
		_objParams = missionNamespace getVariable _missionObjective;
	};
	case "OBJECT": {
		_objParams = _missionObjective getVariable "ObjectiveParams";
		[_missionObjective] remoteExec ["removeAllActions", 0, true];
	};
	default {};
};

if (_objParams isEqualTo []) exitWith {};

_objParams params ["_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];
_args params ["_hintStrOnComplete", ["_repAmountOnComplete", 0], ["_repReasonOnComplete", ""]];

TRGM_VAR_ClearedPositions pushBack [_centralAO_x, _centralAO_y];
publicVariable "TRGM_VAR_ClearedPositions";

if (!_bCreateTask) then {
	if (_repAmountOnComplete > 0 && _repAmountOnFail isEqualTo 0) then {
		[_repAmountOnComplete, [[_customRepReason, _repReasonOnComplete] select (_customRepReason isEqualTo ""), "Objective Completed."] select (_repReasonOnComplete isEqualTo "")] spawn TRGM_GLOBAL_fnc_adjustMaxBadPoints;
		[[_customHintString, _hintStrOnComplete] select (_customHintString isEqualTo "")] call TRGM_GLOBAL_fnc_notifyGlobal;
	} else if (_repAmountOnFail > 0) then {
		[_repAmountOnFail, [_customRepReason, "Objective Failed."] select (_customRepReason isEqualTo "")] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
		[[_customHintString, _hintStrOnComplete] select (_customHintString isEqualTo "")] call TRGM_GLOBAL_fnc_notifyGlobal;
	};
} else {
	if (!([format["InfSide%1",_iTaskIndex]] call FHQ_fnc_ttAreTasksCompleted)) then {
		[format["InfSide%1",_iTaskIndex], _missionStatus] remoteExec ["FHQ_fnc_ttSetTaskState", 0];
	};
};

true;