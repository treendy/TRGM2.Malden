/* FHQ_fnc_ttGetTaskState
 * 
 * Get the state of a given task. This function can be called on the client as well as
 * the server.
 * 
 * Usage:
 * _state = [_task] call FHQ_fnc_ttGetTaskState;
 * 
 * _task: The name of a task defined via FHQ_fnc_ttAddTask
 * 
 * Returns the state of the task ("succeeded", "failed", "canceled", "created", "assigned"), or an empty
 * string if the task does not exist
 */

#define FHQ_TTIF_TASKSTATE	5

private ["_res", "_name", "_idx", "_entry"];
_res = "";
    
_name = [_this, 0, "", [""]] call BIS_fnc_param;
          
_idx = [FHQ_TTI_TaskList, _name] call FHQ_fnc_ttiTaskExists;
if (_idx != -1) then {
    _entry = FHQ_TTI_TaskList select _idx;
    _res = (_entry select 1) select FHQ_TTIF_TASKSTATE;
};
    
_res; 