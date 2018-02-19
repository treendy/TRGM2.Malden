params ["_badCiv","_player"];

_badCiv disableAI "MOVE"; // disable movement during search

_hintText = selectRandom [localize "STR_TRGM2_civillians_fnbadCivSearch_IsArmed1",localize "STR_TRGM2_civillians_fnbadCivSearch_IsArmed2",localize "STR_TRGM2_civillians_fnbadCivSearch_IsArmed3"];
hint _hintText;

sleep 3; // wait a few seconds to allow the player to react

_badCiv enableAI "MOVE";

// make hostile - this could trigger a spot & target callout by friendly AI
[_badCiv] call TRGM_fnc_badCivTurnHostile;

_badCiv doTarget _player;
_badCiv commandFire _player;

_gun = primaryWeapon _badCiv;

sleep 3;
_badCiv fire _gun;
sleep 1;
_badCiv fire _gun;
sleep 1;
_badCiv fire _gun;
