params ["_badCiv","_target"]; 

(_badCiv getVariable "armament") params ["_gun","_magazine","_amount"];

_badCiv selectWeapon _gun;

_badCiv doTarget _target;
_badCiv commandFire _target; //LOCAL - ?

sleep (random [1,2,4]);

_fireSettings = [ weaponState _badCiv select 1, weaponState _badCiv select 2];

_badCiv forceWeaponFire _fireSettings; 
sleep (random [0.2,1,2]);
_badCiv forceWeaponFire _fireSettings; 
sleep (random [0.2,1,2]);
_badCiv forceWeaponFire _fireSettings; 
