 /* FHQ_fnc_ttSetTaskStateAndNext
  * 
  * Set the state of a given task to the given state, and select another task from a list of
  * tasks which is not finished yet. The first task found will be set to assigned and a message will
  * be shown to the player, if enabled.
  * 
  * NOTE: Can only be called on the server
  * 
  * Usage:
  * [_task1, _state, _task2, ...] call FHQ_fnc_ttSetTaskStateAndNext;
  * 
  * _task1: The task to set to _state
  * _state: The state for _task1
  * _task2 and following: The tasks are checked in turn for completion, and the first one not
  *   completed will be assigned.
  * 
  * Example:
  * 
  * ["taskGetVodka", "succeeded", "taskDrink", "taskBeMerry"] call FHQ_fnc_ttSetTaskStateAndNext;
  */

private "_i";
[_this select 0, _this select 1] call FHQ_fnc_ttSetTaskState;
    
for [ {_i = 2}, {_i < count _this}, {_i = _i + 1} ] do
{
    if (!([_this select _i] call FHQ_fnc_ttIsTaskCompleted)) exitWith
    {
        [_this select _i, "assigned"] call FHQ_fnc_ttSetTaskState;
    };
};
