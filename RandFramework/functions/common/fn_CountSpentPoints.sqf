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