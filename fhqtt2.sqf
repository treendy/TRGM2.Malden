
/* FHQ TaskTracker for the FHQ Multiplayer framework
 * 
 * This scriptset is used to create briefings and tasks, and keep track of
 * task states.
 * 
 * In general, briefings and tasks can be created for individual players, for
 * groups of players, and specific to the side or faction of the player.
 * 
 * Unit filters:
 * Whenever a unit filter is asked for, there are several possibilities to 
 * define what you need to assign to:
 * single object: A single player
 * group: All players of a group
 * side: All players of a side
 * faction (string): All players of a certain faction
 * code: The piece of code is called for every playable character. Return true if you want
 *       the character to be selected, or false otherwise. The only parameter is the playable 
 * 		 object to be tested
 *  
 * Examples:
 *  {(side _this) != west): All playable characters that are not BLUFOR
 *  player: the player on the current client
 *  group westMan1_1: All units in westMan1_1's group
 * 	east: All playable characters on the OPFOR side
 *  "BIS_BAF": All playable british soliders
 * 
 * 
 * 
 * Commonly used examples:
 * 
 * 1. Assign a task as current task:
 * ["taskDestroy", "assigned"] call FHQ_TTI_setTaskState;
 * 
 * 
 * 2. Check if a task is completed (Note, might be successful, failed or cancelled)
 * if (["taskInsert"] call FHQ_TTI_isTaskCompleted) then {hint "yes";};
 * 
 * 
 * 3. Check if a task is successful
 * if (["taskDestroy"] call FHQ_TTI_isTaskSuccessful) then {hint "yay";};
 * 
 * 
 * 4. Mark a task and select another task that is not completed yet.
 * ["taskDestroySecondary", "succeeded", "taskDestroyPrimary", "taskDestroySecondary", "taskExfiltrate"] 
 * 			call FHQ_TTI_markTaskAndNext;
 * 
 * This example marks taskDestroySecondary as succesful, and then checks if taskDestroyPrimary is completed.
 * If not, it is set to assigned. If it is completed, it continues with the taskDestroySecondary and eventually
 * taskExfiltrate. 
 * 
 * New briefing entries are shwon as task hints. By default, it uses the TaskAssigned notification, 
 * but in Arma 3 it is possible to override this by adding this to your descroiption.ext:
 * 
 * class CfgNotifications
 * {
 *     class NewBriefing
 *	   {
 *		   title = "BRIEFING UPDATED";
 *		   iconPicture = "\a3\ui_f\data\IGUI\Cfg\Actions\talk_ca.paa";
 *		   description = "%2";
 *		   priority = 7;
 *     };
 * };
 * 
 * 
 * TODO: Add possibility to change waypoint position
 */
FHQ_TTI_init =
{
    FHQ_TTI_supressTaskHints = true;
    
    /* Check for Arma 3 or 2 */
	FHQ_TTI_is_arma3 = false;

	if (isClass (configfile >> "CfgAddons" >> "PreloadAddons" >> "A3")) then {
	    FHQ_TTI_is_arma3 = true;
	};

	if (isServer) then
    {
        /* Format for briefing list:
         * [_filter, [_section, _subject, _text]]
         * Briefing is sent to all players at mission start, and JIP players when they connect.
         */
		FHQ_TTI_BriefingList = [];
        
        /* Format for task list:
         * [_filter, [_taskName|[_taskName, _parent], _description, _title, _waypoint, _destination|_target, _state]]
         */
    	FHQ_TTI_TaskList = [];
	};
     
	if (!isDedicated) then
	{
		/* This is the client's task list:
         * [_taskName, _state, _objects] 
         */
        FHQ_TTI_ClientTaskList = [];

        if (isNil {player} || isNull player) then
        {
            FHQ_TTI_isJIPPlayer = true;
        };
         
        [] spawn 
        {
            // Wait for join in progress
	       	waitUntil {!isNil {player}};
        	waitUntil {!isNull player};
            
            // Wait until briefing is ready (on server)
            waitUntil {!isNil "FHQ_TTI_briefing"};
            FHQ_TTI_BriefingList call FHQ_TTI_UpdateBriefingList;
            
           	// Wait until the task list is ready (on server)
         	waitUntil {!isNil "FHQ_TTI_tasks"};
			FHQ_TTI_TaskList call FHQ_TTI_UpdateTaskList;

			FHQ_TTI_supressTaskHints = false;
			"FHQ_TTI_TaskList" addPublicVariableEventHandler {(_this select 1) call FHQ_TTI_UpdateTaskList};
			"FHQ_TTI_BriefingList" addPublicVariableEventHandler {_this select 1 call FHQ_TTI_UpdateBriefingList}; 
		};
    };
};


