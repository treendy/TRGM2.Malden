params ["_badCiv"];

(_badCiv getVariable "armament") params ["_gun","_magazine","_amount"];

_bFired = false;
_bActivated = false;

// continiously watch for players and decide to engage or not
while {alive _badCiv && !_bFired} do {
    {
        if ((_x in playableUnits)) then {
            if (selectRandom[true,false,false]) then {
                //load armament

                if (!_bActivated) then {
                    _bActivated = true;
                    
                    [_badCiv] call TRGM_fnc_badCivTurnHostile;
                };
                _cansee = [objNull, "VIEW"] checkVisibility [eyePos _badCiv, eyePos _x];
                if (_cansee > 0.2) then {
                    _badCiv selectWeapon _gun;
    
                    _badCiv doTarget _x;
                    _badCiv commandFire _x; //LOCAL - ?
                    
                    sleep 3;

                    _fireSettings = [ weaponState _badCiv select 1, weaponState _badCiv select 2];

                    _badCiv forceWeaponFire _fireSettings; 
                    sleep 1;
                    _badCiv forceWeaponFire _fireSettings; 
                    sleep 1;
                    _badCiv forceWeaponFire _fireSettings; 
                    _bFired = true;
                };

            };			
        };
        
    } forEach (nearestObjects [getPos _badCiv,["Man"],10]);
    sleep 2;
};