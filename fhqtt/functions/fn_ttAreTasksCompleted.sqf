/* FHQ_fnc_ttAreTasksCompleted
 * 
 * Check for all tasks given whether they are considered completed. This function can 
 * be called on the client as well as the server.
 * 
 * Usage
 * _result = [_taskName1, _taskName2, ...] call FHQ_fnc_ttAreTasksCompleted
 * 
 * _taskName1 and following: Task names that are tested for being completed. If any of them is not
 * completed, the function returns false, else true.
 */

private ["_result", "_x"];
    
_result = true;
    
{
	if (!(tolower ([_x] call FHQ_fnc_ttGetTaskState) in ["succeeded", "canceled", "failed"])) exitWith 
    {
         _result = false;
    };
} forEach _this;
     
_result;