FHQ_TTI_filterUnits =
{
    private ["_unitsArray", "_inputArray", "_outputArray"];
    
    _filter = _this select 0; 
   	_unitsArray = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
    if (count _this > 1) then {
        _unitsArray = _this select 1;
    };

	_outputArray = [];
    
    switch (typename _filter) do
    {
        case "CODE":
        {
            // Filter all playable units by comparing them with the code
            {if (_x call _filter) then {_outputArray = _outputArray + [_x];};} forEach _unitsArray;
        };
        case "GROUP":
        {
            // Filter out all objects not in group
            {if (_x in units _filter) then {_outputArray = _outputArray + [_x];};} forEach _unitsArray;
        };
        case "OBJECT":
        {
            // Result is only the array containing the object
          	_outputArray = [_inputArray];
        };
        case "SIDE":
        {
            // Filter out all objects not belonging to side
            {if (side _x == _filter) then {_outputArray = _outputArray + [_x];};} forEach _unitsArray;
        };
        case "STRING":
        {
            // Filer out all objects not belonging to the faction
            {if (faction _x == _filter) then {_outputArray = _outputArray + [_x];};} forEach _unitsArray;
        };
	};
    
	_outputArray;
};


FHQ_TT_taskHint =
{
    if (!FHQ_TTI_is_arma3) then 
    {
        /* Arma 2 */
    	private ["_desc", "_state", "_color", "_icon", "_text"];
    
	    _desc = _this select 0;
	    _state = _this select 1;
    
		_color = [1, 1, 1, 1];
		_icon = "taskNew";
		_text = "New Task";

		switch (tolower(_state)) do
		{
			case "created":
			{
				_color = [1, 1, 1, 1];
				_icon = "taskNew";
				_text = localize "str_taskNew";
			};
			case "assigned":
			{
				_color = [1, 1, 1, 1];
				_icon = "taskCurrent";
			 	_text = localize "str_taskSetCurrent";
			};
			case "succeeded":
			{
				_color = [0.600000,0.839215,0.466666,1];
				_icon = "taskDone";
				_text = localize "str_taskAccomplished";
			};
			case "canceled":
			{
				_color = [0.75,0.75,0.75,1];
				_icon = "taskFailed";
				_text = localize "str_taskCancelled";
			};
			case "cancelled":
			{
				_color = [0.75,0.75,0.75,1];
				_icon = "taskFailed";
				_text = localize "str_taskCancelled";
			};
			case "failed":
			{
				_color = [0.972549,0.121568,0,1];
				_icon = "taskFailed";
				_text = localize "str_taskFailed";
			};
            case "newbriefing":
			{
				_color = [1, 1, 1, 1];
				_icon = "taskCurrent";
			 	_text = "Briefing updated";//localize "str_taskSetCurrent";
			};
		};
    
	    taskHint [format ["%1\n%2", _text, _desc], _color, _icon];
	}
    else
    {
        /* Arma 3 */
        private ["_notifyTemplate", "_desc", "_state"];
        
        _desc = _this select 0;
	    _state = _this select 1;
        
        switch (tolower _state) do 
        {
			case "created":
            {
                _notifyTemplate = "TaskCreated";
            };
			case "assigned":
            {
                _notifyTemplate = "TaskAssigned";
            };
			case "succeeded":
            {
                _notifyTemplate = "TaskSucceeded";
            };
			case "canceled":
            {
                _notifyTemplate = "TaskCanceled";
            };
			case "cancelled":
            {
                _notifyTemplate = "TaskCanceled";
            };
			case "failed":
            {
                _notifyTemplate = "TaskFailed";
            };
            case "newbriefing":
            {
                _notifyTemplate = "TaskAssigned";
                if (isClass (missionConfigFile >> "CfgNotifications" >> "NewBriefing")) then {
                    _notifyTemplate = "NewBriefing";
                };
            };
		};
        
        [_notifyTemplate, ["", _desc]] call BIS_fnc_showNotification;
	};
};



