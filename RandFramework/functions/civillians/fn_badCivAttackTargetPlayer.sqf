params ["_badCiv","_target"]; 

(_badCiv getVariable "armament") params ["_gun","_magazine","_amount"];

_badCiv selectWeapon _gun;

_badCiv doTarget _target;
_badCiv commandFire _target; //LOCAL - ?

sleep 3;

_fireSettings = [ weaponState _badCiv select 1, weaponState _badCiv select 2];

_badCiv forceWeaponFire _fireSettings; 
sleep 1;
_badCiv forceWeaponFire _fireSettings; 
sleep 1;
_badCiv forceWeaponFire _fireSettings; 
