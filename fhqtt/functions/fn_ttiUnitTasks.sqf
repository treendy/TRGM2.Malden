/* Eden compatible mission tasks 
 * This function is called like 
 * [_unit, _value] call FHQ_fnc_ttiUnitTasks;
 * 
 * _unit is the unit that should receive the briefing, and _value
 * denotes the briefing itself.
 */
 

private _unit = param [0, objNull];
private _value = param [1, ""];

_unit setVariable ["FHQ_tt_UnitTasks", _value];