FHQ_TTI_getBriefingSubject = 
{
    private "_subject";
    
    _subject = "Diary";
    
    if (count _this == 3) then {
        _subject = _this select 0;
    };
    
     _subject;
}; 

FHQ_TTI_getBriefingTopic = 
{
    private "_topic";
    
    _topic = _this select 0;
    
	if (count _this == 3) then {
        _topic = _this select 1;
    };
    
    _topic;
};

FHQ_TTI_getBriefingText = 
{
    private "_text";
    
    _text = _this select 1;
    if (count _this == 3) then {
        _text = _this select 2;
    };
    
    _text;
};

    
/* Internal: Add a briefing record on the server
 * parameters:
 * select 0: Filter
 * select 1: [_section, _subject, _text]
 */

FHQ_TTI_addBriefingEntry =
{
    private "_record";
    _record = _this select 1;

	FHQ_TTI_BriefingList = FHQ_TTI_BriefingList + 
    	[[_this select 0,
         [_record call FHQ_TTI_getBriefingSubject,
         _record call FHQ_TTI_getBriefingTopic,
         _record call FHQ_TTI_getBriefingText]]];
};
       


/* Intenral: Check if the briefing entry exists in the list */
FHQ_TTI_hasBriefingEntry = 
{
    private ["_x", "_res", "_test", "_inArray"];
    _res = false;
    
//    if ((_this select 1) in (_this select 0)) then {
//        _res = true;
//    };

	_inArray = _this select 1;
     
	{
       	if (_x select 0 == _inArray select 0 && ((_x select 1) select 0) == ((_inArray select 1) select 0) 
          && ((_x select 1) select 1) == ((_inArray select 1) select 1)) exitWith {
              _res = true;
        };
    } foreach (_this select 0);
    
    _res; 
};
    
/* Internal: Update a client's briefing entries.
 * Note that existing entries can not be changed, so it basically just adds any new
 * entries to the briefing. 
 */
FHQ_TTI_UpdateBriefingList =
{
    private ["_i", "_idx", "_current", "_record", "_filter", "_units", "_x", "_briefing", "_list", "_existing", "_notify"];
    
    _briefing = _this;
    _notify = false;
    
    {
        _list = [];
    	for [{_i = 0}, {_i < count _briefing}, {_i = _i + 1}] do {
	        _current = _briefing select _i;		// [_filter, [_section, _subject, _text]]

	        _filter = _current select 0;
        	_units = [_filter] call FHQ_TTI_filterUnits;
            
	        if (_x in _units) then {
				_record = _current select 1;
        		_list = _list + [[_record select 0, [_record select 1, _record select 2]]];
           	};
        };
        
        /* Now add them in reverse order */
        _existing = _x getVariable ["FHQ_TTI_ClientBriefingList", []];
		for [{_i = count _list - 1}, {_i >= 0}, {_i = _i - 1}] do {
            _current = _list select _i;
            
            if (!([_existing, _current] call FHQ_TTI_hasBriefingEntry)) then {
				/* Check if the section exists and create it if necessary, then add the record */
       			if (!(_x diarySubjectExists (_current select 0))) then {
       					_x createDiarySubject [_current select 0, _current select 0];
        		};
           
           		diag_log format ["%3: diary record >%1<, >%2<", _current select 0, (_current select 1) select 0, str _x];
	        	_x createDiaryRecord [_current select 0, [(_current select 1) select 0, (_current select 1) select 1]];
                
                if (player == _x  && !FHQ_TTI_supressTaskHints) then
        		{
                    private "_title";
                    _title = _current select 0;
                    if (_title == "Diary") then {
                        if (FHQ_TTI_is_arma3) then {
                        	_title = "Briefing";
                        } else {
                            _title = "Notes";
                        };
                    };
					[format ["%1/%2", _title, (_current select 1) select 0], "newbriefing"] call FHQ_TT_taskHint;
				};
			};                
		};
        _x setVariable ["FHQ_TTI_ClientBriefingList", _list];  // FIXME ? 
	} foreach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
};


