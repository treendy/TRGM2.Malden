if(!hasInterface) exitWith {};

params ["_thisCiv"];

_actionID = _thisCiv addaction [localize "STR_TRGM2_civillians_fnbadCivAddSearchAction_Button",TRGM_fnc_badCivSearch, nil,1.5,true,true,"","true",5];
_thisCiv setVariable ["searchActionID",_actionID];