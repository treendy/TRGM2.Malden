_SpentCount = 0;
{
   if ((side _x) == West) then
   {
   		_var = _x getVariable "RepCost";
   		if (!(isNil "_var")) then {
   			_SpentCount = _SpentCount + _var;
   		};   		
   };
} forEach allUnits;
_SpentCount