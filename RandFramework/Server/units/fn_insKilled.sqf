params  ["_killed","_killer"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + "\n" + format ["InsKilledTest: KilledSide: %1 - KillerSide: %2 - KilledString: %3 - KillerString: %4",side _killed,side _killer,str(_killed),str(_killer)];
publicVariable "TRGM_VAR_debugMessages";

sleep 3;

if (side _killer isEqualTo west && str(_killed) != str(_killer)) then {
    [0.2,format[localize "STR_TRGM2_InsKilled_RebelKilled", name _killer]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;

    _nearestunits = nearestObjects [getPos _killed,["Man","Car","Tank"],2000];
    _grpName = createGroup east;
    {
        _isRebel = _x getVariable ["IsRebel", false];
        if (_isRebel) then {
            [_x] joinSilent _grpName;
        };
    } forEach _nearestunits;
};

true;