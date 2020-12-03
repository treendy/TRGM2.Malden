/* FHQ_fnc_ttIsTaskCompleted
 * 
 * Check whether a task is canceled, successful or failed. Like all query functions, this can be called
 * on any client as well as the server.
 * 
 * _result = [_task] call FHQ_fnc_ttIsTaskCompleted;
 * 
 * _task: Name of the task.
 * 
 * Returns true or false if the task's state is considered a "completed" state, i.e.
 * succeeded, canceled, or failed
 * 
 */

private "_result";

_result = (tolower(_this call FHQ_fnc_ttGetTaskState) in ["succeeded", "canceled", "failed"]);
_result;    