/* Task record internal representation:
 * [_taskName|[_taskName, _parent], _description, _title, _waypoint, _destination|_target, _state]
 * select        0                       1           2          3                4            5
 */

#define FHQ_TTIF_TASKNAME	0
#define FHQ_TTIF_TASKDESC	1
#define FHQ_TTIF_TASKTITLE	2
#define FHQ_TTIF_TASKWP		3
#define FHQ_TTIF_TASKTARGET	4
#define FHQ_TTIF_TASKSTATE	5

/* Internal: "Accessor" functions
 * Input: Task record
 */
 
FHQ_TTI_getTaskId =
{
 	_res = _this select FHQ_TTIF_TASKNAME;
    _res;
};


FHQ_TTI_getTaskDesc =
{
    _res = _this select FHQ_TTIF_TASKDESC;
    _res;
};


FHQ_TTI_getTaskTitle =
{
    _res = _this select FHQ_TTIF_TASKTITLE;
    _res;
};


FHQ_TTI_getTaskWp =
{
    _res = _this select FHQ_TTIF_TASKWP;
    _res;
};


FHQ_TTI_getTaskTarget =
{
    /* Might not be present */
    _res = "";
    
    if (count _this > FHQ_TTIF_TASKTARGET) then {
        _thing = _this select FHQ_TTIF_TASKTARGET;
        /* A string means it's the initial state, so if it's not, it's either
         * a position (array) or target (object)
         */
        switch (typename _thing) do {
        	case "ARRAY": {
            	_res = nil;
                _res = _thing;
            };
            case "OBJECT": {
                _res = nil;
                _res = _thing;
            };
       	};
	};
    
    _res;                
};


FHQ_TTI_getTaskState =
{
    /* Might not be present */
    _res = "created";
    
    if (count _this > FHQ_TTIF_TASKSTATE) then {
        _res = _this select FHQ_TTIF_TASKSTATE;
    } else {
        if (count _this > FHQ_TTIF_TASKTARGET) then {
            if (typename (_this select FHQ_TTIF_TASKTARGET) == "STRING") then {
                _res = _this select FHQ_TTIF_TASKTARGET;
            };
        };
    };
    
    _res;
};


/* Internal: Check if we have that task already. 
 * Input: _taskList, _name
 */ 

FHQ_TTI_taskExists =
{
    private ["_unitTaskList", "_name", "_res", "_current", "_i", "_checkName"];
    _unitTaskList = _this select 0;
    _name = _this select 1;
    
    _res = -1;
    for "_i" from 0 to count _unitTaskList - 1 do
    {
        _current = _unitTaskList select _i;
        
        if (count _current == 2) then {
     		_checkName = (_current select 1) call FHQ_TTI_getTaskName;	// Server list
		} else {
            _checkName = (_current select 2);							// Client list
        };
        if (_checkName == _name) exitWith {
            _res = _i;
        };
    } foreach _unitTaskList;
    
    _res;
};

FHQ_TTI_getTaskName =
{
	private ["_task", "_name"];

    _task = _this select FHQ_TTIF_TASKNAME;
	if (typename _task == "ARRAY") then 
    {
    	_name = _task select 0;
	}
	else
	{
		_name = _task;
	};
    
    _name;
};


/* Internal: Add a task description to the server's list.
 * _this select 0: filter
 * _this select 1: record
 */
FHQ_TTI_addTaskEntry =
{
    FHQ_TTI_TaskList = FHQ_TTI_TaskList + [_this]; 
};


