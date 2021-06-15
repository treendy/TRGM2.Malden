
/* FHQ_fnc_ttAddTasks: Add tasks to the mission
 *
 * Task are defined similar to briefing entries. The function accepts an array as input.
 * Each entry is either a filter (see FHQ_fnc_ttAddBriefing), or a task description.
 *
 * A task description itself is an array and can be one of the following format:
 * [_taskName, _longDescription, _shortDescription, _waypointDescription, _target, _initialState]
 * [[_taskName, _parentTask], _longDescription, _shortDescription, _waypointDescription, _target, _initialState]
 *
 * Both _target and _initialState are optional and can be left out.
 *
 * o _taskName is a symbolic name that is invisible to the player.
 * o _longDescription is a text describing the task.
 * o _shortDescription is used as a headline for the task in the task list and on task hints
 * o _waypointDescription is displayed on the waypoint on the map and in the 3d view (if enabled).
 * o _target can be a position (three-element array) or an object. If either is given, the
 *   task waypoint is shown on the map an the 3d view. Objects that move also move
 *   the waypoint marker.
 * o _initialState is the initial state of the task ("succeeded", "failed", "canceled",
 *      "created", or "assigned"). By default, if _initialState is ommited, the state is set
 *   to "created". If set to "assigned", the task is also automatically assigned to everyone
 *   that knows about it.
 *
 * Example:
 *
 * [
 *     west,
 *         ["taskBoard1", "Board your chopper", "Board your chopper", "BOARD", westHelo1, "assigned"],
 *         ["taskCAS", "Fly around", "Fly around", "CAS"],
 *         ["taskRetreat1", "Return to LZ", "Return to LZ", "RETREAT", getMarkerPos "markLZ"],
 *     "BLU_G_F",
 *           ["taskSecret", "Secret: Betray NATO for whatever reason", "Secret: Betray NATO", ""],
 *         [["taskSecret1", "taskSecret"], "Because they are idiots", "Idiots", ""],
 *         [["taskSecret2", "taskSecret"], "Because I am evil", "Evil", ""]
 * ] call FHQ_fnc_ttAddTasks;
 *
 * The first three tasks are assigned at all playable west units. The second bunch of three tasks is
 * only assigned to FIA units. The latter two, taskSecret1 and taskSecret2 are created as subtasks
 * of the task "taskSecret" and will be displayed immediately below their respective parent.
 *
 * NOTE: This function can only be called on the server. Calling it anywhere else will have no effect.
 */

private _currentFilter = {true};

if (isServer) then {
    /* Note: Server only code. Briefing entries must be added on the server, not on an
     * individual client
     */
    private _i = 0;
       for [{_i = 0}, {_i < count _this}, {_i = _i + 1}] do {

          private _current = _this select _i;
        if (_current call FHQ_fnc_ttiIsFilter) then {
            /* Must be a filter */
            _currentFilter = nil;
            _currentFilter = _current;
        } else {
            /* Task entry.
             * Check if the task already exists. If not, construct a full
             * task entry with all redundant information filled in for easier
             * access later on
             */
               private _name = _current call FHQ_fnc_ttiGetTaskName;
            if (([FHQ_TTI_TaskList, _name] call FHQ_fnc_ttiTaskExists) == -1) then {
                private _newTask =
                           [_current call FHQ_fnc_ttiGetTaskId,
                            _current call FHQ_fnc_ttiGetTaskDesc,
                            _current call FHQ_fnc_ttiGetTaskTitle,
                            _current call FHQ_fnc_ttiGetTaskWp,
                            _current call FHQ_fnc_ttiGetTaskTarget,
                            _current call FHQ_fnc_ttiGetTaskState,
                            _current call FHQ_fnc_ttiGetTaskType];
                FHQ_TTI_TaskList = FHQ_TTI_TaskList + [[_currentFilter, _newTask]];
            };
        };
    };


    publicVariable "FHQ_TTI_TaskList";
    if (!isDedicated) then {
           FHQ_TTI_TaskList call FHQ_fnc_ttiUpdateTaskList;
      };

       FHQ_TTI_tasks = true;
       publicVariable "FHQ_TTI_tasks";
};
