private ["_unitTaskList", "_name", "_res", "_current", "_i", "_checkName"];
_unitTaskList = [_this, 0] call BIS_fnc_param; 
_name = [_this, 1] call BIS_fnc_param;
    
_res = -1;
for "_i" from 0 to count _unitTaskList - 1 do
{
    _current = _unitTaskList select _i;
        
    if (count _current == 2) then {
  		_checkName = (_current select 1) call FHQ_fnc_ttiGetTaskName;	// Server list
	} else {
        _checkName = (_current select 2);							// Client list
    };
    if (_checkName == _name) exitWith {
        _res = _i;
    };
} foreach _unitTaskList;
    
_res;