FHQ_TTI_CreateOrUpdateTask = {
    private ["_current", "_existing", "_unit", "_name", "_state", "_idx", "_record", "_object", "_taskID",
    			"_parented"];
    
    _current = _this select 0;
    _existing = _this select 1;
    _unit = _this select 2;
    
	_name = _current call FHQ_TTI_getTaskName;
    _state = _current call FHQ_TTI_getTaskState;
    _parented = false;
            
	_idx = [_existing, _name] call FHQ_TTI_taskExists; 
	if (_idx != -1) then {
    	_record = _existing select _idx;
       	if ((_record select 0) != _state) then {
        	/* Need to set new state */
            _record set [0, _state];
                    
            if (_state == "assigned") then {
                _unit setCurrentTask (_record select 1);
            };
                    
            (_record select 1) setTaskState _state;
                
            if (_unit == player && !FHQ_TTI_supressTaskHints) then
            {
				[_current call FHQ_TTI_getTaskTitle, _state] call FHQ_TT_taskHint;
			};
                    
            /* Update the list */
            _existing set [_idx, _record];
		}; 
	} 
    else {
		_taskID = _current call FHQ_TTI_getTaskId;
        if (typename _taskID == "STRING") then {            
			_object = _unit createSimpleTask [_name];
        } else {
            _object = _unit createSimpleTask [_name, _unit getVariable format["FHQ_TT_taskname_%1", _taskID select 1]];
            _parented = true;
		};

		if (!FHQ_TTI_is_arma3 && _parented) then {         
			_object setSimpleTaskDescription [_current call FHQ_TTI_getTaskDesc, 
           								  	  format ["%2%1", _current call FHQ_TTI_getTaskTitle, FHQ_TT_subtaskPrefix], 
                                              _current call FHQ_TTI_getTaskWp];
		} else { 	
			_object setSimpleTaskDescription [_current call FHQ_TTI_getTaskDesc, 
           							  	      _current call FHQ_TTI_getTaskTitle, 
                                              _current call FHQ_TTI_getTaskWp];
		};
		_target = _current call FHQ_TTI_getTaskTarget;

        switch (typename _target) do
        {
        	case "ARRAY": {
            	_object setSimpleTaskDestination _target;
			};
			case "OBJECT": {
				_object setSimpleTaskTarget [_target, true];
			};
		};
        
        _target = nil;
                
        _object setTaskState _state;
                
        if (tolower(_state) == "assigned") then
        {
	       	_unit setCurrentTask _object;
        };
                
        _unit setVariable [format["FHQ_TT_taskname_%1", _name], _object]; // FIXME: propagate through network ? 
                
        if (_unit == player && !FHQ_TTI_supressTaskHints) then
        {
			[_current call FHQ_TTI_getTaskTitle, _state] call FHQ_TT_taskHint;
		}; 
               
		_existing = _existing + [ [_state, _object, _name] ];
	};
    
    _existing;
};

FHQ_TTI_UpdateTaskList = 
{
    _tasks = _this;
    
    {
        _list = [];
    	for [{_i = 0}, {_i < count _tasks}, {_i = _i + 1}] do {
	        _current = _tasks select _i;		// [_filter, [_section, _subject, _text]]

	        _filter = _current select 0;
        	_units = [_filter] call FHQ_TTI_filterUnits;
            
	        if (_x in _units) then {
				_record = _current select 1;
        		_list = _list + [_current select 1];
           	};
        };
        
        /* Now add them in reverse order */
        _existing = _x getVariable ["FHQ_TTI_ClientTaskList", []];
        if (FHQ_TTI_is_arma3) then {
        	for [{_i = 0}, {_i < count _list}, {_i = _i + 1}] do {
	            private ["_current"];
            
            	_current = _list select _i;
            
            	_existing = [_current, _existing, _x] call FHQ_TTI_CreateOrUpdateTask;
			}; 
		} 
        else {
             for [{_i = count _list - 1}, {_i >= 0}, {_i = _i - 1}] do {
	            private ["_current", "_task", "_name"];
            	_current = _list select _i;
                                                    
                /* Check for a parent task. Since we add them reversed in Arma 2, we need
                 * to check if a parent task is "below" us
                 */
                _task = _current call FHQ_TTI_getTaskId;
                if (typename _task == "ARRAY") then {
                    /* It's a task with parent */
                    _name = _task select 1;
            		_idx = [_existing, _name] call FHQ_TTI_taskExists; 
                    if (_idx == -1) then {
                        /* Doesn't exist... so go through it and create the task now */
                        private ["_j"];
                        for "_j" from 0 to count _list - 1 do {
                            private ["_entry", "_checkName"];
                            _entry = _list select _j;
                            _checkName = _entry call FHQ_TTI_getTaskName;
                            if (_checkName == _name) exitWith {
                                _existing = [_entry, _existing, _x] call FHQ_TTI_CreateOrUpdateTask; 
                            };
                        };
                    };
                };

            	_existing = [_current, _existing, _x] call FHQ_TTI_CreateOrUpdateTask;
			};
        };
        
        _x setVariable ["FHQ_TTI_ClientTaskList", _existing];
        
	} foreach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
};

