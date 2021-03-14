
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if (isNil "TREND_SpawnedVehicles") then {TREND_SpawnedVehicles = []; publicVariable "TREND_SpawnedVehicles";};
_SpentCount = 0;
{
   if ((side _x) isEqualTo West) then
   {
   		//_SpawnedUnit setVariable ["RepCost", 1];
   		_var = _x getVariable "RepCost";
   		if (!(isNil "_var")) then {
   			_SpentCount = _SpentCount + _var;
   		};
   };
} forEach allUnits + TREND_SpawnedVehicles;
_SpentCount