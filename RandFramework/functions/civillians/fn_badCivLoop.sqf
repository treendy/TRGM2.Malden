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
                    _badCiv reveal [_x, 2];
                    [_badCiv,_x] call TRGM_fnc_badCivAttackTargetPlayer;
                    _bFired = true;
                };

            };			
        };
        
    } forEach (nearestObjects [getPos _badCiv,["Man"],10]);
    sleep 2;
};