/* ---------------------------- Exported functions folow ---------------------------- */


/* FHQ_TT_addBriefing: Add a full briefing 
 * 
 * This functions receives an array as input. The elements of the input array
 * are interpreted as follows:
 * If the element is a two-element array consisting of two strings, the entry is 
 * interpreted as a new briefing topic. If the array has three strings, it's interpreted
 * as a new briefing entry, with the first one being the general subject ("Diary" by default),
 * and the two subsequent strings title and description.
 * If the element is anything else, the following topics will only be presented to 
 * the units matching the element. For example, if the element is a group, the following
 * entries are added to this group only.
 * 
 * NOTE: The old hierarchical filtering is no longer supported. It wasn't that useful for 
 * real-world application and was posing severe problems with respawn missions.
 * 
 * Example:
 * 
 * [
 *     west,
 *        ["Mission", "Get some!"],
 *        ["Enemy Forces", "There's lots of ruskies around"],
 *     east,
 *        ["Mission", "Get those imperialistic americans"],
 *        ["Current Supply of Vodka", "Low"],
 *     {true},
 *        ["Credits", "Mission by", "Some Dude"],
 *        ["Credits", "Uses scripts by", "Some other dude<br/>Yet another dude"]
 * ] call FHQ_TT_addBriefing.
 * 
 * The first two lines (Mission, Enemy Forces), are added under "Briefing" for west 
 * troops only, the second two lines (Mission, Current Supply of Vodka) only for east.
 * The last two lines add two new entries "Mission by" and "Uses scripts by" into a new
 * subject "Credits".
 * 
 * NOTE: Do not over-use the additional subject feature. Briefing and all associated information
 * should go to the default subject.
 * 
 * Calling FHQ_TT_addBriefing with an already existing subject/title will add a new log entry
 * if the text differs from the previous one.
 * 
 * Notifications are shown after the initial briefing has been donwloaded by the clients, i.e.
 * not at mission start, only when new briefing entries are added.
 */
 
FHQ_TT_addBriefing =
{
    private ["_currentFilter", "_i", "_current", "_x"];
    _currentFilter = {true};
    
    if (isServer) then {
        /* Note: Server only code. Briefing entries must be added on the server, not on an
         * individual client
         */
         
        for [{_i = 0}, {_i < count _this}, {_i = _i + 1}] do {
		
        	_current = _this select _i;
    		
            if (typename _current == "ARRAY") then {
                /* It's a briefing entry. */
                [_currentFilter, _current] call FHQ_TTI_addBriefingEntry;
            } else {
                /* Must be a filter */
                _currentFilter = nil; 
                _currentFilter = _current;
            };
		};

		publicVariable "FHQ_TTI_BriefingList";
        if (!isDedicated) then {
      		FHQ_TTI_BriefingList call FHQ_TTI_UpdateBriefingList;
    	};
    
    	FHQ_TTI_briefing = true;
    	publicVariable "FHQ_TTI_briefing";
	};    
};


/* FHQ_TT_addTasks: Add tasks to the mission 
 * 
 * Task are defined similar to briefing entries. The function accepts an array as input.
 * Each entry is either a filter (see FHQ_TT_addBriefing), or a task description.
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
 * 	 "created", or "assigned"). By default, if _initialState is ommited, the state is set
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
 *    	   ["taskSecret", "Secret: Betray NATO for whatever reason", "Secret: Betray NATO", ""],
 *         [["taskSecret1", "taskSecret"], "Because they are idiots", "Idiots", ""],
 *         [["taskSecret2", "taskSecret"], "Because I am evil", "Evil", ""]
 * ] call FHQ_TT_addTasks;
 * 
 * The first three tasks are assigned at all playable west units. The second bunch of three tasks is
 * only assigned to FIA units. The latter two, taskSecret1 and taskSecret2 are created as subtasks
 * of the task "taskSecret" and will be displayed immediately below their respective parent.
 *
 * NOTE: This function can only be called on the server. Calling it anywhere else will have no effect. 
 */
 
