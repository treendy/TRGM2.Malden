private _tasks = _this;
private _i = 0;

{
    private _list = [];
   	for [{_i = 0}, {_i < count _tasks}, {_i = _i + 1}] do {
        private _current = _tasks select _i;		// [_filter, [_section, _subject, _text]]

        private _filter = _current select 0;
       	private _units = [_filter] call FHQ_fnc_ttiFilterUnits;
            
	    if (_x in _units) then {
        	_list = _list + [_current select 1];
        };
    };
        
    /* Now add them in reverse order */
    private _existing = _x getVariable ["FHQ_TTI_ClientTaskList", []];
    if (FHQ_TTI_is_arma3) then {
       	for [{_i = 0}, {_i < count _list}, {_i = _i + 1}] do {

           	private _current = _list select _i;
            
           	_existing = [_current, _existing, _x] call FHQ_fnc_ttiCreateOrUpdateTask;
		}; 
	} else {
        for [{_i = count _list - 1}, {_i >= 0}, {_i = _i - 1}] do {
	        private ["_current", "_task", "_name"];
           	private _current = _list select _i;
                                                    
            /* Check for a parent task. Since we add them reversed in Arma 2, we need
             * to check if a parent task is "below" us
             */
            private _task = _current call FHQ_fnc_ttiGetTaskId;
            if (typename _task == "ARRAY") then {
                /* It's a task with parent */
                private _name = _task select 1;
           		private _idx = [_existing, _name] call FHQ_fnc_ttiTaskExists; 
                if (_idx == -1) then {
                    /* Doesn't exist... so go through it and create the task now */
                    private ["_j"];
                    for "_j" from 0 to count _list - 1 do {
                        private ["_entry", "_checkName"];
                        _entry = _list select _j;
                        _checkName = _entry call FHQ_fnc_ttiGetTaskName;
                        if (_checkName == _name) exitWith {
                            _existing = [_entry, _existing, _x] call FHQ_fnc_ttiCreateOrUpdateTask; 
                        };
                    };
                };
            };

            _existing = [_current, _existing, _x] call FHQ_fnc_ttiCreateOrUpdateTask;
		};
    };
        
    _x setVariable ["FHQ_TTI_ClientTaskList", _existing];
        
} foreach (if (isMultiplayer) then {playableUnits} else {switchableUnits});