params ["_radio","_caller","_id","_args"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

private _objParams = _radio getVariable "ObjectiveParams";
_objParams params ["_markerType","_objectiveMainBuilding","_centralAO_x","_centralAO_y","_roadSearchRange", "_bCreateTask", "_iTaskIndex", "_bIsMainObjective", ["_args", []]];

if (side _caller isEqualTo west && !_bCreateTask) then {
    ["HQ are listening in, stand by..."] call TRGM_GLOBAL_fnc_notifyGlobal;
    sleep 10;
    for [{private _i = 0;}, {_i < 3;}, {_i = _i + 1;}] do {
        if (getMarkerType format["mrkMainObjective%1", _i] isEqualTo "empty") then {
            format["mrkMainObjective%1", _i] setMarkerType "mil_unknown";
            ["Map updated with main AO location"] spawn TRGM_GLOBAL_fnc_notifyGlobal;
        } else {
            [TRGM_VAR_IntelShownType,"BugRadio"] spawn TRGM_GLOBAL_fnc_showIntel;
        };
    };
};

[_radio] spawn TRGM_SERVER_fnc_updateTask;

true;