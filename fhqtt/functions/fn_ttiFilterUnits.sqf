/* Internal function */

private ["_unitsArray", "_outputArray"];
    
_filter = [_this, 0] call BIS_fnc_param;
_unitsArray = [_this, 1, (if (isMultiplayer) then {playableUnits} else {switchableUnits})] call BIS_fnc_param; 

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
       	_outputArray = [_filter];
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
    case "ARRAY":
    {
        // Result is the input
        _outputArray = _filter;
    }
};
    
_outputArray;
