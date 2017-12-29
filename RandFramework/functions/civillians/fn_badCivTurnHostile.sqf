params ["_badCiv"];

_grpName = createGroup east;
[_badCiv] joinSilent _grpName;

[_badCiv] call TRGM_fnc_badCivApplyAssingnedArmament;

_badCiv allowFleeing 0;

//remove search Civ action
[_badCiv] remoteExec ["TRGM_fnc_badCivRemoveSearchAction",[0, -2] select isMultiplayer,true];