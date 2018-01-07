if(!hasInterface) exitWith {};

params ["_thisCiv"];

_actionID = _thisCiv addaction ["Search Civ",TRGM_fnc_badCivSearch, nil,1.5,true,true,"","alive _target",5];
_thisCiv setVariable ["searchActionID",_actionID];