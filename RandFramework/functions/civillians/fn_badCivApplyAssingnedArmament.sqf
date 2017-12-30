params ["_civilian"];

//get armamanet assigned in entity-init
(_civilian getVariable "armament") params ["_gun","_magazine","_amount"];

_civilian addMagazines [_magazine,_amount];
_civilian addWeapon _gun;