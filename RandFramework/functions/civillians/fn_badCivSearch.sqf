params ["_badCiv","_player"];

_badCiv disableAI "MOVE"; // disable movement during search

_hintText = selectRandom ["This civilian is carrying a gun.","The civilian is armed.","You spot a firearm under his clothes."];
hint _hintText;

sleep 3; // wait a few seconds to allow the player to react

_badCiv enableAI "MOVE";

// make hostile - this could trigger a spot & target callout by friendly AI
[_badCiv] call TRGM_fnc_badCivTurnHostile;

_badCiv reveal [_player, 4];
[_badCiv,_player] call TRGM_fnc_badCivAttackTargetPlayer;