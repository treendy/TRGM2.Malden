/* FHQ_fnc_ttAreTasksSuccessful
 * 
 * Check success for all tasks given.  This function can be called on the client as well as
 * the server.
 * 
 * _result = [_taskName1, _taskName2, ...] call FHQ_fnc_ttAreTasksSuccessful
 */

private ["_result", "_x"];
    
_result = true;
    
{
	if (tolower ([_x] call FHQ_fnc_ttGetTaskState) != "succeeded") exitWith 
    {
    	_result = false;
	};
} forEach _this;

_result;
