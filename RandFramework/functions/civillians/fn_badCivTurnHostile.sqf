params ["_badCiv"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_grpName = createGroup east;
[_badCiv] joinSilent _grpName;

[_badCiv] call TREND_fnc_badCivApplyAssingnedArmament;

_badCiv allowFleeing 0;

//remove search Civ action
[_badCiv] remoteExec ["TREND_fnc_badCivRemoveSearchAction",[0, -2] select isMultiplayer,true];


true;