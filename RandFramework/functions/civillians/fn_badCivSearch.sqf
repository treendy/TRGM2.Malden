// addAction handler, runs on the searching player's machine
params ["_badCiv","_player"];

_hintText = selectRandom [localize "STR_TRGM2_civillians_fnbadCivSearch_IsArmed1",localize "STR_TRGM2_civillians_fnbadCivSearch_IsArmed2",localize "STR_TRGM2_civillians_fnbadCivSearch_IsArmed3"];
hint _hintText;

// disable movement during search, then make hostile - this could trigger a spot & target callout by friendly AI
[_badCiv, "MOVE"] remoteExec ["disableAI", _badCiv];
sleep 3; // wait a few seconds to allow the player to react
[_badCiv, "MOVE"] remoteExec ["enableAI", _badCiv];

[_badCiv, _player] remoteExec ["TRGM_fnc_badCivTurnHostile", 2];
