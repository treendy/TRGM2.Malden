_spentCount = {(side _x) == West && !(isNil {_x getVariable "RepCost"})} count allUnits;

_spentCount;