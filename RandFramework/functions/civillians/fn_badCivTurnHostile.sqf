// Server side: arm the civ, put him on the enemy side and optionally open fire on a target
params ["_badCiv",["_target",objNull]];

if (!isServer) exitWith {
	_this remoteExec ["TRGM_fnc_badCivTurnHostile", 2];
};
//arm and switch side only once (the search action and the watch loop can both get here)
if (!(_badCiv getVariable ["isHostile",false])) then {
	_badCiv setVariable ["isHostile",true,true];

	_grpName = createGroup east;
	[_badCiv] joinSilent _grpName;

	[_badCiv] call TRGM_fnc_badCivApplyAssingnedArmament;

	_badCiv allowFleeing 0;

	//remove search Civ action
	[_badCiv] remoteExec ["TRGM_fnc_badCivRemoveSearchAction",[0, -2] select isMultiplayer,true];
};

if (!isNull _target) then {
	_badCiv doTarget _target;
	_badCiv commandFire _target;

	_gun = handgunWeapon _badCiv;

	sleep 3;
	_badCiv fire _gun;
	sleep 1;
	_badCiv fire _gun;
	sleep 1;
	_badCiv fire _gun;
};
