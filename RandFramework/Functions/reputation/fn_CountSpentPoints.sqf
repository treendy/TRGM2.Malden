
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
_SpentCount = 0;
{
   if ((side _x) == West) then
   {
   		//_SpawnedUnit setVariable ["RepCost", 1];
   		_var = _x getVariable "RepCost";
   		if (!(isNil "_var")) then {
   			_SpentCount = _SpentCount + _var;
   		};
   };
} forEach allUnits;
_SpentCount