params ["_thisCiv","_player"];

_thisCiv disableAI "MOVE"; // disable movement during search

_hintText = selectRandom ["This civilian is carrying a gun.","The civilian is armed.","You spot a firearm under his cloth."];
hint _hintText;

sleep 3; // wait a few seconds to allow the player to react

_thisCiv enableAI "MOVE";

// make hostile - this could trigger a spot & target callout by friendly AI
_grpName = createGroup east; 
[_thisCiv] joinSilent _grpName;

//get armamanet assigned in entity-init
(_thisCiv getVariable "armament") params ["_gun","_magazine","_amount"];

_thisCiv addMagazines [_magazine,_amount];
_thisCiv addWeapon _gun;

_thisCiv doTarget _player;
_thisCiv commandFire _player;

sleep 3;
_thisCiv fire _gun;
sleep 1;
_thisCiv fire _gun;
sleep 1;
_thisCiv fire _gun;
