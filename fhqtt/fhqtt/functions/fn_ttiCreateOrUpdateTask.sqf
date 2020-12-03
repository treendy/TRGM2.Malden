private ["_current", "_existing", "_unit", "_name", "_state", "_idx", "_record", "_object", "_taskID",
    			"_parented"];
    
_current = [_this, 0] call BIS_fnc_param;
_existing = [_this, 1] call BIS_fnc_param;
_unit = [_this, 2] call BIS_fnc_param;
    
_name = _current call FHQ_fnc_ttiGetTaskName;
_state = _current call FHQ_fnc_ttiGetTaskState;
_parented = false;
            
_idx = [_existing, _name] call FHQ_fnc_ttiTaskExists; 
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
			[_current call FHQ_fnc_ttiGetTaskTitle, _state] call FHQ_fnc_ttTaskHint;
		};
                    
        /* Update the list */
        _existing set [_idx, _record];
	}; 
} else {
	_taskID = _current call FHQ_fnc_ttiGetTaskId;
    
    if (typename _taskID == "STRING") then {            
		_object = _unit createSimpleTask [_name];
    } else {
        _object = _unit createSimpleTask [_name, _unit getVariable format["FHQ_TT_taskname_%1", _taskID select 1]];
        _parented = true;
	};

	if (!FHQ_TTI_is_arma3 && _parented) then {         
		_object setSimpleTaskDescription [_current call FHQ_fnc_ttiGetTaskDesc, 
							  	  format ["%2%1", _current call FHQ_fnc_ttiGetTaskTitle, FHQ_TT_subtaskPrefix], 
                                  _current call FHQ_fnc_ttiGetTaskWp];
	} else { 	
		_object setSimpleTaskDescription [_current call FHQ_fnc_ttiGetTaskDesc, 
       							  	      _current call FHQ_fnc_ttiGetTaskTitle, 
                                          _current call FHQ_fnc_ttiGetTaskWp];
	};
	_target = _current call FHQ_fnc_ttiGetTaskTarget;

    switch (typename _target) do
    {
       	case "ARRAY": {
           	_object setSimpleTaskDestination _target;
		};
		case "OBJECT": {
			_object setSimpleTaskTarget [_target, true];
		};
	};
    
    private _taskType = _current call FHQ_fnc_ttiGetTaskType;

    if (_taskType != "" && FHQ_TTI_version > 156) then {
        [_object, _taskType] call compile "(_this select 0) setSimpleTaskType (_this select 1);"
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
		[_current call FHQ_fnc_ttiGetTaskTitle, _state] call FHQ_fnc_ttTaskHint;
	}; 
               
	_existing = _existing + [ [_state, _object, _name] ];
};
    
_existing;