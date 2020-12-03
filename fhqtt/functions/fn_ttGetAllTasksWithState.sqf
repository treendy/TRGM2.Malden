/* FHQ_fnc_ttGetAllTasksWithState
 * 
 * Get all tasks with a given state. This function can be called on the client as well as
 * the server.
 * 
 * _taskList = [_state] call FHQ_fnc_ttGetAllTasksWithState;
 */

#define FHQ_TTIF_TASKSTATE	5

private ["_result", "_taskState"];
    
_result = [];
_taskState = [_this, 0, "", [""]] call BIS_fnc_param;
    
{
    if (((_x select 1) select FHQ_TTIF_TASKSTATE) == _taskState) then
    {
        _result = _result + [(_x select 1) call FHQ_fnc_ttiGetTaskName];
    };
} forEach FHQ_TTI_TaskList;
    
_result;   	
