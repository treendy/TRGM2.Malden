params ["_badCiv"];

_grpName = createGroup east;
[_badCiv] joinSilent _grpName;

[_badCiv] call TREND_fnc_badCivApplyAssingnedArmament;

_badCiv allowFleeing 0;

//remove search Civ action
[_badCiv] remoteExec ["TREND_fnc_badCivRemoveSearchAction",[0, -2] select isMultiplayer,true];


true;