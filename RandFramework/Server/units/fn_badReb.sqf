//if some condition is true, we give this guy a gun and change side

params["_thisCiv"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_bFired = false;

while {alive _thisCiv && !_bFired} do {
    _nearestunits = nearestObjects [getPos _thisCiv,["Man"],10];

    {
        if ((_x in playableunits)) then {
            if (random 1 < .33) then {
                _grpName = createGroup east;
                [_thisCiv] joinSilent _grpName;

                _thisCiv dotarget _x;
                _thisCiv commandFire _x;
                _bFired = true;
            };
        };

    } forEach _nearestunits;
    sleep 2;
};


true;