
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
if (isNil "TRGM_VAR_SpawnedVehicles") then {TRGM_VAR_SpawnedVehicles = []; publicVariable "TRGM_VAR_SpawnedVehicles";};
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
} forEach allUnits + TRGM_VAR_SpawnedVehicles;
_SpentCount