FHQ_TT_addTasks =
{
    private ["_currentFilter", "_i", "_current",  "_newTask"];
    _currentFilter = {true};
    
    if (isServer) then {
        /* Note: Server only code. Briefing entries must be added on the server, not on an
         * individual client
         */
         
    	for [{_i = 0}, {_i < count _this}, {_i = _i + 1}] do {
		
        	_current = _this select _i;
            if (typename _current != "ARRAY") then {
                /* Must be a filter */
                _currentFilter = nil; 
                _currentFilter = _current;
			} else {
                /* Task entry. 
                 * Check if the task already exists. If not, construct a full 
                 * task entry with all redundant information filled in for easier 
                 * access later on
                 */
               	_name = _current call FHQ_TTI_getTaskName;
                if (([FHQ_TTI_TaskList, _name] call FHQ_TTI_taskExists) == -1) then {
                    _newTask = [_current call FHQ_TTI_getTaskId,
                                _current call FHQ_TTI_getTaskDesc,
                                _current call FHQ_TTI_getTaskTitle,
                                _current call FHQ_TTI_getTaskWp,
                                _current call FHQ_TTI_getTaskTarget,
                                _current call FHQ_TTI_getTaskState];
					[_currentFilter, _newTask] call FHQ_TTI_addTaskEntry;
				};
			};
        };
        
        
        publicVariable "FHQ_TTI_TaskList";
        if (!isDedicated) then {
      		FHQ_TTI_TaskList call FHQ_TTI_UpdateTaskList;
    	};
    
    	FHQ_TTI_tasks = true;
    	publicVariable "FHQ_TTI_tasks";
    };
};


/* FHQ_TT_setTaskState
 * 
 * Set the state of the specified task to the specified state, and alert the player
 * if necessary. 
 * 
 * NOTE: Server callable only. Calling this on a client does not have an effect
 * 
 * Usage:
 * [_task, _state] call FHQ_TT_setTaskState;
 * _task: the task name defined with FHQ_TT_addTasks
 * _state: One of "succeeded", "failed", "canceled", "created", "assigned"
 * 
 */
FHQ_TT_setTaskState =
{
    private ["_name", "_state", "_idx", "_record", "_entry"];
    
    if (isServer) then {
        _name = _this select 0;
        _state = _this select 1;
        
 		_idx = [FHQ_TTI_TaskList, _name] call FHQ_TTI_taskExists;
        if (_idx != -1) then {
            _entry = FHQ_TTI_TaskList select _idx;
            _record = _entry select 1;
            
            _record set [FHQ_TTIF_TASKSTATE, _state];
            _entry set [1, _record];
            FHQ_TTI_TaskList set [_idx, _entry];
       
       		publicVariable "FHQ_TTI_TaskList";
        	if (!isDedicated) then {
      			FHQ_TTI_TaskList call FHQ_TTI_UpdateTaskList;
    		};
		};
    };
};


/* FHQ_TT_getTaskState
 * 
 * Get the state of a given task. This function can be called on the client as well as
 * the server.
 * 
 * Usage:
 * _state = [_task] call FHQ_TT_getTaskState;
 * 
 * _task: The name of a task defined via FHQ_TT_addTask
 * 
 * Returns the state of the task ("succeeded", "failed", "canceled", "created", "assigned"), or an empty
 * string if the task does not exist
 */
FHQ_TT_getTaskState =
{
    private ["_res", "_name", "_idx", "_entry"];
    _res = "";
    
    _name = _this select 0;
          
 	_idx = [FHQ_TTI_TaskList, _name] call FHQ_TTI_taskExists;
    if (_idx != -1) then {
        _entry = FHQ_TTI_TaskList select _idx;
        _res = (_entry select 1) select FHQ_TTIF_TASKSTATE;
    };
    
    _res;
 };
 
/* FHQ_TT_isTaskCompleted
 * 
 * Check whether a task is canceled, successful or failed. Like all query functions, this can be called
 * on any client as well as the server.
 * 
 * _result = [_task] call FHQ_TT_isTaskCompleted;
 * 
 * _task: Name of the task.
 * 
 * Returns true or false if the task's state is considered a "completed" state, i.e.
 * succeeded, canceled, or failed
 * 
 */
FHQ_TT_isTaskCompleted =
{
    private "_result";

    _result = (tolower(_this call FHQ_TT_getTaskState) in ["succeeded", "canceled", "failed"]);
    
    _result;    
};


/* FHQ_TT_areTasksCompleted
 * 
 * Check for all tasks given whether they are considered completed. This function can 
 * be called on the client as well as the server.
 * 
 * Usage
 * _result = [_taskName1, _taskName2, ...] call FHQ_TT_areTasksCompleted
 * 
 * _taskName1 and following: Task names that are tested for being completed. If any of them is not
 * completed, the function returns false, else true.
 */
FHQ_TT_areTasksCompleted =
{
    private ["_result", "_x"];
    
    _result = true;
    
     {
         if (!(tolower ([_x] call FHQ_TT_getTaskState) in ["succeeded", "canceled", "failed"])) exitWith 
         {
             _result = false;
         };
     } forEach _this;
     
     _result;
};


/* FHQ_TT_isTaskSuccessful
 * 
 * Check whether a task is ended successfully. This function can be called on the client as well as
 * the server.
 * 
 * _result = [_taskName] call FHQ_TT_isTaskSuccessful;
 */
FHQ_TT_isTaskSuccessful = 
{
    private "_result";
    
    _result = (tolower(_this call FHQ_TT_getTaskState) == "succeeded");
    
    _result;
};

/* FHQ_TT_areTasksSuccessful
 * 
 * Check success for all tasks given.  This function can be called on the client as well as
 * the server.
 * 
 * _result = [_taskName1, _taskName2, ...] call FHQ_TT_areTasksSuccessful
 */
FHQ_TT_areTasksSuccessful =
{
    private ["_result", "_x"];
    
    _result = true;
    
     {
         if (tolower ([_x] call FHQ_TT_getTaskState) != "succeeded") exitWith 
         {
             _result = false;
         };
     } forEach _this;

     _result;
};

 
/* FHQ_TT_getAllTasksWithState
 * 
 * Get all tasks with a given state. This function can be called on the client as well as
 * the server.
 * 
 * _taskList = [_state] call FHQ_TT_getAllTasksWithState;
 */
FHQ_TT_getAllTasksWithState =
{
    private ["_result", "_taskState"];
    
	_result = [];
    _taskState = _this select 0;
    
    {
        if (((_x select 1) select FHQ_TTIF_TASKSTATE) == _taskState) then
        {
            _result = _result + [(_x select 1) call FHQ_TTI_getTaskName];
        };
    } forEach FHQ_TTI_TaskList;
    
    _result;   	
};

 /* FHQ_TT_setTaskStateAndNext
  * 
  * Set the state of a given task to the given state, and select another task from a list of
  * tasks which is not finished yet. The first task found will be set to assigned and a message will
  * be shown to the player, if enabled.
  * 
  * NOTE: Can only be called on the server
  * 
  * Usage:
  * [_task1, _state, _task2, ...] call FHQ_TT_setTaskStateAndNext;
  * 
  * _task1: The task to set to _state
  * _state: The state for _task1
  * _task2 and following: The tasks are checked in turn for completion, and the first one not
  *   completed will be assigned.
  * 
  * Example:
  * 
  * ["taskGetVodka", "succeeded", "taskDrink", "taskBeMerry"] call FHQ_TT_setTaskStateAndNext;
  */
FHQ_TT_setTaskStateAndNext =
{
    private "_i";
    [_this select 0, _this select 1] call FHQ_TT_setTaskState;
    
    for [ {_i = 2}, {_i < count _this}, {_i = _i + 1} ] do
    {
        if (!([_this select _i] call FHQ_TT_isTaskCompleted)) exitWith
        {
            [_this select _i, "assigned"] call FHQ_TT_setTaskState;
        };
    };
};

FHQ_TT_markTaskAndNext = FHQ_TT_setTaskStateAndNext;

/* Can be overridden in user code */
FHQ_TT_subtaskPrefix = " > ";
      
/* ---------------------------- Init ---------------------------- */
call FHQ_TTI_init;